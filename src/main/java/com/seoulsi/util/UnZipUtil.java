package com.seoulsi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.charset.Charset;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.springframework.web.multipart.MultipartFile;

public class UnZipUtil {

    public Boolean unZip(String unZipPath, MultipartFile mFile) {
        Boolean isChk = false;

        FileInputStream fis = null;
        ZipInputStream zis = null;
        ZipEntry ze = null;

        try {
            if (makeFolder(unZipPath)) {
                fis = (FileInputStream) mFile.getInputStream();

                zis = new ZipInputStream(fis, Charset.forName("EUC-KR"));

                while ((ze = zis.getNextEntry()) != null) {
                    String fileName = ze.getName();

                    File file = new File(unZipPath, fileName);

                    if (ze.isDirectory()) {
                        file.mkdirs();
                    } else {
                        createFile(file, zis);
                    }
                }
                isChk = true;
            }
        } catch (Exception e) {
            isChk = false;
        } finally {
            try {
                if (zis != null)
                    zis.close();
                if (fis != null)
                    fis.close();

                deleteFolder(unZipPath);

            } catch (Exception e) {
            }
        }
        return isChk;
    }

    /**
     * 폴더 생성 메소드
     * 
     * @param folder
     * @return Boolean
     */
    public boolean makeFolder(String folder) {
        if (folder.length() < 0) {
            return false;
        }
        String path = folder; // 폴더 경로
        File Folder = new File(path); // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
        if (!Folder.exists()) {
            try {
                Folder.mkdir(); // 폴더 생성합니다.
                System.out.println("폴더가 생성되었습니다.");
            } catch (Exception e) {
                e.getStackTrace();
            }
        } else {
            System.out.println("이미 폴더가 생성되어 있습니다.");
        }
        return true;
    }

    private Boolean deleteFolder(String path) {
        Boolean isOk = false;
        File target = new File(path);

        if (target.exists()) {
            File[] targetChild = target.listFiles();

            try {
                for (File f : targetChild) {
                    if (f.isFile()) {
                        f.delete();
                    } else {
                        deleteFolder(f.getPath());
                    }
                    f.delete();
                }
                target.delete();

                isOk = true;

            } catch (Exception e) {
                isOk = false;
            }
        }
        return isOk;
    }

    /**
     * 파일 생성 메소드
     * 
     * @param file, zis
     * @return Boolean
     */
    public Boolean createFile(File file, ZipInputStream zis) throws Exception {

        Boolean isOk = false;

        File parentDir = new File(file.getParent());

        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }

        FileOutputStream fos = null;

        try {
            fos = new FileOutputStream(file);
            byte[] buffer = new byte[256];
            int size = 0;

            while ((size = zis.read(buffer)) > 0) {
                fos.write(buffer, 0, size);
            }
        } catch (Exception e) {
            isOk = false;
        } finally {
            if (fos != null) {
                fos.close();
            }
        }
        return isOk;
    }

}
