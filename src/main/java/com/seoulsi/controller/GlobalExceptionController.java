// package com.seoulsi.controller;

// import java.util.Map;

// import javax.servlet.http.HttpServletRequest;

// import
// org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
// import org.springframework.http.HttpStatus;
// import org.springframework.stereotype.Controller;
// import org.springframework.web.bind.annotation.ControllerAdvice;
// import org.springframework.web.servlet.ModelAndView;

// @Controller
// @ControllerAdvice
// public class GlobalExceptionController implements ErrorViewResolver {

// @Override
// public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus
// status, Map<String, Object> model) {
// ModelAndView mv = new ModelAndView();
// mv.setViewName("sensor/index");
// if (status.isError()) {
// mv.addObject("code", status.value());
// if (status.value() == 302) {
// mv.addObject("msg", "로그인 정보가 없습니다2.");
// } else {
// mv.addObject("msg", status.getReasonPhrase());
// }
// }

// return mv;
// }

// }