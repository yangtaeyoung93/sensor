package com.seoulsi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;

import com.seoulsi.dto.EquLocPic;
import com.seoulsi.service.AdminService;

import org.springframework.util.StringUtils;

public class FileCheckUtil {

    final String[] UPLOADABLE_FILE_NAME = { "EquiArdEast", "EquiArdWest", "EquiArdSouth", "EquiArdNorth", "InstBefFrt",
            "InstBefBack", "InstAftFrt", "InstAftBack", "EquiInsLoc" };

    public void getFile(String upload, String path, AdminService service) throws Exception {
        File target = new File(path);
        File[] targetChild = target.listFiles();

        // 필수 변수
        String equiInfoKey = "";
        for (File f : targetChild) {
            if (f.isDirectory()) {
                equiInfoKey = f.getName();
                System.out.println(String.format("디렉토리 ===> %s", f.getName()));
                File dirTarget = new File(f.getPath());
                File[] dirTargetChild = dirTarget.listFiles();
                EquLocPic elp = new EquLocPic();

                for (File df : dirTargetChild) {
                    if (df.isFile()) {
                        String fileName = df.getName();
                        String ext = StringUtils.getFilenameExtension(fileName);
                        String originName = fileName.replace("." + ext, "");

                        System.out.println(
                                String.format("디렉토리 ===> %s 파일 ===> %s 확장자 ===> %s", f.getName(), originName, ext));

                        switch (originName) {
                            case "EquiArdEast":
                                elp.setEquiArdEast(originName);
                                elp.setEquiArdEastTp(ext);
                                break;
                            case "EquiArdWest":
                                elp.setEquiArdWest(originName);
                                elp.setEquiArdWestTp(ext);
                                break;
                            case "EquiArdSouth":
                                elp.setEquiArdSouth(originName);
                                elp.setEquiArdSouthTp(ext);
                                break;
                            case "EquiArdNorth":
                                elp.setEquiArdNorth(originName);
                                elp.setEquiArdNorthTp(ext);
                                break;
                            case "InstBefFrt":
                                elp.setInstBefFrt(originName);
                                elp.setInstBefFrtTp(ext);
                                break;
                            case "InstBefBack":
                                elp.setInstBefBack(originName);
                                elp.setInstBefBackTp(ext);
                                break;
                            case "InstAftFrt":
                                elp.setInstAftFrt(originName);
                                elp.setInstAftFrtTp(ext);
                                break;
                            case "InstAftBack":
                                elp.setInstAftBack(originName);
                                elp.setInstAftBackTp(ext);
                                break;
                            case "EquiInsLoc":
                                elp.setEquiInsLoc(originName);
                                elp.setEquiInsLocTp(ext);
                                break;
                            default:
                                break;
                        }
                        // 파일 이름 검증
                        if (!Arrays.stream(UPLOADABLE_FILE_NAME).anyMatch(originName::equals)) {
                            throw new Exception(String.format("파일 이름이 잘못되었습니다. 오류난 기기 코드 ===> %s", equiInfoKey));
                        }

                    } else {
                        System.out.println("오류 발생 ! ! !");
                    }
                }
                service.equiCardImgUpdate(elp);
            }
        }
    }

    public static void copy(File sourceF, File targetF) {
        File[] target_file = sourceF.listFiles();
        for (File file : target_file) {
            File temp = new File(targetF.getAbsolutePath() + File.separator + file.getName());
            if (file.isDirectory()) {
                temp.mkdir();
                copy(file, temp);
            } else {
                FileInputStream fis = null;
                FileOutputStream fos = null;
                try {
                    fis = new FileInputStream(file);
                    fos = new FileOutputStream(temp);
                    byte[] b = new byte[4096];
                    int cnt = 0;
                    while ((cnt = fis.read(b)) != -1) {
                        fos.write(b, 0, cnt);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        fis.close();
                        fos.close();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }

                }
            }
        }
    }
}
