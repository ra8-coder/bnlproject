package com.spring.webproject.util;

public class FileUtil {
		
	public String fileNameMaker(String originalFilename) {
		
		String result = null;
		
		if(originalFilename != null) {
			String[] temp = originalFilename.split("\\.");
			result = temp[0]+"_cover."+temp[1];
		}
		
		return result;
		
	}
	
}
