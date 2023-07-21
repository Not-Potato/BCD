package kr.co.bcd.member.model.service;

<<<<<<< HEAD
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.bcd.member.model.dao.MemberDao;
import kr.co.bcd.member.model.dto.Member;
=======
import org.springframework.stereotype.Service;
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git

<<<<<<< HEAD

@Service
public class MemberServiceImpl implements MemberService {
=======
import kr.co.bcd.member.model.dto.Member;
@Service
public class MemberServiceImpl {
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git
	
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;

	
	//public Member detailMember(int idx) {
		//return memberDao.detailMember(sqlSession, idx);
		//return null;
	//}
	
	@Override
	public int register (Member member) {
		return memberDao.register(sqlSession, member);
	}
}
