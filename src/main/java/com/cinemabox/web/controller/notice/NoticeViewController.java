package com.cinemabox.web.controller.notice;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cinemabox.dto.Notice.AnswerDto;
import com.cinemabox.dto.Notice.FileDto;
import com.cinemabox.dto.Notice.NoticeAnswerDto;
import com.cinemabox.dto.Notice.NoticeDetailDto;
import com.cinemabox.dto.Notice.NoticeDto;
import com.cinemabox.dto.Notice.NoticeListDto;
import com.cinemabox.dto.Notice.ParNoticeDto;
import com.cinemabox.dto.Question.QuestionDto;
import com.cinemabox.service.theater.Notice.FileService;
import com.cinemabox.service.theater.Notice.NoticeAnswerService;
import com.cinemabox.service.theater.Notice.NoticeService;
import com.cinemabox.vo.FileItem;
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
	@Autowired
	FileService fileService;
	@Autowired
	DownloadView downloadView;

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
		int pageAllCnt = noticeService.getPageAllCnt(searchData);
		System.out.println("controller pageAllCnt ====>" + pageAllCnt);
		System.out.println("검색 카운트  ====>" + searchData.getSearchCnt());
		// 댓글 수 카운트
//		int countComent = noticeService.getComentCnt();
		// 뷰 페이지에 공지사항 목록 전달하기
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageAllCnt", pageAllCnt);
		model.addAttribute("page", page);
		model.addAttribute("searchCnt", noticeList.size() > 0 ? noticeList.get(0).getSearchCnt() : 0);
		model.addAttribute("searchWord", searchData.getSearchWord());
		model.addAttribute("startPage", searchData.getStartPage());
		model.addAttribute("endPage", searchData.getEndPage());
		model.addAttribute("seq", searchData.getSeq());
		model.addAttribute("parNo", searchData.getParNo());
		model.addAttribute("depth", searchData.getDepth());
		model.addAttribute("fileList", fileService.getAllFiles(searchData.getNo()));
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
		noticeService.increaseHit(no);
		int page = answer.getPage();
		answer.setStartPage(((page-1)*10)+1);
		answer.setEndPage(10*page);
		NoticeDetailDto noticeDetail = noticeService.detailNoticeByNo(no);
		List<NoticeAnswer> list = answerService.getAllAnswer(answer);
		int pageAllCnt = answerService.getPageAllCnt();
