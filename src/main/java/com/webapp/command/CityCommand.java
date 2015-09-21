package com.webapp.command;

import com.webapp.model.City;
import com.webapp.model.Country;

public class CityCommand {
	//WEB의 Form에 있는 Data를 Java의 객체에 담기위한 객체 - Binding/Command 객체, Parameter들을 Binding하기 위한 Command객체로
	//유효성 검사(Validation)후 DB에 저장할수 있는 Model로 변환하는 역할
	String name;
	String countryCode;
	String district;
	int    population;
	  
	public City getCity() {
		City city = new City();
		
		city.setName(name);
		//Mybatis도 바꿔야
		Country c = new Country();
		c.setCode(countryCode);
		
		city.setCountry(c);
		city.setDistrict(district);
		city.setPopulation(population);
		
		return city;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public int getPopulation() {
		return population;
	}
	public void setPopulation(int population) {
		this.population = population;
	}

	  
	  
	  
	  
}
