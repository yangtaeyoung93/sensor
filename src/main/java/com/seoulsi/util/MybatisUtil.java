package com.seoulsi.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class MybatisUtil {
	public static Boolean isFileEmpty(String file) {
		return !file.equals("octet-stream");
	}
	
	public static Boolean saveFile(byte[] target, String path) throws IOException {
		if(target.length != 0) {
			File lOutFile = new File(path);
			
			if(lOutFile.isFile()) {
				lOutFile.delete();
				
			} 
			FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);
			
			lFileOutputStream.write(target);
			
			lFileOutputStream.close();
			return true;
		} else {
			return false;
		}
	}
	
	public static String splitFileName(String name) {
		if(name == null) {
			return "";
		} else {
			return name.split("/")[1];
		}
	}
}
