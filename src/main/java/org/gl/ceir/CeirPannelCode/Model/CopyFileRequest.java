package org.gl.ceir.CeirPannelCode.Model;

import java.util.ArrayList;

public class CopyFileRequest{
   
	public String appName;
    public ArrayList<Destination> destination;
    public String remarks;
    public String serverName;
    public String sourceFileName;
    public String sourceFilePath;
    public String sourceServerName;
    public String txnId;
    
	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public ArrayList<Destination> getDestination() {
		return destination;
	}

	public void setDestination(ArrayList<Destination> destination) {
		this.destination = destination;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public String getSourceFileName() {
		return sourceFileName;
	}

	public void setSourceFileName(String sourceFileName) {
		this.sourceFileName = sourceFileName;
	}

	public String getSourceFilePath() {
		return sourceFilePath;
	}

	public void setSourceFilePath(String sourceFilePath) {
		this.sourceFilePath = sourceFilePath;
	}

	public String getSourceServerName() {
		return sourceServerName;
	}

	public void setSourceServerName(String sourceServerName) {
		this.sourceServerName = sourceServerName;
	}

	public String getTxnId() {
		return txnId;
	}

	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}

	@Override
	public String toString() {
		return "CopyFileRequest [appName=" + appName + ", destination=" + destination + ", remarks=" + remarks
				+ ", serverName=" + serverName + ", sourceFileName=" + sourceFileName + ", sourceFilePath="
				+ sourceFilePath + ", sourceServerName=" + sourceServerName + ", txnId=" + txnId + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
    
}