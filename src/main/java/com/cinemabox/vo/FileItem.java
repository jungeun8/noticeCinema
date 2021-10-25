package com.cinemabox.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;



import lombok.Data;

@Data
public class FileItem {
	private int no;
	private String filename;
	private String filetype;
	private long filesize;
	private int fileNoticeNo;
	private List<MultipartFile> upfiles;
	
	public String getOriginalFilname() {
		return filename.substring(13);
	}


}
