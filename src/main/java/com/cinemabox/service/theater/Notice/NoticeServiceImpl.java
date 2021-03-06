package com.cinemabox.service.theater.Notice;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cinemabox.dao.Notice.AnswerDao;
import com.cinemabox.dao.Notice.FileItemDao;
import com.cinemabox.dao.Notice.NoticeDao;
import com.cinemabox.dto.Notice.NoticeAnswerDto;
import com.cinemabox.dto.Notice.NoticeDetailDto;
import com.cinemabox.dto.Notice.NoticeDto;
import com.cinemabox.dto.Notice.NoticeListDto;
import com.cinemabox.dto.Notice.NoticeSeqDto;
import com.cinemabox.vo.FileItem;
import com.cinemabox.vo.Notice;



@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired NoticeDao noticeDao;
	@Autowired AnswerDao answerDao;
	@Autowired FileItemDao fileDao;
	
	@Override
	public List<Notice> getNoticeAll(NoticeListDto searchData){
		// 공지사항 조회 
		List<Notice> notice = noticeDao.getNoticeAll(searchData);
		for(int i=0; i<notice.size(); i++) {
			Notice item = notice.get(i); // 게시글 
			if(notice.get(i).getDepth()>0) {
				
				System.out.println("게시글["+i+"] :" + item.toString());
				// 삭제 상태값에 따라서 제목 다르게 보이기 
				if(item.getStatus() == 1) {
					item.setTitle("   ".repeat(item.getDepth())+"▶︎RE:"+item.getTitle());
				}else if(item.getStatus() == 0) {
					item.setTitle("   ".repeat(item.getDepth())+"▶︎RE: 삭제된 글입니다.");
					System.out.println("title : " + item.getTitle());
				}
				//item.setTitle("   ".repeat(item.getDepth())+"▶︎RE:"+item.getTitle());
				notice.set(i, item);
				System.out.println("item의 결과===>"+ item.getParNum());
			}else {
				System.out.println("게시글["+i+"] :" + item.toString());
				if(item.getStatus() == 0) {
					item.setTitle("삭제된 글입니다.");
					notice.set(i, item);
				}
			}
			
		}
		
		// 공지사항을 반환한다.
		return notice;
	}
	@Override
	public List<Notice> getNoticeNo(NoticeListDto parName){
		// 원글에만 번호 조회 
		List<Notice> noticeNo = noticeDao.getNoticeNo(parName);
		return noticeNo;
	}
	
	
	
	@Override
	public NoticeDetailDto detailNoticeByNo(int no) {
		// 공지사항 상세 조회
		List<FileItem> item = fileDao.getAllFiles(no);
		for(int i=0; i<item.size(); i++) {
			FileItem file = item.get(i);
			file.setFilesize((Math.round(file.getFilesize() /1024/ 1024 * 100) / 100));
			
		}
		
		return noticeDao.getDetailNoticeByNo(no) ;
	}
	
	@Override
	public int addNotice(NoticeDto addNotice) {
		// 공지 등록 
		noticeDao.insertNotice(addNotice);
		return addNotice.getNo();
	}
	

	@Override
	@Transactional
	public int addNoticeAnswer(NoticeAnswerDto notice) {
		// 공지 답글 등록
		NoticeSeqDto noticeSeqParam = new NoticeSeqDto();
		notice.setSeq(notice.getSeq()+1);
		noticeSeqParam.setSeq(notice.getSeq());
		noticeSeqParam.setParNo(notice.getParNo());
		noticeDao.updateNoticeSeq(noticeSeqParam);
		noticeDao.insertNoticeAnswer(notice);
//		int newSeq = notice.getSeq();
//		newSeq += newSeq;
		return notice.getNo();
		
	};
	
	@Override
	public void deleteNotice(int no) {
		// 공지사항 삭제 
		noticeDao.updateNoticeSeqMinus(no);
		noticeDao.deleteNotice(no);
		
	}
	
	@Override
	public String getdeleteNotice(Notice param) {

//		// 댓글이 있는경우 
		if(noticeDao.getComentCnt(param.getNo()) > 0 ) return "existComment";
//		// 답글이 있는경우
//		if(noticeDao.getAnswerCnt(param) > 0 ) return "existAnswer";
		boolean existAnswer = false;
		// 답글이 있는 경우 삭제 (삭제 표시)
		if(noticeDao.getAnswerCnt(param)>0) {
			param.setStatus(0);
			existAnswer = true;
		}
		// 답글이 없는 경우 삭제 (완전삭제) 사실상 필요없음 왜냐하면 실제로 디비에서 나중에 지우기 때문
		else if (noticeDao.getAnswerCnt(param)==0) {
			param.setStatus(4);
		}
			int existNotice = noticeDao.getdeleteNotice(param);
			if (existNotice > 0) {
				if(existAnswer) {
					noticeDao.deleteStatus(param);
					return "existAnswer";
				}
				return "success";
			}return "notPwd";// 비밀번호가 틀린경우
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
	}
	
	@Override
	public int getComentCnt(int no) {
		
		return noticeDao.getComentCnt(no);
	}
	
	
	@Override
	public List<Notice> getNoticeAllExcel(NoticeListDto searchData) {
		// 공지사항 조회 
				List<Notice> notice = noticeDao.getNoticeAllExcel(searchData);
				for(int i=0; i<notice.size(); i++) {
					Notice item = notice.get(i); // 게시글 
					if(notice.get(i).getDepth()>0) {
						
						System.out.println("게시글["+i+"] :" + item.toString());
						// 삭제 상태값에 따라서 제목 다르게 보이기 
						if(item.getStatus() == 1) {
							item.setTitle("   ".repeat(item.getDepth())+"▶︎RE:"+item.getTitle());
						}else if(item.getStatus() == 0) {
							item.setTitle("   ".repeat(item.getDepth())+"▶︎RE: 삭제된 글입니다.");
							System.out.println("title : " + item.getTitle());
						}
						//item.setTitle("   ".repeat(item.getDepth())+"▶︎RE:"+item.getTitle());
						notice.set(i, item);
						System.out.println("item의 결과===>"+ item.getParNum());
					}else {
						System.out.println("게시글["+i+"] :" + item.toString());
						if(item.getStatus() == 0) {
							item.setTitle("삭제된 글입니다.");
							notice.set(i, item);
						}
					}
					
				}
				
				// 공지사항을 반환한다.
				return notice;
	}

	

	
}
