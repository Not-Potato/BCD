package kr.co.bcd.chat.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.bcd.chat.model.dao.ChatRoomDao;
import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.common.paging.model.PageInfo;

@Service
public class ChatRoomServiceImpl implements ChatRoomService{
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	public int selectListCount(String category) {
		return chatRoomDao.selectListCount(category, sqlSession);
	}
	public List<ChatRoom> selectListAll(PageInfo pi, String category) {
		return chatRoomDao.selectListAll(pi,category, sqlSession);
	}
	public int createChatRoom(ChatRoom chatRoom) {
		return chatRoomDao.createChatRoom(chatRoom, sqlSession);
	}
	public ChatRoom enterChatRoom(int idx) {
		return chatRoomDao.enterChatRoom(idx, sqlSession);
	}
}
