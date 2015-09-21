package com.webapp.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webapp.command.CityCommand;

public class CityCommandValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// Validation 객체 type이 무엇인지 외부에서 확인이 필요할 때 
		return CityCommand.class.isAssignableFrom(clazz);
	}

	//Spring framework Validation
	@Override
	public void validate(Object target, Errors errors) {
		// Validator의 Validation 처리 - error있으면 Errors에 reject / rejectValue setting
		CityCommand city = (CityCommand) target;
		/*
		 * Validation
		 * error code는 우선순위 있어 - error.city.name>error.name>error.java.lang.String>error(일반적인error)
		 */
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");//Static Method에서 Error Check
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "countryCode", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "district", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "population", "required");
		
		//Validation Utility - Name CHAR(35) Length Check
		if (city.getName().length() > 35) {
			errors.rejectValue("name", "length", new Object[] {35}, ""); //parameter로 35자릿수 전달, error code는 length
		}
		
		if (city.getPopulation() < 0) {
			//error.properties에서 error code setting해야
			errors.rejectValue("population", "minus");
		}
		/*Error Hard Coding
		errors.rejectValue("name", "error"); //city.name.error
		errors.rejectValue("countryCode", "error");//city.countryCode.error
		errors.rejectValue("district", "error");//city.district.error
		errors.rejectValue("population", "error");//city.population.error
		*/
	}
	
	
}
