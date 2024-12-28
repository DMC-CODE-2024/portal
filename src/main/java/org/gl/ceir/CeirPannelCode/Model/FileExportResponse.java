package org.gl.ceir.CeirPannelCode.Model;

public class FileExportResponse {

	private String fileName,filePath,url;
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

@Override
	public String toString() {
		return "FileExportResponse [fileName=" + fileName + ", filePath=" + filePath + ", url=" + url + "]";
	}
	
	
	
}
