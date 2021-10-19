package com.cinemabox.service.theater.Notice;

import java.util.List;

import com.cinemabox.dto.Notice.AnswerDto;
import com.cinemabox.vo.NoticeAnswer;

public interface NoticeAnswerService {

	List<NoticeAnswer> getAllAnswer(AnswerDto answer);
	// 답변 전체 조회

	NoticeAnswer getModifyAnswer(NoticeAnswer modify);
	// 답변 수정하기 위해 확인

	void updateAnswer(NoticeAnswer list);
	// 답변 수정 

	void insertAnswer(NoticeAnswer addNotice);
	// 답변 추가 

	void deleteAnswer(int no);
	// 답변삭제 

	boolean deleteAnswerCnt(NoticeAnswer delete);
	// 답변 유무 확인 

	int getPageAllCnt();
	// 페이지 수

	

	

	
	
	
	
}
