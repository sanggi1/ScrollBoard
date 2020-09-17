package com.blog.ksk.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class FileUploadUtil {
	
	//d드라이브에 사진저장
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		UUID uuid = UUID.randomUUID();
		String uuidStr = uuid.toString().substring(0,13);
		System.out.println("uuid:" + uuidStr);
		// D:upload/2020/6/29/uuidStr_파일명
		String datePath = calcPath(uploadPath); // D:\\upload\2020\6\29\<uuidStr>_파일명
		String dirPath = datePath + File.separator + uuidStr + "_" + originalName;
		String filePath = uploadPath + File.separator + dirPath;
		File target = new File(filePath);
		FileCopyUtils.copy(fileData, target);
		
		boolean result = isImage(originalName);// 파일 확장자 구분 사진파일이면 true
		System.out.println("result:"  + result);
		if (result == true) {
			makeThumbnail(filePath);//썸네일
		}
		return dirPath; // D:/upload 빠짐
	}
	
	//사진 파일구분
	public static boolean isImage(String filename) throws Exception {
		// smile.jpg
		String extName = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase(); // jpg, JPG -> JPG
		if (extName.equals("JPG") || extName.equals("GIF") || extName.equals("PNG")) {
			return true;
		}
		return false;
	}
	
	//썸네일 사진 저장
	private static void makeThumbnail(String filePath) throws Exception {
		// D:\\upload\2020\6\29\   sm_   <uuid>_파일명
		int lastSlashIndex = filePath.lastIndexOf("\\");
		String front = filePath.substring(0, lastSlashIndex + 1);
		String rear = filePath.substring(lastSlashIndex + 1);
		String thumbnailName = front + "sm_" + rear;
		System.out.println("thumbnailName:" + thumbnailName);
		
		BufferedImage srcImage = ImageIO.read(new File(filePath));
		// -> 원본이미지를 메모리에 로드
		
		BufferedImage destImage = Scalr.resize(srcImage, 
											   Scalr.Method.AUTOMATIC,
											   Scalr.Mode.FIT_TO_HEIGHT,
											   100); // 높이 100픽셀로 폭은 자동 조절
													 // 메모리에 썸네일 이미지 생성
		File thumbFile = new File(thumbnailName);
		ImageIO.write(destImage, getFormatName(filePath), thumbFile);
		// -> 해당 파일 포맷(PNG, JPG, GIF)으로 메모리에 생성된 썸네일 이미지를 파일로 저장
	}
	
	//확장명 대문자로
	private static String getFormatName(String fileName) {
		int dotIndex = fileName.lastIndexOf(".");
		String extName = fileName.substring(dotIndex + 1);
		return extName.toUpperCase();
	}
	
	//날짜로 파일 경로 만듬
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DATE);
		String dateString = year + File.separator 
				+ month + File.separator 
				+ date; // 2000/6/29
		
		String datePath = uploadPath + File.separator + dateString;
				
		System.out.println("datePath:" + datePath);
		File f = new File(datePath); // 해당경로의 파일 "객체" 생성, 파일 생성x
		if (!f.exists()) { // 폴더 경로가 존재하지 않는다면
			f.mkdirs(); // 하위 경로 포함해서 생성
		}
		
		return dateString;
	}
}
