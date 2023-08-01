# BCD : Final Team Project
> ”삶은 선택의 연속이지! 하지만 나 대신 골라 줘!”  
>
> **사용자 커스텀 투표 게시**를 주요 소재로 한 게시판 웹 사이트 개발 프로젝트

<br />   

### 사용된 기술 스택
- Spring
- MyBatis
- Maven
- JSTL
- JDBC
- Oracle

<br />   

### 팀원 소개 & 담당 기능 소개
- **김자연**  `팀장`
  - 게시글(+투표, 댓글) 관련 모든 기능 전담
    - 게시글 작성/열람/수정/삭제
    - 댓글 작성/열람/수정/삭제
    - 투표 게시/참여 등
     
- **이형주**
  - 회원 관련 모든 기능 전담
    - 일반 회원 가입/로그인
    - API를 이용한 소셜 회원 가입/로그인
    - 마이 페이지를 통한 회원 정보 수정
    - 회원 탈퇴
 
- **서수현**
  - 실시간 채팅 관련 모든 기능 전담
    - 채팅방 개설
    - 채팅방 목록 조회
    - 수/발신 등 채팅 기능 구현
 
<br />    

### 주요 기능
#### [프로젝트 요구사항]
```
1. 회원은 "일반 회원가입"과 "소셜 회원가입" 중 선택하여 가입할 수 있습니다.
2. "소셜 회원가입"을 이용해 가입한 회원은 소셜 정보를 이용해 회원가입이 가능합니다! 
3. "일반 회원가입"을 이용해 가입한 회원은 아이디와 비밀번호를 통해 로그인합니다.
4. 회원은 마이페이지 내에서 본인의 정보를 열람 및 수정할 수 있으며, 탈퇴할 수 있습니다.
5. 회원은 글 작성 시 투표 관련 정보를 포함할 수 있습니다. (투표 제목, 선택지 1, 선택지 2, 마감 기한 등)
6. 회원은 원하는 필터를 적용하여 글을 조회할 수 있고, 상세 페이지로 접근하여 해당 글의 내용과 투표 관련 내용을 열람할 수 있습니다.
7. 글 게시자를 포함해서 회원은 각 게시글마다 1 회 투표에 참여할 수 있습니다.
8. 단, 마감된 투표에는 참여할 수 없습니다.
9. 게시글 작성 시 최초에 설정된 마감 기한이 도래하면 투표는 자동으로 마감 상태로 변경되고, 글 게시자는 "즉시 마감" 버튼을 통해 최초에 입력했던 마감 기한과 관계 없이 그 즉시 투표를 마감할 수 있습니다.
10. 투표가 마감되면 게시글에는 더 많이 선택된 선택지를 [투표 결과]로 표시해 주고, 글 게시자는 "후기"를 작성할 수 있습니다.
11. 투표 참여자는 "취소" 버튼을 통해 참여를 철회할 수 있고, 재참여가 가능합니다.
12. 회원은 게시글마다 댓글을 작성할 수 있고, 본인이 작성한 댓글에 한해 댓글을 수정/삭제할 수 있습니다.
13. 회원은 원하는 필터를 적용하여 채팅방을 조회할 수 있고, 채팅방에 입장하여 접속한 타 회원과 실시간 채팅을 나눌 수 있습니다.
```
----
#### [게시글 관련] `김자연`   
> 게시글 작성/열람/수정/삭제
  1. 업데이트 예정입니다.
     
> 댓글 작성/열람/수정/삭제
  1. 업데이트 예정입니다.

> 투표 게시/참여
  1. 업데이트 예정입니다.

----
#### [회원 관련] `이형주`  


----
#### [채팅 관련] `서수현`  

