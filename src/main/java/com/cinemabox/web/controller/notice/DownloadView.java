package com.cinemabox.web.controller.notice;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class DownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String directory = (String) model.get("directory");
		String filename = (String) model.get("filename");
//		String originalFilename = (String) model.get("originalFilename");
		// 파일명에 한글이 포함되어 있기 때문에 파일명얼 UTF-8로 인코딩한다.
		String encodedFilename = URLEncoder.encode(filename, "utf-8");
		// 응답컨텐츠타입을 applocation/octect-stream으로 지정한다.
		// application/ 은 바이너리 데이터를 응답으로 제공할때 설정되는 컨텐츠 타입이다.
		response.setContentType("application/octet-stream");
		//응답메시지의 헤더부에 다운로드 되는 파일의 이름을 설정한다.
		response.setHeader("Content-Disposition", "attachment; filename="+encodedFilename);
		// 디렉토리경로와 파일명으로 파일을 읽어오는 스트림을 생성 
		InputStream in = new FileInputStream(new File(directory, filename));
		// 응답객체에서 클라이언트 브라우저로 출력하는 스트림획득 
		OutputStream out = response.getOutputStream();
		// 스트립 복사를 실행하면 파일을 읽어서 브라우져에 전달한다.
		IOUtils.copy(in, out);
		
	}

}
