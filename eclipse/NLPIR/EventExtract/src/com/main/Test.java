package com.main;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {

	public static void main(String[] args) {

		String str="�ҽ���#�ܺ�#��Ŷ������#dadfafdsa#";
        Pattern pattern = Pattern.compile("#([^\\#|.]+)#"); 
        Matcher matcher = pattern.matcher(str);
        if(matcher.find()){
        	System.out.println(str);
        }
        str=str.replaceAll("#([^\\#|.]+)#", "");
        System.out.println(str);
	}

}
