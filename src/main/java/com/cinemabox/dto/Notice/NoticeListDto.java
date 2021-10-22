package com.cinemabox.dto.Notice;

import lombok.Data;

@Data
public class NoticeListDto {

	private int page = 1;
	private int startPage = 1;
	private int endPage = 10;
	private String searchWord ="";
	private int parNo;
	private int seq;
	private int depth;
	private int no;
	private int status;

}
