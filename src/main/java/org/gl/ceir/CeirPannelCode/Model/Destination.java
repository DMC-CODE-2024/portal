package org.gl.ceir.CeirPannelCode.Model;
public class Destination{
    public String destFilePath;
    public String destServerName;
	public String getDestFilePath() {
		return destFilePath;
	}
	public void setDestFilePath(String destFilePath) {
		this.destFilePath = destFilePath;
	}
	public String getDestServerName() {
		return destServerName;
	}
	public void setDestServerName(String destServerName) {
		this.destServerName = destServerName;
	}
	@Override
	public String toString() {
		return "Destination [destFilePath=" + destFilePath + ", destServerName=" + destServerName
				+ ", getDestFilePath()=" + getDestFilePath() + ", getDestServerName()=" + getDestServerName()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
    
    
}

