package org.gl.ceir.CeirPannelCode.Model;

public class SearchIMEIRequest {
	private Integer pageNo, pageSize;
	private String imei;
	private String msisdn;
	private String requestId;

	//Audit Params
	private Integer featureId;
	private Integer userId;
	private String userName;
	private Integer userTypeId;
	private String userType;
	private String featureName;
	private String subFeature;
	private String getjSessionId;
	private String roleType;
	private String publicIp;
	private String browser;
	
	private Integer id;
	private String tableName;


	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
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

	public String getRequestId() {
		return requestId;
	}

	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}

	public Integer getFeatureId() {
		return featureId;
	}

	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getUserTypeId() {
		return userTypeId;
	}

	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getFeatureName() {
		return featureName;
	}

	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}

	public String getSubFeature() {
		return subFeature;
	}

	public void setSubFeature(String subFeature) {
		this.subFeature = subFeature;
	}

	public String getGetjSessionId() {
		return getjSessionId;
	}

	public void setGetjSessionId(String getjSessionId) {
		this.getjSessionId = getjSessionId;
	}

	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}

	public String getPublicIp() {
		return publicIp;
	}

	public void setPublicIp(String publicIp) {
		this.publicIp = publicIp;
	}

	public String getBrowser() {
		return browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	@Override
	public String toString() {
		return "SearchIMEIRequest{" +
				"pageNo=" + pageNo +
				", pageSize=" + pageSize +
				", imei='" + imei + '\'' +
				", msisdn='" + msisdn + '\'' +
				", requestId='" + requestId + '\'' +
				", featureId=" + featureId +
				", userId=" + userId +
				", userName='" + userName + '\'' +
				", userTypeId=" + userTypeId +
				", userType='" + userType + '\'' +
				", featureName='" + featureName + '\'' +
				", subFeature='" + subFeature + '\'' +
				", getjSessionId='" + getjSessionId + '\'' +
				", roleType='" + roleType + '\'' +
				", publicIp='" + publicIp + '\'' +
				", browser='" + browser + '\'' +
				", id=" + id +
				", tableName='" + tableName + '\'' +
				'}';
	}
}
