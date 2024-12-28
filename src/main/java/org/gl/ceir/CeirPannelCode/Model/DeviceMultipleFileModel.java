package org.gl.ceir.CeirPannelCode.Model;

public class DeviceMultipleFileModel {
	private String docTypeInterp,docType,url;
	private String fileName;
	private Integer id;
	private Integer mdrId;
	public String getDocTypeInterp() {
		return docTypeInterp;
	}
	public void setDocTypeInterp(String docTypeInterp) {
		this.docTypeInterp = docTypeInterp;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getMdrId() {
		return mdrId;
	}
	public void setMdrId(Integer mdrId) {
		this.mdrId = mdrId;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("DeviceMultipleFileModel [docTypeInterp=");
		builder.append(docTypeInterp);
		builder.append(", docType=");
		builder.append(docType);
		builder.append(", url=");
		builder.append(url);
		builder.append(", fileName=");
		builder.append(fileName);
		builder.append(", id=");
		builder.append(id);
		builder.append(", mdrId=");
		builder.append(mdrId);
		builder.append("]");
		return builder.toString();
	}
	
	
	
}
