package org.gl.ceir.CeirPannelCode.Model;

public class FileCopyToOtherServer {


private String copyEndOn;
private String copyStartOn;
private String copyStatus;
private String createdOn;
private String fileName;
private String filePath;
private Integer id;
private Integer retryCount;
private Integer serverId;
private String txnId;
private String deviceId;


public String getDeviceId() {
	return deviceId;
}

public void setDeviceId(String deviceId) {
	this.deviceId = deviceId;
}

public String getCopyEndOn() {
return copyEndOn;
}

public void setCopyEndOn(String copyEndOn) {
this.copyEndOn = copyEndOn;
}

public String getCopyStartOn() {
return copyStartOn;
}

public void setCopyStartOn(String copyStartOn) {
this.copyStartOn = copyStartOn;
}

public String getCopyStatus() {
return copyStatus;
}

public void setCopyStatus(String copyStatus) {
this.copyStatus = copyStatus;
}

public String getCreatedOn() {
return createdOn;
}

public void setCreatedOn(String createdOn) {
this.createdOn = createdOn;
}

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

public Integer getId() {
return id;
}

public void setId(Integer id) {
this.id = id;
}

public Integer getRetryCount() {
return retryCount;
}

public void setRetryCount(Integer retryCount) {
this.retryCount = retryCount;
}

public Integer getServerId() {
return serverId;
}

public void setServerId(Integer serverId) {
this.serverId = serverId;
}

public String getTxnId() {
return txnId;
}

public void setTxnId(String txnId) {
this.txnId = txnId;
}

@Override
public String toString() {
	return "FileCopyToOtherServer [copyEndOn=" + copyEndOn + ", copyStartOn=" + copyStartOn + ", copyStatus="
			+ copyStatus + ", createdOn=" + createdOn + ", fileName=" + fileName + ", filePath=" + filePath + ", id="
			+ id + ", retryCount=" + retryCount + ", serverId=" + serverId + ", txnId=" + txnId + ", deviceId="
			+ deviceId + "]";
}




}
