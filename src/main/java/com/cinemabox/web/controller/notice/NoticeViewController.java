package com.cinemabox.web.controller.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cinemabox.dto.Notice.AnswerDto;
import com.cinemabox.dto.Notice.NoticeAnswerDto;
import com.cinemabox.dto.Notice.NoticeDetailDto;
import com.cinemabox.dto.Notice.NoticeDto;
import com.cinemabox.dto.Notice.NoticeListDto;
import com.cinemabox.dto.Notice.ParNoticeDto;
import com.cinemabox.dto.Question.QuestionDto;
import com.cinemabox.service.theater.Notice.NoticeAnswerService;
import com.cinemabox.service.theater.Notice.NoticeService;
import com.cinemabox.vo.Notice;
import com.cinemabox.vo.NoticeAnswer;



@Controller
@RequestMapping("/notice")
public class NoticeViewController {
	
	// NoticeService를 컨트롤러에 매핑 ( 컨트롤러 어디서든 사용할수 있게 )
	@Autowired
	NoticeService noticeService;
	@Autowired
	NoticeAnswerService answerService;

	/**
	 * 공지사항리스트를 조회하여 공지사항 페이지를 호출
	 * @param model 뷰페이지에 전달할 데이터를 담는 객체, HadlerAdapter객체가 Model를 생성해서 전달함
	 * @return 뷰페이지의 이름 (공지사항 페이지)
	 */
	@GetMapping("/list")
	public String Notice(NoticeListDto searchData, Model model) {
		int page = searchData.getPage();
		searchData.setStartPage(((page-1)*10)+1);
		searchData.setEndPage(10*page);
		System.out.println("searchData ==> "+searchData.toString());
		// 공지사항 리스트 조회하기
		List<Notice> noticeList = noticeService.getNoticeAll(searchData);
		noticeList.get(0).toString();
		int pageAllCnt = noticeService.getPageAllCnt(searchData);
		System.out.println("controller pageAllCnt ====>" + pageAllCnt);
		// 댓글 수 카운트
//		int countComent = noticeService.getComentCnt();
		// 뷰 페이지에 공지사항 목록 전달하기
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageAllCnt", pageAllCnt);
		model.addAttribute("page", page);
		model.addAttribute("searchWord", searchData.getSearchWord());
		model.addAttribute("startPage", searchData.getStartPage());
		model.addAttribute("endPage", searchData.getEndPage());
		model.addAttribute("seq", searchData.getSeq());
		model.addAttribute("parNo", searchData.getParNo());
		model.addAttribute("depth", searchData.getDepth());
//		model.addAttribute("countComent", countComent);
		// 뷰페이지로 내부이동하기
		// /WEB-INF/views/notice/noticeMain.jsp로 내부이동해서 JSP 실행시키기
		return "notice/noticeMain";
	}
	
	/**
	 * 공지 사항 세부페이지 호출  
	 * @param no
	 * @param model
	 * @return
	 */
	@GetMapping("/detail")
	public String details(AnswerDto answer,int no,  Model model) {
		int page = answer.getPage();
		answer.setStartPage(((page-1)*10)+1);
		answer.setEndPage(10*page);
		NoticeDetailDto noticeDetail = noticeService.detailNoticeByNo(no);
		List<NoticeAnswer> list = answerService.getAllAnswer(answer);
		int pageAllCnt = answerService.getPageAllCnt();
	System.out.println("list 내용 보이기!!!!======>"+list);
	
		model.addAttribute("noticeDetail", noticeDetail);	
		model.addAttribute("no", no);
		model.addAttribute("seq", noticeDetail.getSeq());
		model.addAttribute("parNo", noticeDetail.getParNo());
		model.addAttribute("depth", noticeDetail.getDepth());
		model.addAttribute("pageAllCnt", pageAllCnt);
		model.addAttribute("page", page);
		model.addAttribute("list", list);
		model.addAttribute("content",answer.getContent());
		model.addAttribute("answerNo", answer.getAnswerNo());
		model.addAttribute("startPage", answer.getStartPage());
		model.addAttribute("endPage", answer.getEndPage());
		return "notice/detailNotice";
	}

	/**
	 * 공지 글 삭제 후 메인페이지 호출 
	 * @param no
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping("/delete")
	public String delete(@RequestParam int no,  RedirectAttributes redirectAttributes) {
		noticeService.deleteNotice(no);
		redirectAttributes.addAttribute("no", no);	
		return "redirect:list";
	}
	/**
	 * 답글 삭제 후 메인페이지 호출 
	 * @param no
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping("/deleteComent")
	public String deleteAnswer(@RequestParam int answerNo,  RedirectAttributes redirectAttributes) {
		noticeService.deleteNotice(answerNo);
		redirectAttributes.addAttribute("answerNo", answerNo);	
		return "redirect:detail";
	}
	
	/**
	 * 댓글 추가 후 페이지이동
	 * @param addNotice
	 * @return
	 */
	@RequestMapping("/answerInsert")
	public String insertAnswer(NoticeAnswer addNotice, RedirectAttributes redirectAttributes) {
		answerService.insertAnswer(addNotice);
		return "redirect:list";
	}

