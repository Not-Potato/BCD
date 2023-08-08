package kr.co.bcd.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.bcd.chat.model.dto.ChatMsg;
import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.common.paging.model.PageInfo;

@Repository
public class ChatRoomDao {

	public int selectListCount(String category, SqlSessionTemplate sqlSession) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("category", category);
		return sqlSession.selectOne("chatMapper.selectListCount",paramMap);
	}

	public List<ChatRoom> selectListAll(PageInfo pi, String category, String searchTxt, SqlSessionTemplate sqlSession) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("category", category);
        paramMap.put("searchTxt", searchTxt);
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("chatMapper.selectListAll", paramMap, rowBounds);
	}

	public int createChatRoom(ChatRoom chatRoom, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("chatMapper.createChatRoom" , chatRoom);
	}

	public ChatRoom enterChatRoom(int idx, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("chatMapper.enterChatRoom" , idx);
	}

	public int msgSave(ChatMsg chatMsg, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("chatMapper.msgSave" , chatMsg);
	}

	public void updateParticipants(ChatRoom result, SqlSessionTemplate sqlSession) {
		sqlSession.update("chatMapper.updateParticipants", result);
	}

	public void deleteChatRoom(int idx, SqlSessionTemplate sqlSession) {
		sqlSession.delete("chatMapper.deleteChatRoom" , idx);
	}

	public void deleteChatMsg(int idx, SqlSessionTemplate sqlSession) {
		sqlSession.delete("chatMapper.deleteChatMsg" , idx);
		
	}

	public int modifyChatRoom(ChatRoom chatRoom, SqlSessionTemplate sqlSession) {
		return sqlSession.update("chatMapper.modifyChatRoom", chatRoom);
	}

	public List<ChatMsg> previousChat(int idx, SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("chatMapper.previousChat", idx);
	}

//	public String getParticipants(int idx, SqlSessionTemplate sqlSession) {
//		return sqlSession.selectOne("chatMapper.getParticipants");
//	}

}
