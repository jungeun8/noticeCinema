package com.cinemabox.service.theater.Notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cinemabox.dao.Notice.FileItemDao;
import com.cinemabox.dto.Notice.FileDto;
import com.cinemabox.vo.FileItem;

@Service
public class FileServiceImple implements FileService{

	@Autowired
	FileItemDao fileDao;
	
	@Override
	public void insertFile(FileItem file) {
		// 파일명, 파일타입, 파일사이즈를 저장한다.
		fileDao.insertFile(file);
	}

	@Override
	public List<FileItem> getAllFiles(int no) {
		
		return fileDao.getAllFiles(no);
	}
	@Override
	public FileItem getFilesNo(int no) {
		return fileDao.getFilesNo(no);
	}
	
	@Override
	public void updateFile(FileItem attachmentFile) {
		fileDao.updateFile(attachmentFile);
		
	}

	@Override
	public void deleteFile(int fileNo) {
		fileDao.deleteFile(fileNo);
		
	}

	@Override
	public int getFileAllCnt(int no) {
		// 파일 수 
		return fileDao.getFileAllCnt(no);
	}

}
