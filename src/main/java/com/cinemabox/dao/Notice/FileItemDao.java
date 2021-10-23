package com.cinemabox.dao.Notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.cinemabox.vo.FileItem;


public interface FileItemDao {
	
	void insertFile(FileItem file);
	// 파일 등록 
	List<MultipartFile> getAllFiles(int no);
	// 파일 조회 
	void updateFile(FileItem attachmentFile);
	// 파일 수정 
	void deleteFile(int fileNo);
	// 파일 삭제 

}
