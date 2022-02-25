package com.seoulsi.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

public class LogFileUtil {

	@Value("${file.upload-path}")
	private static String path;

	public static void fileWriter(String msg) {

		File file = new File(path + "test1.txt");
		FileWriter writer = null;
		BufferedWriter bWriter = null;

		try {
			writer = new FileWriter(file, true);
			bWriter = new BufferedWriter(writer);

			bWriter.write(msg);
			bWriter.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bWriter != null)
					bWriter.close();
				if (writer != null)
					writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
