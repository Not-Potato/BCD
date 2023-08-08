package kr.co.bcd.chat.model.service;

import java.util.List;

import kr.co.bcd.chat.model.dto.ChatMsg;
import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.common.paging.model.PageInfo;

public interface ChatRoomService {
	
	int selectListCount(String category);
	List<ChatRoom> selectListAll(PageInfo pi, String category, String searchTxt);
	//String getParticipants(int idx);
	int createChatRoom(ChatRoom chatRoom);
	ChatRoom enterChatRoom(int idx);
	int msgSave(ChatMsg chatMsg);
	void deleteChatRoom(int idx);
	void deleteChatMsg(int idx);
	int modifyChatRoom(ChatRoom chatRoom);
	List<ChatMsg> previousChat(int idx);
}
