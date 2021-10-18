package com.cinemabox.dao.Notice;

import java.util.List;

import com.cinemabox.dto.Notice.NoticeAnswerDto;
import com.cinemabox.vo.NoticeAnswer;

public interface AnswerDao {
	
	/**
	 * 전체답글 조회
	 * @return
	 */
	List<NoticeAnswer> getAllAnswer();

	/**
	 * 댓글 수정하기 
	 * @return
	 */
	NoticeAnswer getModifyAnswer(NoticeAnswer no);
	
	/**
	 * 댓글 등록
	 * @param NoticeAnswerDto
	 */
	void insertAnswer(NoticeAnswer addNotice);
	
	/**
	 *  지정된 번호로 댓글 삭제하기 
	 * @param no
	 */
	void deletrAnswer(int no);
	
}
