package kr.co.bcd.chat.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.bcd.chat.model.dao.ChatRoomDao;
import kr.co.bcd.chat.model.dto.ChatMsg;
import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.common.paging.model.PageInfo;


@Service
public class ChatRoomServiceImpl implements ChatRoomService{
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	public int selectListCount(String searchTxt, String category) {
		return chatRoomDao.selectListCount(searchTxt, category, sqlSession);
	}
	public List<ChatRoom> selectListAll(PageInfo pi, String category, String searchTxt) {
		return chatRoomDao.selectListAll(pi,category,searchTxt, sqlSession);
	}
	public int createChatRoom(ChatRoom chatRoom) {
		return chatRoomDao.createChatRoom(chatRoom, sqlSession);
	}
	public ChatRoom enterChatRoom(int idx) {
		return chatRoomDao.enterChatRoom(idx, sqlSession);
	}
	public int msgSave(ChatMsg chatMsg) {
		return chatRoomDao.msgSave(chatMsg, sqlSession);
	}
	public void updateParticipants(ChatRoom result) {
		chatRoomDao.updateParticipants(result, sqlSession);
	}
	public void deleteChatRoom(int idx) {
		chatRoomDao.deleteChatRoom(idx, sqlSession);
	}
	public void deleteChatMsg(int idx) {
		chatRoomDao.deleteChatMsg(idx,sqlSession);
		
	}
	public int modifyChatRoom(ChatRoom chatRoom) {
		return chatRoomDao.modifyChatRoom(chatRoom, sqlSession);
	}
	public List<ChatMsg> previousChat(int idx) {
		return chatRoomDao.previousChat(idx, sqlSession);
	}
}
