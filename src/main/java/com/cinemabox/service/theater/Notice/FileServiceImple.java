package com.cinemabox.service.theater.Notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.cinemabox.dao.Notice.FileItemDao;
import com.cinemabox.vo.FileItem;

public class FileServiceImple implements FileService{

	@Autowired
	FileItemDao fileDao;
	
	@Override
	public void insertFile(FileItem file) {
		// 파일명, 파일타입, 파일사이즈를 저장한다.
		fileDao.insertFile(file);
	}

	@Override
	public List<MultipartFile> getAllFiles(int no) {
		
		return fileDao.getAllFiles(no);
	}

	@Override
	public void updateFile(FileItem attachmentFile) {
		fileDao.updateFile(attachmentFile);
		
	}

	@Override
	public void deleteFile(int fileNo) {
		fileDao.deleteFile(fileNo);
		
	}

}
