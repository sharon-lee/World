package com.webapp.locale;

import java.util.Locale;

public class LocaleTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Locale[] locales = Locale.getAvailableLocales();
		for (Locale l : locales) {
			System.out.print(l.getLanguage() + "\t");
			System.out.println(l.getCountry());
			
		}

	}

}
