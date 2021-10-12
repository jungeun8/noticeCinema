package com.cinemabox.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Coment {
	
	private int no;
	private String content;
	private String id;
	private String pwd;
	private int noticeNo;
	private Date createdDate;

}
