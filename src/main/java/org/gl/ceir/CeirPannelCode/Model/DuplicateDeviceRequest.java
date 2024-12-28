package org.gl.ceir.CeirPannelCode.Model;

public class DuplicateDeviceRequest {
	private Integer pageNo, pageSize;
	private String sort;
	public String order,orderColumnName;
	
	//Filter Params
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String imei;
	private String imsi;
	private String msisdn;
	private String fileName;
	private Object edrTime;
	private String operator;
	private String updatedBy;
	private String status;
	private String stateInterp;
	
	//Approve params
	private String transactionId;
	private String documentType1;
	private String documentType2;
	private String documentType3;
	private String documentType4;
	private String documentFileName1;
	private String documentFileName2;
	private String documentFileName3;
	private String documentFileName4;
	private String approveTransactionId;
	private String approveRemark;
	private String issueId;

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

	private String redmineTktId;

	public String getIssueId() {
		return issueId;
	}

	public void setIssueId(String issueId) {
		this.issueId = issueId;
	}

	public String getRedmineTktId() {
		return redmineTktId;
	}

	public void setRedmineTktId(String redmineTktId) {
		this.redmineTktId = redmineTktId;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

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

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getOrderColumnName() {
		return orderColumnName;
	}

	public void setOrderColumnName(String orderColumnName) {
		this.orderColumnName = orderColumnName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getModifiedOn() {
		return modifiedOn;
	}

	public void setModifiedOn(String modifiedOn) {
		this.modifiedOn = modifiedOn;
	}

	public String getImei() {
		return imei;
	}

	public void setImei(String imei) {
		this.imei = imei;
	}

	public String getImsi() {
		return imsi;
	}

	public void setImsi(String imsi) {
		this.imsi = imsi;
	}

	public String getMsisdn() {
		return msisdn;
	}

	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Object getEdrTime() {
		return edrTime;
	}

	public void setEdrTime(Object edrTime) {
		this.edrTime = edrTime;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStateInterp() {
		return stateInterp;
	}

	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getDocumentType1() {
		return documentType1;
	}

	public void setDocumentType1(String documentType1) {
		this.documentType1 = documentType1;
	}

	public String getDocumentType2() {
		return documentType2;
	}

	public void setDocumentType2(String documentType2) {
		this.documentType2 = documentType2;
	}

	public String getDocumentType3() {
		return documentType3;
	}

	public void setDocumentType3(String documentType3) {
		this.documentType3 = documentType3;
	}

	public String getDocumentType4() {
		return documentType4;
	}

	public void setDocumentType4(String documentType4) {
		this.documentType4 = documentType4;
	}

	public String getDocumentFileName1() {
		return documentFileName1;
	}

	public void setDocumentFileName1(String documentFileName1) {
		this.documentFileName1 = documentFileName1;
	}

	public String getDocumentFileName2() {
		return documentFileName2;
	}

	public void setDocumentFileName2(String documentFileName2) {
		this.documentFileName2 = documentFileName2;
	}

	public String getDocumentFileName3() {
		return documentFileName3;
	}

	public void setDocumentFileName3(String documentFileName3) {
		this.documentFileName3 = documentFileName3;
	}

	public String getDocumentFileName4() {
		return documentFileName4;
	}

	public void setDocumentFileName4(String documentFileName4) {
		this.documentFileName4 = documentFileName4;
	}

	public String getApproveTransactionId() {
		return approveTransactionId;
	}

	public void setApproveTransactionId(String approveTransactionId) {
		this.approveTransactionId = approveTransactionId;
	}

	public String getApproveRemark() {
		return approveRemark;
	}

	public void setApproveRemark(String approveRemark) {
		this.approveRemark = approveRemark;
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

	@Override
	public String toString() {
		return "DuplicateDeviceRequest{" +
				"pageNo=" + pageNo +
				", pageSize=" + pageSize +
				", sort='" + sort + '\'' +
				", order='" + order + '\'' +
				", orderColumnName='" + orderColumnName + '\'' +
				", id=" + id +
				", createdOn='" + createdOn + '\'' +
				", modifiedOn='" + modifiedOn + '\'' +
				", imei='" + imei + '\'' +
				", imsi='" + imsi + '\'' +
				", msisdn='" + msisdn + '\'' +
				", fileName='" + fileName + '\'' +
				", edrTime=" + edrTime +
				", operator='" + operator + '\'' +
				", updatedBy='" + updatedBy + '\'' +
				", status='" + status + '\'' +
				", stateInterp='" + stateInterp + '\'' +
				", transactionId='" + transactionId + '\'' +
				", documentType1='" + documentType1 + '\'' +
				", documentType2='" + documentType2 + '\'' +
				", documentType3='" + documentType3 + '\'' +
				", documentType4='" + documentType4 + '\'' +
				", documentFileName1='" + documentFileName1 + '\'' +
				", documentFileName2='" + documentFileName2 + '\'' +
				", documentFileName3='" + documentFileName3 + '\'' +
				", documentFileName4='" + documentFileName4 + '\'' +
				", approveTransactionId='" + approveTransactionId + '\'' +
				", approveRemark='" + approveRemark + '\'' +
				", issueId='" + issueId + '\'' +
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
				", redmineTktId='" + redmineTktId + '\'' +
				'}';
	}
}
