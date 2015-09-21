package com.webapp.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.webapp.command.CityCommand;
import com.webapp.command.Code;
import com.webapp.command.District;
import com.webapp.mapper.CityMapper;
import com.webapp.mapper.CountryMapper;
import com.webapp.model.City;
import com.webapp.validator.CityCommandValidator;

//RequestHandlerMapping이 Controller로 Annotation되어 있는 Class를 찾고 RequestMapping Annotation이 있는 메소드를 찾아서 
//List로 갖고 있다가 Client 요청이 오면 RequestHandlerAdapter가 수행
//RequestMapping처리-City를 
@Controller
@RequestMapping("/city")
public class CityController {
	
	static Log log = LogFactory.getLog(CityController.class);
	
	//Mapper 조회 - Field Injection Autowired하면 Spring이 Scan해서 등록시에 같은Type이 있으면 등록
	@Autowired
	CountryMapper countryMapper;
	
	@Autowired
	CityMapper cityMapper;
	
	@Autowired
	CityCommandValidator validator; //Field Injection - Setter없이 
	
	
	
	
	/************* Test **************/
	
	String getCitys() {
		
		return "";
	}
	
	/************* Test **************/	
	
	
	
	
	
	//RequestHandlerMapping설정했으므로 Annotation으로 처리 - AJax에서 호출
	//정규표현식(Email,Password Validation검증용). 
	//QueryString이 아닌 URL상에서 기술한 값으로 처리-WEB값 전달은 Parameter, URL로
	@RequestMapping("/district/{countrycode:[A-Z]{3}}") 
	String getDistricts(@PathVariable String countrycode, Model model) { //Method Parameter 
		log.info("getDistricts()... countryCode = " + countrycode);
		
		List<String> districts = cityMapper.selectDistricts(countrycode);
		
		model.addAttribute("districts", districts);
		
		return "city/districts";
	}	
	//URI로 view이름을 만들어 xxx.jsp return "xxx"수행함

	//Mapper 조회
	@RequestMapping
	String listByParameter(String countrycode, Model model) {//HandlerAdapter PathVariable Annotation이 없으면 QueryString Parameter에서 가져옴,없으면 null
		//Primitive type이 1st Argument이면 반드시 있어야, 아니면 Error
		model.addAttribute("countrycode", countrycode);
		
		List<Code> list = countryMapper.selectCodes();
		/* 변환 절차 불필요
		 * List<Map<String, String>> list = countryMapper.selectCodes();
		for (Map<String, String> map : list) {
			log.info("code = " + map.get("code") + "   " + 
					 "name = " + map.get("name"));
		}		
		*/		
		for (Code c : list) {
			log.info("code = " + c.getCode() + "   " + 
					 "name = " + c.getName());
		}
		
		return "city/list";
	}

	@RequestMapping("/list")
	void listByParameter(HttpServletRequest request, Model model) {//HandlerAdapter가 Parameter를 넣어주면 똑같이 넣어줌, return이 없으면 URI로 viewname결정 
		
		String countrycode = request.getParameter("countrycode");
		
		log.info("requestURI()... countrycode = " + request.getRequestURI());
		
		model.addAttribute("countrycode", countrycode);
		
		//return "city/list"; //유지보수성을 위해 면시적으로  return해주는게 바람직
	}
	
	@ModelAttribute("countryCode")
	List<Code> getCountryCode() {
		/* MAP이 안되므로 Bean으로 변환 처리
		Map<String, String> countryCode = new HashMap<String, String>();
		countryCode.put("KOR", "대한민국");
		countryCode.put("USA", "미국");
		countryCode.put("JPN", "일본");
		countryCode.put("CHA", "중국");
		
		//model.addAttribute("countryCode", countryCode);
//MyBatis로 country정보 Get - Mybatis 설정. Country, City Table처리하는 Dao, Mapper 설정(Dao, ServiceLayer생략)
		return countryCode;
		*/
		/* MAP대신 Code Bean으로 바꿈-Error때문
		List<District> model = new ArrayList<District>();
		List<Map<String, String>> list = countryMapper.selectCodes();
		for (Map<String, String> map : list) {
			model.add(new District(map.get("code"), map.get("name")));
		}
		*/
		List<Code> model = countryMapper.selectCodes();
		log.info("getCountryCode()... size = " + model.size());
		return model;
	}
	
