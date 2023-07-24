package kr.co.bcd.chat.model.service;

import java.util.List;

import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.common.paging.model.PageInfo;

public interface ChatRoomService {
	
	int selectListCount(String category);
	List<ChatRoom> selectListAll(PageInfo pi, String category);
	//String getParticipants(int idx);
	int createChatRoom(ChatRoom chatRoom);
}
