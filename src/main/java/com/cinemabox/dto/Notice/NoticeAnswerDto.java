package com.cinemabox.dto.Notice;

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
	private int status;
	
}
