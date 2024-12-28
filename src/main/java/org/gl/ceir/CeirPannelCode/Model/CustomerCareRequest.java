package org.gl.ceir.CeirPannelCode.Model;

public class CustomerCareRequest {
	private String deviceIdType;
	private String imei;
	private String msisdn;
	private String searchString;
	private Integer userId;
	private String userType;
	private Integer userTypeId;
	private Integer featureId;
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("CustomerCareRequest [deviceIdType=");
		builder.append(deviceIdType);
		builder.append(", imei=");
		builder.append(imei);
		builder.append(", msisdn=");
		builder.append(msisdn);
		builder.append(", searchString=");
		builder.append(searchString);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", userType=");
		builder.append(userType);
		builder.append(", userTypeId=");
		builder.append(userTypeId);
		builder.append(", featureId=");
		builder.append(featureId);
		builder.append("]");
		return builder.toString();
	}
	public String getDeviceIdType() {
		return deviceIdType;
	}
	public void setDeviceIdType(String deviceIdType) {
		this.deviceIdType = deviceIdType;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getMsisdn() {
		return msisdn;
	}
	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	

	
	
}
