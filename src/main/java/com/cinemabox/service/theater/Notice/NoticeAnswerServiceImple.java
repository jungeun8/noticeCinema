package com.cinemabox.service.theater.Notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinemabox.dao.Notice.AnswerDao;
import com.cinemabox.dto.Notice.AnswerDto;
import com.cinemabox.vo.NoticeAnswer;

@Service
public class NoticeAnswerServiceImple implements NoticeAnswerService{
	
	@Autowired AnswerDao answerDao;
	
	@Override
	public List<NoticeAnswer> getAllAnswer(AnswerDto answer){
		List<NoticeAnswer> list = answerDao.getAllAnswer(answer);
		// 답변 전체 조회
		return list;
		
	}
	
	@Override
	public Boolean getModifyAnswer(NoticeAnswer modify){
		// 답변 수정하기 위해 확인
		int existNotice = answerDao.getModifyAnswer(modify);
		if(existNotice > 0) {
			return true;
		}else {
			return false;
		}
		
	}
	
	@Override
	public int updateAnswer(NoticeAnswer list){
		// 딥뱐 수정
		return answerDao.updateAnswer(list);
		
	}
	@Override
	public void insertAnswer(NoticeAnswer addNotice){
		// 답변 등록 
		answerDao.insertAnswer(addNotice);
	}
	@Override
	public int deleteAnswer(int answerNo){
		// 답변삭제 
		return answerDao.deleteAnswer(answerNo);
	}
	@Override
	public boolean deleteAnswerCnt(NoticeAnswer delete) {
		// 답변 유무 확인 
		int existNotice = answerDao.deleteAnswerCnt(delete);
		if (existNotice > 0) {
			return true;
		}else return false; 
		
	}
	
	@Override
	public int getPageAllCnt() {
		// 페이지 수
		return answerDao.getPageAllCnt();
	}

}
