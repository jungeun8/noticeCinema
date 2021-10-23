package com.cinemabox.dto.Notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.cinemabox.vo.FileItem;

import lombok.Data;

@Data
public class FileDto {

	private long no;
	private String filename;
	private String filetype;
	private long filesize;
	private int fileNoticeNo;
	private int amount;
	private List<MultipartFile> upfiles;
	List<FileItem> fileItems;
}
