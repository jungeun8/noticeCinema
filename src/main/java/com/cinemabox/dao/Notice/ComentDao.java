package com.cinemabox.dao.Notice;

import java.util.List;

import com.cinemabox.dto.Notice.ComentDto;
import com.cinemabox.dto.Notice.ComentModifyDto;
import com.cinemabox.vo.Coment;

public interface ComentDao {	
	
	/**
	 * 전체 댓글 정보를 조회
	 * @param no
	 * @return
	 */
	List<Coment> getAllComent();
	
	/**
	 * 새 댓글을 등록함
	 * @param answer
	 */
	void insertComent(Coment answer);
	
	/**
	 * 댓글 삭제함
	 * @param no
	 */
	Integer deleteComent(ComentModifyDto deleteList);
	
	/**
	 *  댓글을 수정함
	 * @param pwd
	 */
	Integer updateComent(ComentModifyDto updateList);
	
	/**
	 * 게시글 총 페이지 수
	 * @param page
	 * @return
	 */
	int getPageAllCnt(ComentDto page);
	
	

}
