package com.wjh.board;

import java.io.UnsupportedEncodingException;

public class Encoding {

	public Encoding(){
		
	}
	
	public static String toLatin(String w){
		byte[] b = w.getBytes();
		try {
			return new String(b,"ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			System.out.println("ERR_toLatin");
			return null;
		}
	}
	
	public static String toUnicode(String w){
		try {
			byte[] b = w.getBytes("ISO-8859-1");
			return new String(b);
		} catch (UnsupportedEncodingException e) {
			System.out.println("ERR_toUnicode");
			return null;
		}
		
	}
}
