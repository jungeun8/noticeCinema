package com.cinemabox.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;



import lombok.Data;

@Data
public class FileItem {
	
	private int no;
	private String filename;
	private String originalFilename;
	private String filetype;
	private long filesize;
	private int fileNoticeNo;
	private List<MultipartFile> upfiles;
	
	//Setter
    public void setFilename(String filename){
        this.filename = filename;
        this.originalFilename = filename.substring(13);
    }

    public String getOriginalFilname() {
		return filename.substring(13);
	}



}

