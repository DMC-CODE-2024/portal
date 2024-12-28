package org.gl.ceir.CeirPannelCode.Model;

public class CheckImeiRequest {
	private String captcha;
	private String imei;
	private String channel;
	private String language;
	private String medium;
	private Integer msisdn;
	private String operator;
	private String createdOn;
	private Integer id;
	private String imeiProcessStatus;
	private String requestProcessStatus;
	private String utm_source;
	private String browser;
	private String publicIp;
	private String symbol_color;
	public String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getMedium() {
		return medium;
	}
	public void setMedium(String medium) {
		this.medium = medium;
	}
	public Integer getMsisdn() {
		return msisdn;
	}
	public void setMsisdn(Integer msisdn) {
		this.msisdn = msisdn;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getImeiProcessStatus() {
		return imeiProcessStatus;
	}
	public void setImeiProcessStatus(String imeiProcessStatus) {
		this.imeiProcessStatus = imeiProcessStatus;
	}
	public String getRequestProcessStatus() {
		return requestProcessStatus;
	}
	public void setRequestProcessStatus(String requestProcessStatus) {
		this.requestProcessStatus = requestProcessStatus;
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
	public String getUtm_source() {
		return utm_source;
	}
	public void setUtm_source(String utm_source) {
		this.utm_source = utm_source;
	}
	public String getSymbol_color() {
		return symbol_color;
	}
	public void setSymbol_color(String symbol_color) {
		this.symbol_color = symbol_color;
	}
	@Override
	public String toString() {
		return "CheckImeiRequest [captcha=" + captcha + ", imei=" + imei + ", channel=" + channel + ", language="
				+ language + ", medium=" + medium + ", msisdn=" + msisdn + ", operator=" + operator + ", createdOn="
				+ createdOn + ", id=" + id + ", imeiProcessStatus=" + imeiProcessStatus + ", requestProcessStatus="
				+ requestProcessStatus + ", utm_source=" + utm_source + ", browser=" + browser + ", publicIp="
				+ publicIp + ", symbol_color=" + symbol_color + "]";
	}
	
	
}