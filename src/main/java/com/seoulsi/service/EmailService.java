package com.seoulsi.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;

@Service
@AllArgsConstructor
public class EmailService {

    private final JavaMailSender emailSender;

    public void sendSimpleMessage(String to, String subject, String text) {

        try {
            SimpleMailMessage message = createMessage(to, subject, text);
            emailSender.send(message);
        } catch (Exception e) {

        }
    }

    private SimpleMailMessage createMessage(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);// 보낼 대상
        message.setFrom("sdotmailtest@gmail.com");
        message.setSubject(subject);// 제목
        message.setText(text);// 내용
        return message;
    }
}
