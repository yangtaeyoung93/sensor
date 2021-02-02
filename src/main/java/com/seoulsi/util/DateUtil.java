package com.seoulsi.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	public static String dateAdd(String dataeFormat, String strDate, String dateUnit, int addDate) {
	       DateFormat dateFormat = null;
	       Date date = new Date();
	       
	       try {
	           dateFormat = new SimpleDateFormat(dataeFormat);
	           date = dateFormat.parse(strDate);
	       } catch (ParseException e) {
	    	   
	       }
	       
	       Calendar cal = Calendar.getInstance();
	       cal.setTime(date);
	       if ("DATE".equals(dateUnit)) {
	           cal.add(Calendar.DATE, addDate);
	       } else if ("HOUR".endsWith(dateUnit)) {
	           cal.add(Calendar.HOUR, addDate);
	       } 
	       return dateFormat.format(cal.getTime());
	   }
}
