# myBoard
Spring + JSP _ 게시판 사이트


## 🖥️ 프로젝트 소개
1인 개발한 로그인 기능과 댓글 기능이 있는 게시판 사이트입니다.


## 🕰️ 개발 기간
* 23.05.11 - 23.06.12

### ⚙️ 개발 환경
- **Language** : Java 8
- **IDE** : STS
- **Framework** : Spring Framework(4.3.8)
- **Database** : MariaDB(10.6.10)
- **ORM** : Mybatis

## 📌 기능 구현
#### 로그인
- 아이디, 패스워드 유효성 검사
- 로그인 시 세션(Session) 생성
#### 로그아웃
- 세션(Session) 무효화
#### 회원가입
- 주소 API 연동
- ID, 닉네임 중복 체크
- 비밀번호 Hash값 저장
- 주소 암호화해서 저장
- 프로필 사진 AWS S3에 저장
#### 마이 페이지
- AWS S3 프로필 사진 파일 보여주기
#### 회원정보 수정
#### 회원탈퇴
#### 글 목록
- Pagination 구현
- 검색 기능 구현
#### 글 작성
- 글 제목, 글 내용, 작성자 닉네임 유효성 검사
#### 글 수정
- 글 제목, 글 내용, 작성자 닉네임 유효성 검사
#### 글 삭제
#### 댓글 작성
#### 댓글 수정
#### 댓글 삭제
#### 기타 기능
- favicon.ico 생성

### 🚀 배포
- **Server** : AWS EC2 (Ubuntu)
- **Database** : AWS RDS (MariaDB)
- **Storage** : AWS S3
