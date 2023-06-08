package com.chuls.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.chuls.domain.MemberVO;
import com.chuls.service.MemberService;
import com.chuls.util.AES256;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberService service;
	
	@Autowired
	BCryptPasswordEncoder passEncoder;
	
	@Autowired
	private AmazonS3 amazonS3;
	
	@Value("#{prod['cloud.aws.s3.bucket']}")
	private String bucket;
	
	// 회원가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception{
		logger.info("get register");
	}
	
	// 회원가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(@Valid MemberVO vo, RedirectAttributes rttr) throws Exception{
		logger.info("post register");
		
		MemberVO idCheck = service.idCheck(vo.getUserId());
		MemberVO userNameCheck = service.userNameCheck(vo.getUserName());
		
		if(idCheck != null || userNameCheck != null) {
			rttr.addFlashAttribute("msg", "register_error");
			return "redirect:/";
		}
		
		MultipartFile file = vo.getPhoto();
		
		String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드
		long size = file.getSize(); //파일 사이즈
		
		System.out.println("파일명 : "  + fileRealName);
		System.out.println("용량크기(byte) : " + size);
		//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
		//		String seperator = File.separator;
		
		/*
				  파일 업로드시 파일명이 동일한 파일이 이미 존재할 수도 있고 사용자가 
				  업로드 하는 파일명이 언어 이외의 언어로 되어있을 수 있습니다. 
				  타인어를 지원하지 않는 환경에서는 정산 동작이 되지 않습니다.(리눅스가 대표적인 예시)
				  고유한 랜던 문자를 통해 DB와 서버에 저장할 파일명을 새롭게 만들어 준다.
		 */
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		String[] uuids = uuid.toString().split("-");
		
		String uniqueName = uuids[0];
		System.out.println("생성된 고유문자열" + uniqueName);
		System.out.println("확장자명" + fileExtension);
		String fileName = uniqueName + fileExtension;
		
		String profile = System.getProperty("spring.profiles.active");

		if(file != null){
			if(profile.equals("local")) {
				logger.info("spring profile = local로 분기 성공!");
				// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
				String uploadFolder = System.getProperty("java.io.tmpdir");
				String pathname = uploadFolder + uniqueName + fileExtension;
				System.out.println(pathname);
				File saveFile = new File(pathname);  // 적용 후
				try {
					file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
					System.out.println("Local DB에 파일 저장 성공!");
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				vo.setFileName(fileName);
			}else if(profile.equals("prod")) {
				logger.info("spring profile = prod로 분기 성공!");
				String profile_image_name = "profile_image/" + uniqueName + fileExtension;
				System.out.println(profile_image_name);
				ObjectMetadata objMeta = new ObjectMetadata();
				objMeta.setContentLength(file.getInputStream().available());
				System.out.println("bucket:" + bucket);
				amazonS3.putObject(bucket, profile_image_name, file.getInputStream(), objMeta);
				System.out.println("AWS S3에 파일 저장 성공!");
				logger.info(amazonS3.getUrl(bucket, profile_image_name).toString());
				vo.setFileName(fileName);
			}
		}
		
		String inputPass = vo.getUserPass();
		String pass = passEncoder.encode(inputPass);
		vo.setUserPass(pass);
		
		AES256 aes256 = new AES256();
		String oldAddress = vo.getAddress();
		String newAddress = aes256.encrypt(oldAddress);
		vo.setAddress(newAddress);
		
		String oldAddress_detail = vo.getAddress_detail();
		if(oldAddress_detail != null) {
			String newAddress_detail = aes256.encrypt(oldAddress_detail);
			vo.setAddress_detail(newAddress_detail);
		}
		
		service.register(vo);
		
		rttr.addFlashAttribute("msg", "register_success");
		return "redirect:/";
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		logger.info("post login");

		String encodedPassword = service.userPassCheck(vo.getUserId()).getUserPass();
		String rawPassword = vo.getUserPass();
		
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		
		boolean passMatch = false;
		
		if(encodedPassword != null) {
			passMatch = passEncoder.matches(rawPassword, encodedPassword);
		}
		
		if(passMatch) {
			AES256 aes256 = new AES256();
			
			String oldAddress = login.getAddress();
			String newAddress = aes256.decrypt(oldAddress);
			login.setAddress(newAddress);
			
			String oldAddress_detail = login.getAddress_detail();
			String newAddress_detail = aes256.decrypt(oldAddress_detail);
			login.setAddress_detail(newAddress_detail);
			
			session.setAttribute("member", login);
			
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", "login_error");
		}
		
		/* if (login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		} else {
			session.setAttribute("member", login);
		} */

		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		logger.info("get logout");

		session.invalidate();

		return "redirect:/";
	}
	
	// 마이페이지 get
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String getMyPage(HttpSession session, Model model) throws Exception {
		logger.info("get myPage");
		
		String profile = System.getProperty("spring.profiles.active");
		model.addAttribute("profile", profile);
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null) {
			return "/home";
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(member.getRegDate());
		model.addAttribute("regDate", date);
		
		if(profile.equals("prod")) {
			String fileName = member.getFileName();
			System.out.println(fileName);
			String imgPath = amazonS3.getUrl(bucket, "profile_image/" + fileName).toString();
			System.out.println("imgPath:" + imgPath);
	        logger.info(imgPath);
	        model.addAttribute("imgPath", imgPath);
		}
		
		return "/member/myPage";
	}
	
	// 회원정보 수정 get
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String getModify(HttpSession session) throws Exception{
		logger.info("get modify");
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null) {
			return "/home";
		}
		
		return "/member/modify";
	}
	
	// 회원정보 수정 post
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(HttpSession session, MemberVO vo, RedirectAttributes rttr) throws Exception{
		logger.info("post modify");
		
		String inputPass = vo.getUserPass();
		String pass = passEncoder.encode(inputPass);
		vo.setUserPass(pass);
		
		service.modify(vo);
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "modifyPOST_success");
		return "redirect:/";
	}
	
	// 회원탈퇴 get
	@RequestMapping(value = "/withdrawal", method = RequestMethod.GET)
	public String getWithdrawal(HttpSession session) throws Exception{
		logger.info("get withdrawal");
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null) {
			return "/home";
		}
		
		return "/member/withdrawal";
	}
	
	// 회원탈퇴 post
	@RequestMapping(value = "/withdrawal", method = RequestMethod.POST)
	public String postWithdrawal(HttpSession session, MemberVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("post withdrawal");

		MemberVO member = (MemberVO) session.getAttribute("member");

		String userId = member.getUserId();
		String oldPass = service.userPassCheck(userId).getUserPass();
		String newPass = vo.getUserPass();

		boolean passMatch = passEncoder.matches(newPass, oldPass);
		
		if (!(passMatch)) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/withdrawal";
		}

		vo.setUserPass(oldPass);
		
		service.withdrawal(vo);
		
		String profile = System.getProperty("spring.profiles.active");
		String fileName = member.getFileName();
		
		if(profile.equals("local")) {
			String deleteFolder = System.getProperty("java.io.tmpdir");
			logger.info(deleteFolder + fileName);
			if(fileName != null && !fileName.trim().isEmpty()) {
				File file = new File(deleteFolder + fileName);
			
				if(file.exists()) { // 파일이 존재하면
					file.delete(); // 파일 삭제
					logger.info("회원탈퇴 요청으로 인해 temp디렉토리의 프로필 사진 삭제 완료!");
				}
			}
		}else if(profile.equals("prod")) {
			String profile_image_name = "profile_image/" + fileName;
			System.out.println(profile_image_name);
			System.out.println("bucket:" + bucket);
			DeleteObjectRequest deleteObjectRequest = new DeleteObjectRequest(bucket, profile_image_name);
			amazonS3.deleteObject(deleteObjectRequest);
			logger.info("회원탈퇴 요청으로 인해 S3의 프로필 사진 삭제 완료!");
		}
		session.invalidate();

		rttr.addFlashAttribute("msg", "withdrawalPOST_success");
		return "redirect:/";
	}
	
	// 회원 아이디 확인
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public int postIdCheck(HttpServletRequest req) throws Exception {
		logger.info("post idCheck");

		String userId = req.getParameter("userId");
		MemberVO idCheck = service.idCheck(userId);

		int result = 0;

		if (idCheck != null) {
			result = 1;
		}

		return result;
	}
	
	// 회원 닉네임 확인
	@ResponseBody
	@RequestMapping(value = "/userNameCheck", method = RequestMethod.POST)
	public int postUserNameCheck(HttpServletRequest req) throws Exception {
		logger.info("post idCheck");

		String userName = req.getParameter("userName");
		MemberVO userNameCheck = service.userNameCheck(userName);

		int result = 0;

		if (userNameCheck != null) {
			result = 1;
		}

		return result;
	}
}
