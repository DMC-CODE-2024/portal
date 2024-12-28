package org.gl.ceir.CeirPannelCode.Model;

public class AttachedFile {

	private String docType;
	private String docTypeInterp;
	private String fileName;
	private Integer id;
	private String TxnId;
	private Integer mdrId;
	private String url;
	public Integer getMdrId() {
		return mdrId;
	}
	public void setMdrId(Integer mdrId) {
		this.mdrId = mdrId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	public String getDocTypeInterp() {
		return docTypeInterp;
	}
	public void setDocTypeInterp(String docTypeInterp) {
		this.docTypeInterp = docTypeInterp;
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
	public String getTxnId() {
		return TxnId;
	}
	public void setTxnId(String txnId) {
		TxnId = txnId;
	}
	@Override
	public String toString() {
		return "AttachedFile [docType=" + docType + ", docTypeInterp=" + docTypeInterp + ", fileName=" + fileName
				+ ", id=" + id + ", TxnId=" + TxnId + ", mdrId=" + mdrId + ", url=" + url + "]";
	}
	
	
	
	
	
}
