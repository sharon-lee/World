package com.webapp.model;

import java.util.List;

import com.webapp.util.Pagination;

public class CityList extends Pagination { //CityList는 Model (MVC)
	
	List<City> citys;

	public CityList() {
		super();
	}
	
	public CityList(int itemsPerPage, int pagesPerGroup) {
		super(itemsPerPage, pagesPerGroup);
	}
	
	public List<City> getCitys() {
		return citys;
	}

	public void setCitys(List<City> citys) {
		this.citys = citys;
	}
	
	

}
