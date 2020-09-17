package com.blog.ksk.controller;

import java.io.File;
import java.io.FileInputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.blog.ksk.util.FileUploadUtil;

@RestController
@RequestMapping("/upload")
public class UploadController {

	@Resource
	private String uploadPath; // servlet-context.xml (id="uploadPath");
	
	//첨부파일 드랍
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST)
	public String uploadAjax(MultipartFile file) throws Exception {
		String originalName = file.getOriginalFilename();
		long size = file.getSize();
		String dirPath = FileUploadUtil.uploadFile(uploadPath, originalName, file.getBytes());
		
		return dirPath.replace("\\", "/");
	}
	
	
	//사진 보기
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public byte[] displayFile(@RequestParam("fileName") String fileName) throws Exception {
		String filePath = uploadPath + File.separator + fileName;
		String rFilePath = filePath.replace("/", "\\");
		FileInputStream fis = new FileInputStream(rFilePath);
		byte[] bytes = IOUtils.toByteArray(fis);
		fis.close();
		return bytes;
	}
	
	
	//업로드 예정사진 지우기
	@RequestMapping(value = "/deleteFile", method = RequestMethod.GET)
	public String deleteFile(String filename) throws Exception {
		System.out.println("filename:" + filename);
		String serverPath = uploadPath + File.separator + filename;
		String front = filename.substring(0, filename.lastIndexOf("/") + 1);
		String rear = filename.substring(filename.lastIndexOf("/") + 1);
		String smServerPath = uploadPath + File.separator + front + "sm_" + rear;
		File f = new File(serverPath);
		f.delete();
		boolean result = FileUploadUtil.isImage(filename);
		if (result ==  true) {
			File f2 = new File(smServerPath);
			f2.delete();
		}
		return "success";
	}
}
