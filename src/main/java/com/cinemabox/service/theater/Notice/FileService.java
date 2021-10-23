package com.cinemabox.service.theater.Notice;

import java.util.List;


import com.cinemabox.vo.FileItem;

public interface FileService {
	
	void insertFile(FileItem file);
	// 파일 등록 
	List<FileItem> getAllFiles(int no);
	// 파일 조회 
	void updateFile(FileItem attachmentFile);
	// 파일 수정 
	void deleteFile(int fileNo);

}
