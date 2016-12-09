package com.txt;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * �ı�Ԥ����
 * @author chenbin
 *
 */
public class TxtDeal {
	
	//URL������ʽ
    public static Pattern URL_Pattern = Pattern.compile("(http://|ftp://|https://|www){0,1}[^\u4e00-\u9fa5\\s]*?\\.(com|net|cn|me|tw|fr)[^\u4e00-\u9fa5\\s]*"); 
    //@�û� ������ʽ
    public static Pattern AT_PATTERN = Pattern.compile("@[\\u4e00-\\u9fa5\\w\\-]+");
	
	/**
	 * �ı�����ȥ������
	 * @param originPath Դ�ļ�
	 * @param outputPath ����ļ�
	 */
	public static void weiboTxtDeal(String originPath,String outputPath)
	{
        Matcher matcher=null;
		
        //�����ļ�
		File file = null;
		BufferedReader br=null;
		//д���ļ�
		FileWriter writer=null;
		
		try {
			file=new File(originPath);
			br=new BufferedReader(new InputStreamReader(new FileInputStream(file),"UTF-8"));
			
			writer = new FileWriter(outputPath);
			
			String lineTxt=null;
			while((lineTxt = br.readLine()) != null){
				String[] lineArr=lineTxt.split("\t");
				if(lineArr.length==25)
				{
					//��ȡ��ǰ��
					String str=lineArr[18];

					//����URL��
			        matcher = URL_Pattern.matcher(str);
			        if(matcher.find()){
			        	continue;
			        }
			        //@�û���
			        matcher=AT_PATTERN.matcher(str);
			        if(matcher.find()){
			        	continue;
			        }
			        //ɾ��str�еı��飬����������������[]
			        str=str.replaceAll("\\[([^\\[\\]]+)\\]", "");
			        //ɾ��΢���еĻ���
			        str=str.replaceAll("#([^\\#|.]+)#", "");
			        //ɾ��ת��΢��������ͼƬ
			        str=str.replaceAll("ת��΢��", "");
			        str=str.replaceAll("����ͼƬ", "");
					
					//ɸѡ������̫�ٵģ�����10�����ֵģ�
					if(str.length()<10)
					{
						continue;
					}
			        
					writer.write(str+"\r\n");
				}
			}
			System.out.println("�������\t");
			
            writer.flush();
            writer.close();
			br.close();
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			
		}
	}
	
}
