package com.cinemabox.dao.Notice;

import java.util.List;

import com.cinemabox.dto.Notice.NoticeAnswerDto;
import com.cinemabox.dto.Notice.NoticeDetailDto;
import com.cinemabox.dto.Notice.NoticeDto;
import com.cinemabox.dto.Notice.NoticeListDto;
import com.cinemabox.dto.Notice.NoticeSeqDto;
import com.cinemabox.dto.Question.QuestionDto;
import com.cinemabox.vo.Notice;

public interface NoticeDao {
	
	/**
	 * 전체공지사항 조회 
	 * @param searchData 
	 * @return no
	 */
	List<Notice> getNoticeAll(NoticeListDto searchData);
	/**
	 * 댓글 수 있으면 글을 삭제할 수 없음  
	 * @param searchData 
	 * @return no
	 */
	int getComentCnt(int no);
	
	/**
	 * 원글에만 번호 나오기 
	 * @param parName
	 * @return
	 */
	List<Notice> getNoticeNo(NoticeListDto parName);

	/**
	 * 번호로 공지사항 상세 조회 
	 * @return
	 */
	NoticeDetailDto getDetailNoticeByNo(int no);
	
	/**
	 * 수정사항
	 * @return
	 */
	Notice getModifyNotice(Notice modifyNotice);
	
	/**
	 * 공지하기 
	 * @param NoticeDto
	 */
	void insertNotice(NoticeDto addNotice);
	
	/**
	 * 답글등록
	 * @param NoticeAnswerDto
	 */
	void insertNoticeAnswer(NoticeAnswerDto addNotice);
	
	/**
	 * 답글등록시 시퀀스 수
	 * @param noticeSeqParam
	 */
	void updateNoticeSeq(NoticeSeqDto noticeSeqParam);
	
	/**
	 *  지정된 번호로 공지 내용 삭제하기 
	 * @param no
	 */
	void deleteNotice(int no);
	
	/**
	 * 조회수 증가 
	 * @param importNotice
	 */
	void increaseHit(int no);
	
	/**
	 *  공지사항 수정하기 
	 * @param no
	 */
	void changeNotice(NoticeDetailDto no);

	/**
	 *  고객센터 메인페이지에 공지사항 추가
	 * @return
	 */
	List<Notice> noticeMain();

	/**
	 * 공지사항 페이지수 
	 * @param searchData
	 * @return
	 */
	int getPageAllCnt(NoticeListDto searchData);
	
	/**
	 * 이름과 비밀번호를 이용하여 등록된 공지글을 조회함
	 * @param param
	 * @return
	 */
	int getNoticeCountByName(Notice param);

	/**
	 * 비번일치여부 삭제
	 * @param param
	 * @return
	 */
	int getdeleteNotice(Notice param);
	
	/**
	 * 답변 수 
	 * @param param
	 * @return
	 */
	int getAnswerCnt(Notice param);
	
	/**
	 *  공지 글 삭제시 시퀀스 줄이기 
	 * @param no
	 */
	void updateNoticeSeqMinus(int no);
	
	/**
	 *
	 */
	int deleteStatus(Notice param);
	
	/*
	 * 엑셀 다운로드를 위한 게시글 조회
	 * */
	List<Notice> getNoticeAllExcel(NoticeListDto searchData);
}