	@ModelAttribute("districts")
	List<String> getDistricts(String countryCode) {
		/*
		List<District> list = new ArrayList<District>();
		
		list.add(new District("Seoul", "서울"));
		list.add(new District("Pusan", "부산"));
		list.add(new District("Inchon", "인천"));
		list.add(new District("Taegu", "대구"));
		list.add(new District("Taejon", "대전"));
		list.add(new District("Kwangju", "광주"));
		list.add(new District("Kyongsangnam", "경상남"));
		list.add(new District("Kyonggi", "경기"));
		list.add(new District("Chollabuk", "전라북"));
		list.add(new District("Chungchongbuk", "충청북"));
		list.add(new District("Kyongsangbuk", "경상북"));
		list.add(new District("Chungchongnam", "충청남"));
		list.add(new District("Cheju", "제주"));
		list.add(new District("Chollanam", "전라남"));
		list.add(new District("Kang-won", "강원"));
		 */

		List<String> model = cityMapper.selectDistricts(countryCode);
		log.info("getDistrict()... size = " + model.size());
		return model;
		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	String registerForm(@ModelAttribute("city") CityCommand command) {//요청파라미터를 한번에 많이 받으려면 Bean을 사용 (Command객체)
		//Get방식으로 Form양식 제출
		//CityCommand command: HTML Form에 있는 Parameter들을 담기 위한 객체(Command/Binding객체)
		//register.jsp View에서 CityCommand command parameter를 읽으려면 model에 addAttribute하거나 
		//Command객체는 HandlerAdapter에의해 자동으로 model객체에 add된다.이름은 CityCommand parameter name으로 model에 달아준다
		//QueryString Parameter와 Command객체의 Property name이 같으면 Binding해줌. model을 통해서 view까지 넘어감
		//@ModelAttribute("city") 
		//model.addAttribute("cityCommand", command);
		//model.addAttribute("city", command);
		log.info("registerForm()... GET");
				
		return "city/registerForm";
		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	String register(@ModelAttribute("city") CityCommand command, Errors errors, Model model) {//요청파라미터를 한번에 많이 받으려면 Bean을 사용 (Command객체)
		//CityCommand command: HTML Form에 있는 Parameter들을 담기 위한 객체(Command/Binding객체)
		//register.jsp View에서 CityCommand command parameter를 읽으려면 model에 addAttribute하거나 
		//Command객체는 HandlerAdapter에의해 자동으로 model객체에 add된다.이름은 CityCommand parameter name으로 model에 달아준다
		//QueryString Parameter와 Command객체의 Property name이 같으면 Binding해줌. model을 통해서 view까지 넘어감
		//@ModelAttribute("city") 
		//model.addAttribute("cityCommand", command);
		//model.addAttribute("city", command);
		//CityCommand는 request 영역객체에 달림
		log.info("/register()... POST");
		
		/*
		 * CityCommand Validation - 논리적 Error처리 Validator
		 */
		validator.validate(command, errors); //error있으면 errors에 달림
		
		if (errors.hasFieldErrors("name")) {
			FieldError e = errors.getFieldError("name");
			String[] codes = e.getCodes();
			for (String s : codes) {
				log.info("FieldError codes = [" + s + "]");
			}
		}
				
		if (errors.hasErrors()) {
			//errorCode는 property file에 정의, 없으면 error
			//Object[] errorArgs-Message Parameter, Index값을 Add
			errors.reject("city.register", new Object[]{command.getName()}, "City Global Error"); // Global error, defaultMessage:property file이 없을때 나오는 message
			//error setting:reject-Global/CityCommand Error, rejectValue-입력이 Field Error
			//new Object[]{command.getName()} - message의 parameter
			return "city/registerForm";
		}
		
		/* DB에 Insert하는 작업, Validation작업이 필요
		 * DB Register ==> Service를 사용해서 처리
		 * Primary key 중복 처리
		 * Dao level에서 DB 영속화(Persistency) 처리. Error있으면 Exception
		 */
		City city = command.getCity();
		log.info(city.toString());
		cityMapper.insert(city);
		
		model.addAttribute("city", city);
		
		return "city/registerSuccess";
		
	}

	@RequestMapping("/modify")
	String modify(@ModelAttribute("city") CityCommand command, Errors errors) {//요청파라미터를 한번에 많이 받으려면 Bean을 사용 (Command객체)
		//CityCommand command: HTML Form에 있는 Parameter들을 담기 위한 객체(Command/Binding객체)
		//register.jsp View에서 CityCommand command parameter를 읽으려면 model에 addAttribute하거나 
		//Command객체는 HandlerAdapter에의해 자동으로 model객체에 add된다.이름은 CityCommand parameter name으로 model에 달아준다
		//QueryString Parameter와 Command객체의 Property name이 같으면 Binding해줌. model을 통해서 view까지 넘어감
		//@ModelAttribute("city") 
		//typeMismatch Error우선순위:typeMismatch.city.population,typeMismatch.population,typeMismatch.int,typeMismatch]; 
		//model.addAttribute("CityCommand", command);
		//Errors(Global Error/Field Error)의 경우 HandlerAdapter는 Error의 경우 바로 Reject하지 않고 Errors에 Error정보 넘겨주고 model로 넘어감
		if (errors.hasFieldErrors()) {//Errors는 반드시 Command객체 뒤에 있어야
			List<FieldError> fieldErrors = errors.getFieldErrors();
			for (FieldError fe : fieldErrors) {
				log.info("field = " + fe.getField());
				log.info("objectName = " + fe.getObjectName());
				log.info("code = " + Arrays.toString(fe.getCodes()));//View에서는 Error Code를 판단 Display해야 property file로 error message 정의
				log.info("code = " + fe.getCode());
				log.info("rejectedValue = " + fe.getRejectedValue());
				
			} 
		}
		
		return "city/modify";
		
	}
	
}
