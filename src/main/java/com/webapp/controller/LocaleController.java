package com.webapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.LocaleResolver;

import com.webapp.command.CityCommand;

//RequestHandlerMapping이 Controller로 Annotation되어 있는 Class를 찾고 RequestMapping Annotation이 있는 메소드를 찾아서 
//List로 갖고 있다가 Client 요청이 오면 RequestHandlerAdapter가 수행
//RequestMapping처리-City를 
@Controller
@RequestMapping("/locale")
public class LocaleController {
	
	static Log log = LogFactory.getLog(LocaleController.class);
	
	/*
	 * DI 조립
	 * 1. 생성자 주입
	 * 2. Property 주입
	 * 3. 필드 주입 - @Autowired (type으로 동작-type이 일치하는 게 있으면 바로 집어넣음)
	 */
	@Autowired
	LocaleResolver localeResolver; //Injection안하면 java.lang.NullPointerException
	
	@RequestMapping("/{language:[a-z]{2}}")
	void setLocale(@PathVariable String language, HttpServletRequest request, HttpServletResponse response) throws IOException {
		log.info("language = " + language);
		// 언어 설정 SessionLocaleResolver
		
		Locale locale = new Locale(language);  //추가
		
		localeResolver.setLocale(request, response, locale);
		
		// SessionLocaleResolver Setter를 만들어서 Injection 받아야 - Autowired
		
		PrintWriter out = response.getWriter();
		out.println("language = " + language+"<br>");
		out.println("language = " + locale.getLanguage());  //추가 
	}
	
}
