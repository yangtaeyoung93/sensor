package com.seoulsi.controller;

import java.io.File;
import java.io.FileNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    ResourceLoader resourceLoader;

    @GetMapping("/excel/{filename}")
    public ResponseEntity<Resource> resourceFileDownload(@PathVariable String filename) {
        try {
            Resource resource = resourceLoader.getResource("classpath:static/files/" + filename + ".xlsx");
            File file = resource.getFile();

            ResponseEntity<Resource> result = ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename + ".xlsx")
                    .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()))
                    .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM.toString()).body(resource);
            return result;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(null);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
