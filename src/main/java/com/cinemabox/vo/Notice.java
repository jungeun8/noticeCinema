package com.cinemabox.vo;

import java.util.Date;

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
    

}
