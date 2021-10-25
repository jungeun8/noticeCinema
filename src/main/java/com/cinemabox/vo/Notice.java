package com.cinemabox.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Notice {
	
	private int no;
	private String division;
	private String title;
	private String content;
	private Date creatDate;
	private int hits;
	private int num;
	private String noticeId;
	private String noitcePwd;
	private int parNo;
	private int depth;
	private int seq;
	private int anwserCount;
	private String parNum;
	private String parTitle;
	private int status =1;
	private List<MultipartFile> fileItems;
	private int getFileAllCnt;
	private int searchCnt;

}
