package org.gl.ceir.CeirPannelCode.Util;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;


@Component
public class UtilDownload {

	private Logger logger = (Logger) LogManager.getLogger(UtilDownload.class);
	
	private final static String NUMERIC_STRING = "0123456789";
	

	public UtilDownload() {
		// TODO Auto-generated constructor stub
	}
	
	/*
	 * public String randomNumericString(int count) { StringBuilder builder = new
	 * StringBuilder(); while (count-- != 0) { int character =
	 * (int)(Math.random()*NUMERIC_STRING.length());
	 * builder.append(NUMERIC_STRING.charAt(character)); }
	 * 
	 * return builder.toString(); }
	 * 
	 * public String createRequestId(int count) { return randomNumericString(15); }
	 */
	
	
	
	public String getTxnId() {

		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		String transactionId = dateFormat.format(date)+randomNumericString(3);	
		return transactionId;
	}

	public static String randomNumericString(int length) {
		StringBuilder builder = new StringBuilder();
		while (length-- != 0) {
			int character = (int)(Math.random()*NUMERIC_STRING.length());
			builder.append(NUMERIC_STRING.charAt(character));
		}
		return builder.toString();
	}
	
	public void downloadFileProperties(HttpServletRequest req, HttpServletResponse resp, 
			String toBeDownloadedFile, File downloadFile) {
		try {
			 System.out.println("in download properties...");
			/**** Get The Mime Type Of The File & Setting The Binary Type If The Mime Mapping Is Not Found ****/
			String mimeType = req.getSession().getServletContext().getMimeType(toBeDownloadedFile);
			if (mimeType == null) {
				mimeType = "application/octet-stream";
			}

			/**** Setting The Content Attributes For The Response Object ****/
			System.out.println("Setting The Content Attributes For The Response Object");
			resp.setContentType(mimeType);
			resp.setContentLength((int) downloadFile.length());

			/**** Setting The Headers For The Response Object ****/
			System.out.println("Setting The Headers For The Response Object");
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
			resp.setHeader(headerKey, headerValue);

			/**** Get The Output Stream Of The Response ****/
			System.out.println("Get The Output Stream Of The Response");
			
			OutputStream outStream = resp.getOutputStream();
			FileInputStream inputStream = new FileInputStream(downloadFile);
			byte[] buffer = new byte[IConstants.BUFFER_SIZE];
			int bytesRead = -1;

			/**** Write Each Byte Of Data Read From The Input Stream Write Each Byte Of Data  Read From The Input Stream Into The Output Stream ****/
			System.out.println("Write Each Byte Of Data");
			while ((bytesRead = inputStream.read(buffer)) != -1) {
				System.out.println();
				outStream.write(buffer, 0, bytesRead);
			}

			System.out.println("Writing data completed.");
			inputStream.close();
			outStream.close();
			
			System.out.println("Stream Closed.");
		} catch(IOException ioExObj) {
			logger.error("Exception While Performing The I/O Operation?= " + ioExObj);
		}
	}
	
	/*
	 * public HashMap<String,List<PanelContentModal>>
	 * getCategoryWiseContent(List<PanelContentModal> list) {
	 * 
	 * HashMap<String,List<PanelContentModal>> cat= new HashMap<>(); for(int
	 * i=0;i<list.size();i++) { PanelContentModal panel=list.get(i); String
	 * category=panel.getCategoryname(); if(cat.containsKey(category)) {
	 * if(cat.get(category).size()<3) { cat.get(category).add(panel); } } else {
	 * List<PanelContentModal> newcat= new ArrayList<PanelContentModal>();
	 * newcat.add(panel); cat.put(category,newcat); } }
	 * System.out.println("HashMap"+cat); return cat; }
	 */
	
	
	  public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	  {
	    res.setContentType("text/html");
	    PrintWriter out = res.getWriter();
	 
	    String str = req.getRequestURI();
	    out.println("req.getRequestURI():" + str);
	 System.out.println("url"+str);
	    out.close();
	  }
	  
	  
	  public  void delete(File bh) 
	    { 
	        //File file = new File("C:\\Users\\Mayank\\Desktop\\1.txt"); 
		 System.out.println("in delete method"); 
	        if(bh.delete()) 
	        { 
	            System.out.println("File deleted successfully"); 
	        } 
	        else
	        { 
	            System.out.println("Failed to delete the file"); 
	        } 
	    } 
	 
	
}
