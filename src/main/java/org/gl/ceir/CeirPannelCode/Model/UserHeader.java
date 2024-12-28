package org.gl.ceir.CeirPannelCode.Model;

public class UserHeader {

	private String userAgent;
	private String publicIp;
	private String browser;
	public String getUserAgent() {
		return userAgent;
	}
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}
	public String getPublicIp() {
		return publicIp;
	}
	public void setPublicIp(String publicIp) {
		this.publicIp = publicIp;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("UserHeader [userAgent=");
		builder.append(userAgent);
		builder.append(", publicIp=");
		builder.append(publicIp);
		builder.append(", browser=");
		builder.append(browser);
		builder.append("]");
		return builder.toString();
	}
	public UserHeader(String userAgent, String publicIp,String browser) {
		super();
		this.userAgent = userAgent;
		this.publicIp = publicIp;
		this.browser=browser;
	}
	public UserHeader(String userAgent, String publicIp) {
		super();
		this.userAgent = userAgent;
		this.publicIp = publicIp;
	}
	public UserHeader() {
		super();
	}
	public String getBrowser() {
		return browser;
	}
	public void setBrowser(String browser) {
		this.browser = browser;
	}
	
}