	/**
	 * 공지 사항 글 추가 후 페이지 이동
	 * @param no
	 * @param model
	 * @return
	 */
	@RequestMapping("/insert")
	public String insertNotice(NoticeDto notice, RedirectAttributes redirectAttributes) {
		System.out.println("notice ==>"+notice.toString());
		notice.setImportant("true".equals(notice.getImportant())?"1":"0");
		noticeService.addNotice(notice);
		return "redirect:list";
	}
	
	/**
	 * 공지 사항 답글추가 후 페이지이동
	 * @param no
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertAnswer")
	public String insertAnswerNotice(NoticeAnswerDto notice, RedirectAttributes redirectAttributes) {
		noticeService.addNoticeAnswer(notice);
		System.out.println("답변parNo: ===>" + notice );
		return "redirect:list";
	}
	
	/**
	 * 답글 추가 페이지
	 * @param no
	 * @param redirectAttributes
	 * @return
	 */
	@GetMapping("/addAnswer")
	public String addAnswer(ParNoticeDto answer, Model model) {
		model.addAttribute("no",answer.getNo());
		model.addAttribute("parNo",answer.getParNo());
		model.addAttribute("seq",answer.getSeq());
		model.addAttribute("depth",answer.getDepth());
		return "notice/insertAnswerNotice";
	}
	
	
	
	/**
	 * 공지 글 추가 페이지
	 * @param no
	 * @param redirectAttributes
	 * @return
	 */
	@GetMapping("/add")
	public String addNotice() {
		return "notice/insertNotice";
	}
	
	/**
	 * 공지 글 수정 폼페이지
	 * @param no
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping("/modify")
	public String modifyNotice(Notice list, Model model) throws Exception{
		Notice noticeDetail = noticeService.getModifyNotice(list);
		model.addAttribute("noticeDetail", noticeDetail);
		return "notice/modifyNotice";
	}
	
	/**
	 * 공지 사항 수정 후 페이지 이동 
	 * @param no
	 * @param model
	 * @return
	 */
	@RequestMapping("/newModify")
	public String newNotice(NoticeDetailDto notice,  RedirectAttributes redirectAttributes) {
		noticeService.changeNotice(notice);
		redirectAttributes.addAttribute("no", notice.getNo());
		return "redirect:list";
	}
	
	/**
	 * 글 수정 전 작성자, 비밀번호 입력
	 * @param no
	 * @param redirectAttributes
	 * @return
	 */
	@GetMapping("/confirm")
	public String confirm(int no, Model model) {
		// List<Notice> noticeList = noticeService.noticeMain();
		model.addAttribute("no",no);
		return "notice/confirm";
	}
	
	
	/**
	 * 작성자, 비밀번호 입력 후 작성한 글 수정 
	 * @param param
	 * @return
	 */
	@RequestMapping("/list/modify")
	public @ResponseBody ResponseEntity<Integer> getNoticeCountByName(Notice param) {
		int result = noticeService.getNoticeCountByName(param);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	/**
	 * 삭제
	 * @param model
	 * @return
	 */
	@RequestMapping("/deleteList")
	public @ResponseBody ResponseEntity<String> deleteList(Notice delete) {
		String resultMessage = noticeService.getdeleteNotice(delete); 
		return new ResponseEntity<String>( resultMessage, HttpStatus.OK);
	}
	
	/**
	 * 댓글 수정
	 * @param model
	 * @return
	 */
	@RequestMapping("/modifyList")
	public @ResponseBody ResponseEntity<Boolean> updateAnswer(NoticeAnswer list) {
		Boolean result;
		if(answerService.getModifyAnswer(list)) {
			int resultModify = answerService.updateAnswer(list);
			if(resultModify >0) {
				result = true;
			}else {
				result = false;
			}
		}else{
			result =false;
		}
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	
	/**
	 * 댓글 삭제 
	 * @param model
	 * @return
	 */
	@RequestMapping("/deleteAnswer")
	public @ResponseBody ResponseEntity<Boolean> deleteAnswer(NoticeAnswer list) {
		Boolean result;
		if( answerService.deleteAnswerCnt(list)) { //만약 삭제할 데이터가 있다면
			int resultDelete = answerService.deleteAnswer(list.getAnswerNo());
			if(resultDelete > 0) {
				result = true;
			}else {
				result = false;
			}
			
		}else { // 데이터가 없는경우 false 반환
			result = false;
		}
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
}
