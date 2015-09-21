package com.webapp.util;

public class Pagination {
	final static int ITEMS_PER_PAGE = 10;
	final static int PAGES_PER_GROUP = 10;
	
	private int totalItem; // select count(3) from city (DB Query)
	private int pageNo; //=currentPage Request Query Parameter  Client에 넘겨주는 Query Data;
	private int itemsPerPage;
	private int pagesPerGroup;
	//Getter만 만들어 주는 변수들
	// int totalPage;
	// int firstItem;
	// int lastItem;
	// int firstPage;
	// int lastPage;
/*
		int totalPage = totalItem / itemsPerPage + (totalItem % itemsPerPage > 0) + 1;
		firstItem = (pageNo - 1) * itemsPerPage + 1; //1부터 시작
		lastItem = firstItem + itemsPerPage - 1 ; //LastPage 408은 9 Items으로 totalItem과 비교하는Check가 필요
		firstPage = (pageNo / pagesPerGroup) + (pageNo%pagesPerGroup>0) + 1; 
		lastPage = firsgPage + pagesPerGroup - 1 //  totalItem과 비교하는Check가 필요;
*/
	
	
	public Pagination() { //생성자 default value
		//this(ITEMS_PER_PAGE, PAGES_PER_GROUP);
		this.totalItem = 0;
		this.pageNo = 1;
		this.itemsPerPage = ITEMS_PER_PAGE;
		this.pagesPerGroup = PAGES_PER_GROUP;

	}
	
	
	public Pagination(int itemsPerPage, int pagesPerGroup) { //설정에 의해서 바뀌는 value
		this();
		
		if (itemsPerPage < 1) 
			itemsPerPage = ITEMS_PER_PAGE;
		if (pagesPerGroup < 1)
			pagesPerGroup = PAGES_PER_GROUP;
		
		this.itemsPerPage = itemsPerPage;
		this.pagesPerGroup = pagesPerGroup;
		
	}

	// Getters & Setters : Validation을 해 주어야 (음수인 경우에 대한 처리 - Exception처리도 가능)
	public int getTotalItem() {
		return totalItem;
	}

	public void setTotalItem(int totalItem) {
		if(totalItem < 0) 
			this.totalItem = 0;
		else
			this.totalItem = totalItem;
	}

	public int getpageNo() {
		return pageNo;
	}

	public void setpageNo(int pageNo) {
		if(pageNo < 1)
			this.pageNo = 1;
		else
			this.pageNo = pageNo;
	}

	public int getItemsPerPage() {
		return itemsPerPage;
	}

	public void setItemsPerPage(int itemsPerPage) {
		if(itemsPerPage < 1)
			this.itemsPerPage = 1;
		else
			this.itemsPerPage = itemsPerPage;
	}

	public int getPagesPerGroup() {
		return pagesPerGroup;
	}

	public void setPagesPerGroup(int pagesPerGroup) {
		if(pagesPerGroup < 1)
			this.pagesPerGroup = 1;
		else
			this.pagesPerGroup = pagesPerGroup;
	}
	
	public int getTotalPage() {
		int totalPage = this.totalItem / this.itemsPerPage;
		if (this.totalItem % this.itemsPerPage > 0)
			totalPage++;
				
		return totalPage;
	}
	
	public int getFirstItem() {
		
		int pageNo = this.pageNo;
		if(this.pageNo > getTotalPage())
			pageNo = getTotalPage();
		
		int firstItem = (pageNo - 1) * this.itemsPerPage + 1;
		
		if(this.totalItem == 0)
			firstItem = 0;
		
		return firstItem;
	}
	
	public int getLastItem() {
		int lastItem = getFirstItem() + this.itemsPerPage - 1;
		if(lastItem > this.totalItem) // last page
			lastItem = this.totalItem;
		
		return lastItem;
	}
	
	/*
	int totalPage = totalItem / itemsPerPage + (totalItem % itemsPerPage > 0) + 1;
	firstItem = (pageNo - 1) * itemsPerPage + 1; //1부터 시작
	lastItem = firstItem + itemsPerPage - 1 ; //LastPage 408은 9 Items으로 totalItem과 비교하는Check가 필요
	firstPage = (pageNo -1) / pagesPerGroup* pagesPerGroup + 1; 
	lastPage = firsgPage + pagesPerGroup - 1 //  totalItem과 비교하는Check가 필요;
	 */
	public int getFirstPage() {
		int firstPage = (this.pageNo - 1) / this.pagesPerGroup * this.pagesPerGroup + 1;
		
		if (this.totalItem == 0)
			firstPage = 0;
		
		return firstPage;
	}
	
	/**
	 * 406 page firstPage = 401, lastPage = 408
	 * @return 
	 */
	
	public int getLastPage() {
		int lastPage = getFirstPage() + this.pagesPerGroup - 1;
		if (lastPage > getTotalPage()) 
			lastPage = getTotalPage();
		
		return lastPage;
	}
	
	// page ==> 1,2,3,4,5,6,7,8,9,10
	public boolean isFirstGroup() {
		return getFirstPage() <= 1 ? true : false; //totalcount==0이면 false;
	}
	
	// page ==> 41,42,43,44,45 ==> true
	public boolean isLastGroup() {
		if(getLastPage() == getTotalPage()) 
			return true;
		else
			return false;
		/*
		int firstPage = getFirstPage();
		int mod = getTotalPage() % this.pagesPerGroup;
		
		if ((firstPage + mod - 1) == getTotalPage()) 
		 	return true; 
		else 
			return false;
		*/
		
	}
	
}
