package com.dyf.creditcard.modules.work.tools;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import com.dyf.creditcard.common.utils.DateUtils;

public class DateUtil extends DateUtils {
	
	public static Date addDay(Date d, int day) {
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(d);
		calendar.add(Calendar.DATE, day);
		d = calendar.getTime();
		return d;
	}
	
	public static Date addDay(String d, int day) {
		return addDay(parseDate(d), day);
	}
	
	/**
	 * 是否是工作日
	 * @param d
	 * @return
	 */
	public static boolean isWorkDay(Date d) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
			return false;
		}
		return true;
	}
	
	/**
	 * 是否是周五
	 * @param d
	 * @return
	 */
	public static boolean isFriday(Date d) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		return cal.get(Calendar.DAY_OF_WEEK) == Calendar.FRIDAY;
	}
	
	/**
	 * 是否是周六
	 * @param d
	 * @return
	 */
	public static boolean isSaturday(Date d) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		return cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY;
	}
	
	/**
	 * 是否是周日
	 * @param d
	 * @return
	 */
	public static boolean isSunday(Date d) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		return cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY;
	}
	
}
