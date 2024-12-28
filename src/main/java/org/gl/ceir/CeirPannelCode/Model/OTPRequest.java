package org.gl.ceir.CeirPannelCode.Model;

public class OTPRequest {

	private String otpBox1;
	private String otpBox2;
	private String otpBox3;
	private String otpBox4;
	private String otpBox5;
	private String otpBox6;
	private int statusCode;
	private String requestID;
	private String requestType;
	private String statusMsg;
	private String otp;
	private String oldRequestID;
	private String browser;
	private String publicIp;
	private String userAgent;
	private String lang;
	
	private String userId,userType,username;

	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getOtpBox1() {
		return otpBox1;
	}
	public void setOtpBox1(String otpBox1) {
		this.otpBox1 = otpBox1;
	}
	public String getOtpBox2() {
		return otpBox2;
	}
	public void setOtpBox2(String otpBox2) {
		this.otpBox2 = otpBox2;
	}
	public String getOtpBox3() {
		return otpBox3;
	}
	public void setOtpBox3(String otpBox3) {
		this.otpBox3 = otpBox3;
	}
	public String getOtpBox4() {
		return otpBox4;
	}
	public void setOtpBox4(String otpBox4) {
		this.otpBox4 = otpBox4;
	}
	public String getRequestID() {
		return requestID;
	}
	public void setRequestID(String requestID) {
		this.requestID = requestID;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public int getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
	public String getStatusMsg() {
		return statusMsg;
	}
	public void setStatusMsg(String statusMsg) {
		this.statusMsg = statusMsg;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public String getOldRequestID() {
		return oldRequestID;
	}
	public void setOldRequestID(String oldRequestID) {
		this.oldRequestID = oldRequestID;
	}

	public String getOtpBox5() {
		return otpBox5;
	}

	public void setOtpBox5(String otpBox5) {
		this.otpBox5 = otpBox5;
	}

	public String getOtpBox6() {
		return otpBox6;
	}

	public void setOtpBox6(String otpBox6) {
		this.otpBox6 = otpBox6;
	}

	public String getBrowser() {
		return browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	public String getPublicIp() {
		return publicIp;
	}

	public void setPublicIp(String publicIp) {
		this.publicIp = publicIp;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "OTPRequest{" +
				"otpBox1='" + otpBox1 + '\'' +
				", otpBox2='" + otpBox2 + '\'' +
				", otpBox3='" + otpBox3 + '\'' +
				", otpBox4='" + otpBox4 + '\'' +
				", otpBox5='" + otpBox5 + '\'' +
				", otpBox6='" + otpBox6 + '\'' +
				", statusCode=" + statusCode +
				", requestID='" + requestID + '\'' +
				", requestType='" + requestType + '\'' +
				", statusMsg='" + statusMsg + '\'' +
				", otp='" + otp + '\'' +
				", oldRequestID='" + oldRequestID + '\'' +
				", browser='" + browser + '\'' +
				", publicIp='" + publicIp + '\'' +
				", userAgent='" + userAgent + '\'' +
				", userId='" + userId + '\'' +
				", userType='" + userType + '\'' +
				", username='" + username + '\'' +
				'}';
	}
}
