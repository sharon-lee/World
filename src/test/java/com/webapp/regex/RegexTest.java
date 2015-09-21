package com.webapp.regex;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexTest {

	/* Regular Expression 조합
	 * 문자열 검색, 대체, 추출 ==> 정규표현식 (Regular Expression)
	 *	. ==> new line을 제외한 모든 문자 한문자
	 * ^ ==> Line 시작 (Line Start)
	 * $ ==> Line 끝 Line End
	 * * ==> *바로 앞문자가 0개 이상 반복
	 * + ==> +바로 앞문자가 1개 이상 반복
	 * [AYZ] ==> 한자리에 올수있는 문자AYZ의 부분집합
	 * [A-Z] ==> 한자리에 올수있는 문자A-Z의 부분집합
	 * [A-Z0-9] ==> 올수있는 문자A-Z숫자0-9의 부분집합
	 * {n} ==> 앞문자가 n개 반복
	 * {n,} ==> 앞문자가 n개 이상 반복
	 * {n,m} ==> 앞문자가 n개 이상 m개 이하 반복
	 * 한글은 Unicode
	 * [A-Za-z]{3} ==> 한 Line에서 문자가 3자리이상 반복되는지 Check
	 */
	public static void main(String[] args) {
		
		Scanner scan = new Scanner(System.in);
		
		//String regex = "^...$";
		//String regex = "^A*$";
		//String regex = "^A+$";
		//String regex = "^[AYZ]$";
		//String regex = "^[A-Z]$";
		//String regex = "^[A-Z0-9]{3}$";
		//String regex = "^[A-Z0-9]{3,5}$";
		//String regex = "^[가-힣]{3,5}$";
		//String regex = "[A-Za-z]{3}";
		//String regex = "^[A-Za-z0-9]{10,15}$";//id
		String regex1 ="^[0-9]{3}-[0-9]{4}-[0-9]{4}$"; //010-1111-2222
		String regex2 ="^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$";
		
		//전화번호 Validation Check 02-333-4444, 011-333-4444 010-3333-4444
		while(true) {
			String line  = scan.nextLine();
			System.out.println("line = [" + line + "]");
			//Pattern pattern = Pattern.compile(regex);
			//Pattern pattern = Pattern.compile(regex1);
			Pattern pattern = Pattern.compile(regex2);
			Matcher m = pattern.matcher(line);
			System.out.println("match = " + m.find());
			
			//System.out.println("match = " + Pattern.matches(regex, line));; 
		}
	}

}
