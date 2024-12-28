package org.gl.ceir.CeirPannelCode.Model;
public class TrackLostDeviceFilterRequest {
	private Long id;
	private Integer pageNo, pageSize;
	public String startDate;
	public String endDate;
	public String createdOn;
	public String modifiedOn;
	private String imei;
	private String imsi;
	private String edrTime;
	private String updatedBy;
	private String status;
	public Integer userId;
	public String userType;
	private String publicIp;
	private String browser;
	private String searchString;
	private Integer featureId;
	private Integer userTypeId;
	private String orderColumnName;
	private String order;
	private String sort;
	private String msisdn;
	private String operator;
	private String requestNo;
	private String fileName,remarks,requestMode,requestType,province,district,commune,uploadedBy,deviceType,lang;

	public AuditTrailModel auditTrailModel;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
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
	public String getEdrTime() {
		return edrTime;
	}
	public void setEdrTime(String edrTime) {
		this.edrTime = edrTime;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}
	public String getOrderColumnName() {
		return orderColumnName;
	}
	public void setOrderColumnName(String orderColumnName) {
		this.orderColumnName = orderColumnName;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getMsisdn() {
		return msisdn;
	}
	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getRequestNo() {
		return requestNo;
	}
	public void setRequestNo(String requestNo) {
		this.requestNo = requestNo;
	}
	public AuditTrailModel getAuditTrailModel() {
		return auditTrailModel;
	}
	public void setAuditTrailModel(AuditTrailModel auditTrailModel) {
		this.auditTrailModel = auditTrailModel;
	}
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String getImsi() {
		return imsi;
	}
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}
	
	public String getRequestMode() {
		return requestMode;
	}
	public void setRequestMode(String requestMode) {
		this.requestMode = requestMode;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getCommune() {
		return commune;
	}
	public void setCommune(String commune) {
		this.commune = commune;
	}


	public String getUploadedBy() {
		return uploadedBy;
	}

	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}
	

	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	@Override
	public String toString() {
		return "TrackLostDeviceFilterRequest [id=" + id + ", pageNo=" + pageNo + ", pageSize=" + pageSize
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", createdOn=" + createdOn + ", modifiedOn="
				+ modifiedOn + ", imei=" + imei + ", imsi=" + imsi + ", edrTime=" + edrTime + ", updatedBy=" + updatedBy
				+ ", status=" + status + ", userId=" + userId + ", userType=" + userType + ", publicIp=" + publicIp
				+ ", browser=" + browser + ", searchString=" + searchString + ", featureId=" + featureId
				+ ", userTypeId=" + userTypeId + ", orderColumnName=" + orderColumnName + ", order=" + order + ", sort="
				+ sort + ", msisdn=" + msisdn + ", operator=" + operator + ", requestNo=" + requestNo + ", fileName="
				+ fileName + ", remarks=" + remarks + ", requestMode=" + requestMode + ", requestType=" + requestType
				+ ", province=" + province + ", district=" + district + ", commune=" + commune + ", uploadedBy="
				+ uploadedBy + ", deviceType=" + deviceType + ", lang=" + lang + ", auditTrailModel=" + auditTrailModel
				+ "]";
	}

}
