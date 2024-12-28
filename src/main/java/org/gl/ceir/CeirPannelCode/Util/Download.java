package org.gl.ceir.CeirPannelCode.Util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

public class Download {

	
	
public static void saveImage(String imageUrl) throws IOException {
		
		URL url = new URL(imageUrl);
		String fileName = url.getFile();
		
		String destName =fileName.substring(fileName.lastIndexOf("/"));
		System.out.println("destnation path"+destName);
	 
		InputStream is = url.openStream();
		OutputStream os = new FileOutputStream(destName);
		System.out.println("after outputstream"+os);
		byte[] b = new byte[2048];
		int length;
	 
		while ((length = is.read(b)) != -1) {
			os.write(b, 0, length);
		}
		System.out.println("after while");
		is.close();
		os.close();
	}
}
