package com.cinemabox.dto.Notice;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeDetailDto {
	
	private int no;
	private String division;
	private String title;
	private String content;
	private Date creatDate;
	private int hits;
	private int important;
	private String nextNo;
	private String nextTitle;
	private String preNo;
	private String preTitle;
	private String noticeId;
	private String noitcePwd;
	private int parNo;
	private int seq;
	private int depth;
	private List<MultipartFile> upfiles;
}
