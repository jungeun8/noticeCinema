package com.cinemabox.dao.Notice;

import java.util.List;

import com.cinemabox.vo.Coment;

public interface ComentDao {	
	
	/**
	 * 전체 댓글 정보를 반환함
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
	void deleteComent(int no);
	
	/**
	 *  댓글을 수정함
	 * @param pwd
	 */
	void updateComent(String pwd);
	
	
	
	

}