//		//  파일 업로드 조회 filename.substring(13);
//		FileItem fileItem = new FileItem();
//		model.addAttribute("originalFilename", fileItem.getOriginalFilname());
		model.addAttribute("fileList", fileService.getAllFiles(no));
		// 공지 세부사항
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
	 * 답글 삭제 후 세부페이지 호출 
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
		int noticeNo = noticeService.addNotice(notice);
		System.out.println("noticeNo : " + noticeNo);
		// 모든 첨부파일객체를 조회하기
				List<MultipartFile> uploadFiles = notice.getUpfiles();
				
				// 데이터베이스에 저장할 파일아이템(FileItem)객첼 저장하는 ArrayList객체를 생성한다.
				List<FileItem> fileItems = new ArrayList<>();
				FileDto fileAdd = new FileDto();
				// List에 저장된 MultipartFile를 하나씩 순회처리한다.
				for (MultipartFile uploadFile : uploadFiles) {
					
					// MultipartFile객체에 첨부파일 정보가 포함되어 있는지 체크한다.
					if (!uploadFile.isEmpty()) {
						// 첨부파일의 이름을 조회하고, 중복을 방지하기 위해서 유닉스타임을 파일이름에 붙인다.
//						String filename = System.currentTimeMillis() + uploadFile.getOriginalFilename();
						String filename = uploadFile.getOriginalFilename();
						// 첨부파일의 컨텐츠 타입을 조회한다.
						String filetype = uploadFile.getContentType();
						// 첨부파일의 사이즈를 조회한다.
						long filesize = uploadFile.getSize();
						
						// FileItem객체를 생성해서 첨부파일 정보를 저장한다.
						FileItem fileItem = new FileItem();
						fileItem.setFilename(filename);
						fileItem.setFiletype(filetype);
						fileItem.setFilesize(filesize);
						fileItem.setFileNoticeNo(noticeNo);
						// 위에서 생성한 ArrayList객체에 FileItem객체를 저장한다.
						
						fileItems.add(fileItem);
						
						// 파일복사 유틸리티 클래스이 copy() 메소드를 이용해서
						// 임시파일폴더에 저장된 첨부파일을 읽어오는 스트림과 지정된 파일폴더로 출력하는 스트림을 지정하면 첨부파일을 원하는 폴더에 저장할 수 있다.
						try {
							FileCopyUtils.copy(uploadFile.getInputStream(), new FileOutputStream(new File("/Users/jungeun-kim/fileFolder", filename)));
						} catch (FileNotFoundException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						fileService.insertFile(fileItem);
					}
				}
				
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
		int noticeNo= noticeService.addNoticeAnswer(notice);
		System.out.println("답변parNo: ===>" + notice );
	
		// 모든 첨부파일객체를 조회하기
				List<MultipartFile> uploadFiles = notice.getUpfiles();
				
				// 데이터베이스에 저장할 파일아이템(FileItem)객첼 저장하는 ArrayList객체를 생성한다.
				List<FileItem> fileItems = new ArrayList<>();
				FileDto fileAdd = new FileDto();
				// List에 저장된 MultipartFile를 하나씩 순회처리한다.
				for (MultipartFile uploadFile : uploadFiles) {
					
					// MultipartFile객체에 첨부파일 정보가 포함되어 있는지 체크한다.
					if (!uploadFile.isEmpty()) {
						// 첨부파일의 이름을 조회하고, 중복을 방지하기 위해서 유닉스타임을 파일이름에 붙인다.
//						String filename = System.currentTimeMillis() + uploadFile.getOriginalFilename();
						String filename = uploadFile.getOriginalFilename();
						// 첨부파일의 컨텐츠 타입을 조회한다.
						String filetype = uploadFile.getContentType();
						// 첨부파일의 사이즈를 조회한다.
						long filesize = uploadFile.getSize();
						
						// FileItem객체를 생성해서 첨부파일 정보를 저장한다.
						FileItem fileItem = new FileItem();
						fileItem.setFilename(filename);
						fileItem.setFiletype(filetype);
						fileItem.setFilesize(filesize);
						fileItem.setFileNoticeNo(noticeNo);
						// 위에서 생성한 ArrayList객체에 FileItem객체를 저장한다.
						
						fileItems.add(fileItem);
						
						// 파일복사 유틸리티 클래스이 copy() 메소드를 이용해서
						// 임시파일폴더에 저장된 첨부파일을 읽어오는 스트림과 지정된 파일폴더로 출력하는 스트림을 지정하면 첨부파일을 원하는 폴더에 저장할 수 있다.
						try {
							FileCopyUtils.copy(uploadFile.getInputStream(), new FileOutputStream(new File("/Users/jungeun-kim/fileFolder", filename)));
						} catch (FileNotFoundException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						fileService.insertFile(fileItem);
					}
				}
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
		model.addAttribute("fileList", fileService.getAllFiles(list.getNo()));
		return "notice/modifyNotice";
	}
	
	/**
	 * 공지 사항 수정 후 페이지 이동 
	 * @param no
	 * @param model
	 * @return
	 */
	@RequestMapping("/newModify")
	public String newNotice(NoticeDetailDto notice, RedirectAttributes redirectAttributes) {
		noticeService.changeNotice(notice);


		// 모든 첨부파일객체를 조회하기
		List<MultipartFile> uploadFiles = notice.getUpfiles();
		
		// 데이터베이스에 저장할 파일아이템(FileItem)객첼 저장하는 ArrayList객체를 생성한다.
		List<FileItem> fileItems = new ArrayList<>();
		FileDto fileAdd = new FileDto();
		// List에 저장된 MultipartFile를 하나씩 순회처리한다.
		for (MultipartFile uploadFile : uploadFiles) {
			
			// MultipartFile객체에 첨부파일 정보가 포함되어 있는지 체크한다.
			if (!uploadFile.isEmpty()) {
				// 첨부파일의 이름을 조회하고, 중복을 방지하기 위해서 유닉스타임을 파일이름에 붙인다.
//				String filename = System.currentTimeMillis() + uploadFile.getOriginalFilename();
				String filename = uploadFile.getOriginalFilename();
				// 첨부파일의 컨텐츠 타입을 조회한다.
				String filetype = uploadFile.getContentType();
				// 첨부파일의 사이즈를 조회한다.
				long filesize = uploadFile.getSize();
				
				// FileItem객체를 생성해서 첨부파일 정보를 저장한다.
				FileItem fileItem = new FileItem();
				fileItem.setFilename(filename);
				fileItem.setFiletype(filetype);
				fileItem.setFilesize(filesize);
				fileItem.setFileNoticeNo(notice.getNo());
				// 위에서 생성한 ArrayList객체에 FileItem객체를 저장한다.
				
				fileItems.add(fileItem);
				
				// 파일복사 유틸리티 클래스이 copy() 메소드를 이용해서
				// 임시파일폴더에 저장된 첨부파일을 읽어오는 스트림과 지정된 파일폴더로 출력하는 스트림을 지정하면 첨부파일을 원하는 폴더에 저장할 수 있다.
				try {
					FileCopyUtils.copy(uploadFile.getInputStream(), new FileOutputStream(new File("/Users/jungeun-kim/fileFolder", filename)));
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				fileService.insertFile(fileItem);
			}
		}
		
		
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
	 * 파일 삭제
	 * @param model
	 * @return
	 */
	@RequestMapping("/fileDelet")
	public @ResponseBody ResponseEntity<String> deleteFile(int fileNo) {
		fileService.deleteFile(fileNo);
		return new ResponseEntity<String>(HttpStatus.OK);
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
	
	
	@GetMapping("/download")
	public ModelAndView download(@RequestParam("no") int itemNo) {
		ModelAndView mav = new ModelAndView();
		FileItem fileItem = fileService.getFilesNo(itemNo);
		
		// ModelAndView의 Model에 디렉토리경로와 파일명을 저장한다.
		mav.addObject("directory", "/Users/jungeun-kim/fileDownFolder");
		mav.addObject("filename", fileItem.getFilename());
		// 파일에 유닉스 타입없애기
//		mav.addObject("originalFilename", fileItem.getOriginalFilname());
		// 파일을 다은로드하는View객체를 ModelAndView 저장한다.
		mav.setView(downloadView);		
		
		return mav;
	}
	
	
	/**
	 * 엑셀 다운로드
	 * @param response
	 * @throws IOException
	 */
	 @GetMapping("/excel/download")
	    public void excelDownload(NoticeListDto searchData, HttpServletResponse response) throws IOException {
		 List<Notice> noticeList = noticeService.getNoticeAllExcel(searchData);
//	        Workbook wb = new HSSFWorkbook();
	        Workbook wb = new XSSFWorkbook();
	        Sheet sheet = wb.createSheet("첫번째 시트");
	       
	        Row row = null;
	        Cell cell = null;
	        int rowNum = 0;

	        // Header
	        row = sheet.createRow(rowNum++);
	        cell = row.createCell(0);
	        cell.setCellValue("번호");
	        cell = row.createCell(1);
	        cell.setCellValue("제목");
	        cell = row.createCell(2);
	        cell.setCellValue("날짜");

	        CellStyle cellStyle = wb.createCellStyle();
	        CreationHelper createHelper = wb.getCreationHelper();
	        cellStyle.setDataFormat(
	            createHelper.createDataFormat().getFormat("m/d/yy h:mm"));
	        
	        // Body
	        for (Notice ex : noticeList) {
	            row = sheet.createRow(rowNum++);
	            cell = row.createCell(0);
	            cell.setCellValue(ex.getParNum());
	            cell = row.createCell(1);
	            cell.setCellValue(ex.getTitle());
	            cell = row.createCell(2);
	            cell.setCellValue(ex.getCreatDate());
	            cell.setCellStyle(cellStyle);
	        }

	        // 컨텐츠 타입과 파일명 지정
	        response.setContentType("ms-vnd/excel");
//	        response.setHeader("Content-Disposition", "attachment;filename=example.xls");
	        response.setHeader("Content-Disposition", "attachment;filename=noitceList.xlsx");

	        // Excel File Output
	        wb.write(response.getOutputStream());
	        wb.close();
	    }
	}
	
	
	
	
	
	
	
	
	
	
	
	

