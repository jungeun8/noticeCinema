package com.cinemabox.service.theater.Notice;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinemabox.dao.Notice.NoticeDao;
import com.cinemabox.dto.Notice.NoticeDetailDto;
import com.cinemabox.dto.Notice.NoticeDto;
import com.cinemabox.dto.Notice.NoticeListDto;
import com.cinemabox.vo.Notice;



@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired NoticeDao noticeDao;
	
	@Override
	public List<Notice> getNoticeAll(NoticeListDto searchData){
		// 공지사항 조회 
		List<Notice> notice = noticeDao.getNoticeAll(searchData);
		// 공지사항을 반환한다.
		return notice;
	}
	
	@Override
	public NoticeDetailDto detailNoticeByNo(int no) {
		// 공지사항 상세 조회 
		return noticeDao.getDetailNoticeByNo(no) ;
	}
	
	@Override
	public void addNotice(NoticeDto addNotice) {
		// 공지 등록 
		 noticeDao.insertNotice(addNotice);
		 
	}
	
	@Override
	public void deleteNotice(int no) {
		// 공지사항 삭제 
		noticeDao.deleteNotice(no);
	}
	
	@Override
	public boolean getdeleteNotice(Notice param) {
		int existNotice = noticeDao.getdeleteNotice(param);
		if (existNotice > 0) {
			return true;
		}else return false; 
		
	}
	@Override
	public void increaseHit(int no) {
		// 조회수 증가 
		noticeDao.increaseHit(no);
		
	}

	@Override
	public void changeNotice(NoticeDetailDto notice) {
		// 공지사항 수정 
		noticeDao.changeNotice(notice);
		
	}

	@Override
	public List<Notice> noticeMain(){
		// 고객센터 공지사항 조회 
		List<Notice> noticeList = noticeDao.noticeMain();
		// 공지사항을 반환한다.
		return noticeList;
	}

	@Override
	public int getPageAllCnt(NoticeListDto searchData) {
		return noticeDao.getPageAllCnt(searchData);
	}
	
	@Override
	public int getNoticeCountByName(Notice param) {
		// 수정글 수 체크
		return noticeDao.getNoticeCountByName(param);
	}

	@Override
	public Notice getModifyNotice(Notice modifyNotice) {
		// 수정 페이지 들어갈때 
		return noticeDao.getModifyNotice(modifyNotice);
	};
}
