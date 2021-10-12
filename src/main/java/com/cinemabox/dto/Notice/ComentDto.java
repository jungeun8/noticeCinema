package com.cinemabox.dto.Notice;

import lombok.Data;

@Data
public class ComentDto {
	
	private int no;
	private String coment;
	private String id;
	private String pwd;
	private int noticeNo;
	private int page = 1;
	private int startPage = 1;
	private int endPage = 10;
	

}
