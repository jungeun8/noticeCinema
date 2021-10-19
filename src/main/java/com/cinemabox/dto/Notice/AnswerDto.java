package com.cinemabox.dto.Notice;

import lombok.Data;

@Data
public class AnswerDto {
	
	private int page = 1;
	private int startPage = 1;
	private int endPage = 10;
	private int no;
	private int answerNo;
	private String content;

}
