package com.cinemabox.dto.Notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeAnswerDto {
	private String title;
	private String content;
	private String important;
	private String division = "전체";
	private String noticeId;
	private String noitcePwd;
	private int parNo;
	private int depth;
	private int seq;
	private int no;
	private int status=1;
	private List<MultipartFile> upfiles;
	
}
