package com.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public class FileUtil {

	/**
	 * 获取文件的扩展名
	 * 
	 * @param filename
	 * @param defExt
	 * @return
	 */
	public static String getExtension(String fileName) {
		if ((fileName != null) && (fileName.length() > 0))
		{
			int i = fileName.lastIndexOf('.');

			if ((i > -1) && (i < (fileName.length() - 1))) {
				return fileName.substring(i + 1);
			}
		}
		return null;
	}

	/**
	 * 创建文件
	 * 
	 * @param filename
	 *            文件名称
	 * @return
	 */
	public static boolean createFile(String destFileName) {

		File file = new File(destFileName);
		// 如果存在，返回true
		if (file.exists()) {
			return true;
		}
		if (destFileName.endsWith(File.separator)) {
			return false;
		}
		// 判断目标文件所在的目录是否存在
		if (!file.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			if (!file.getParentFile().mkdirs()) {
				return false;
			}
		}
		// 创建目标文件
		try {
			if (file.createNewFile()) {
				return true;
			} else {
				return false;
			}
		} catch (IOException e) {
			return false;
		}
	}

	/**
	 * 将内容写进txt文件
	 * 
	 * @param content
	 * @param denoterTxt
	 * @return
	 * @throws Exception
	 */
	public static boolean writeTxtFile(StringBuffer content, String denoterTxt) {
		boolean flag = false;
		FileOutputStream outputStream = null;
		try {
			outputStream = new FileOutputStream(denoterTxt);
			outputStream.write(content.toString().getBytes("UTF-8"));
			outputStream.close();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * 整理txt文件内容
	 * @param filePath
	 * @param encoding
	 */
	public static HashMap<String, List<String>> orderTxtFile(String filePath, String encoding) {
		
		HashMap<String, List<String>> denoterMap=null;
		
		try {
			File file = new File(filePath);
			if (file.isFile() && file.exists()) { // 判断文件是否存在
				InputStreamReader read = new InputStreamReader(new FileInputStream(file), encoding);
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				
				denoterMap=new HashMap<String, List<String>>();
				
				while ((lineTxt = bufferedReader.readLine()) != null) {
					
					//如果是一个词，那么说明是事件类别
					if(lineTxt.split("\t").length==1){
						String denoterKey=lineTxt;
						List<String> denoterVal=new ArrayList<String>();
						
						//读取该事件的触发词
						lineTxt = bufferedReader.readLine();
						String[] strArray=lineTxt.split("\t");
						
						//寻找触发词出现频率大于2的，如果大于2则设置为触发词
						HashMap<String, Integer> lineMap=new HashMap<String, Integer>();
						for(String str:strArray)
						{
							Integer lineDenoterNum=lineMap.get(str);
							if(lineDenoterNum==null){
								lineMap.put(str, 1);
							}else{
								lineMap.put(str, lineMap.get(str)+1);
							}
						}
						
						Iterator<String> iterator = lineMap.keySet().iterator();  
						while (iterator.hasNext()){  
							String key=(String)iterator.next();
							if(lineMap.get(key)>1){
								denoterVal.add(key);
							}
						}
						
						denoterMap.put(denoterKey, denoterVal);
					}
				}
				read.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return denoterMap;

	}
}
