package com.cinemabox.dao.Notice;

import java.util.List;

import com.cinemabox.dto.Notice.AnswerDto;
import com.cinemabox.dto.Notice.NoticeListDto;
import com.cinemabox.vo.Notice;
import com.cinemabox.vo.NoticeAnswer;

public interface AnswerDao {
	
	/**
	 * 전체답글 조회
	 * @return
	 */
	List<NoticeAnswer> getAllAnswer(AnswerDto answer);
	
	/**
	 * 공지사항 페이지수 
	 * @param searchData
	 * @return
	 */
	int getPageAllCnt();
	
	/**
	 * 댓글 수 
	 * @param searchData
	 * @return
	 */
	int getComentCnt(int no);


	/**
	 * 댓글 수정하기 
	 * @return
	 */
	Integer getModifyAnswer(NoticeAnswer modify);
	
	/**
	 * 수정
	 * @param list
	 */
	Integer updateAnswer(NoticeAnswer list);
	
	/**
	 * 댓글 등록
	 * @param NoticeAnswerDto
	 */
	void insertAnswer(NoticeAnswer addNotice);
	
	/**
	 *  지정된 번호로 공지 내용 삭제하기 
	 * @param no
	 */
	Integer deleteAnswer(int answerNo);
	
	
	/**
	 *  지정된 번호로 댓글 삭제하기 
	 * @param no
	 */
	Integer deleteAnswerCnt(NoticeAnswer delete);
	
}
