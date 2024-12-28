package org.gl.ceir.CeirPannelCode.Model;

import org.springframework.stereotype.Component;

@Component
public class FilterRequest {
	public String startDate,endDate,createdOn,modifiedOn,roleType,userType,txnId,searchString,grievanceId,tag,remarks,deviceId,nid,childTag,field,interp,tagId,value,displayName,description,address,featureName,subFeatureName,userName,date,fileName,invoiceNumber,suplierName,supplierId,stateInterp,alertId,remark,email,phoneNo,username,tac,userDisplayName,filterUserName,FilterUserType,raisedBy,filteredUserType,month,source;
	private Integer pageNo, pageSize,userId,taxPaidStatus,consignmentStatus,featureId,userTypeId,fileStatus,requestType,sourceType,grievanceStatus,userRoleTypeId,status,asType,serviceDump,fileType,action,operatorTypeId,channel,type,deviceIdType,parentValue,id,port,currency,stockStatus,feature,period,year,dataId,usertypeId;
	private Double dollar,riel;
	private int roleTypeId;
	private String state,ruleName,quantity,deviceQuantity,supplierName;
	public String province,district,commune,village,country,localityId;
	public String publicIp;
	private int districtID,communeID;
	public String category,reportName,flag,emailId;
	public String columnName,sort,blockingTypeFilter;
	public String visaType,visaNumber,visaExpiryDate;
	public String order,orderColumnName;
	private String browser,filteredUsername,name,subject;
	public String msisdn,imei,imsi,identifierType;
	
	private String graceAction,postGraceAction,ruleOrder,failedRuleActionGrace,failedRuleActionPostGrace,output;
	public String filterPublicIp,filterBrowser,language;
	public String label,englishName,khmerName,sno,moduleName, moduleStatus,copyStatus,listType,police;
	public String getFilteredUsername() {
		return filteredUsername;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public void setFilteredUsername(String filteredUsername) {
		this.filteredUsername = filteredUsername;
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
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public String getGrievanceId() {
		return grievanceId;
	}
	public void setGrievanceId(String grievanceId) {
		this.grievanceId = grievanceId;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	public String getChildTag() {
		return childTag;
	}
	public void setChildTag(String childTag) {
		this.childTag = childTag;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getInterp() {
		return interp;
	}
	public void setInterp(String interp) {
		this.interp = interp;
	}
	public String getTagId() {
		return tagId;
	}
	public void setTagId(String tagId) {
		this.tagId = tagId;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	public String getSubFeatureName() {
		return subFeatureName;
	}
	public void setSubFeatureName(String subFeatureName) {
		this.subFeatureName = subFeatureName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getInvoiceNumber() {
		return invoiceNumber;
	}
	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}
	public String getSuplierName() {
		return suplierName;
	}
	public void setSuplierName(String suplierName) {
		this.suplierName = suplierName;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public String getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}
	public String getAlertId() {
		return alertId;
	}
	public void setAlertId(String alertId) {
		this.alertId = alertId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTac() {
		return tac;
	}
	public void setTac(String tac) {
		this.tac = tac;
	}
	public String getUserDisplayName() {
		return userDisplayName;
	}
	public void setUserDisplayName(String userDisplayName) {
		this.userDisplayName = userDisplayName;
	}
	public String getFilterUserName() {
		return filterUserName;
	}
	public void setFilterUserName(String filterUserName) {
		this.filterUserName = filterUserName;
	}
	public String getFilterUserType() {
		return FilterUserType;
	}
	public void setFilterUserType(String filterUserType) {
		FilterUserType = filterUserType;
	}
	public String getRaisedBy() {
		return raisedBy;
	}
	public void setRaisedBy(String raisedBy) {
		this.raisedBy = raisedBy;
	}
	public String getFilteredUserType() {
		return filteredUserType;
	}
	public void setFilteredUserType(String filteredUserType) {
		this.filteredUserType = filteredUserType;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
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
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getTaxPaidStatus() {
		return taxPaidStatus;
	}
	public void setTaxPaidStatus(Integer taxPaidStatus) {
		this.taxPaidStatus = taxPaidStatus;
	}
	public Integer getConsignmentStatus() {
		return consignmentStatus;
	}
	public void setConsignmentStatus(Integer consignmentStatus) {
		this.consignmentStatus = consignmentStatus;
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
	public Integer getFileStatus() {
		return fileStatus;
	}
	public void setFileStatus(Integer fileStatus) {
		this.fileStatus = fileStatus;
	}
	public Integer getRequestType() {
		return requestType;
	}
	public void setRequestType(Integer requestType) {
		this.requestType = requestType;
	}
	public Integer getSourceType() {
		return sourceType;
	}
	public void setSourceType(Integer sourceType) {
		this.sourceType = sourceType;
	}
	public Integer getGrievanceStatus() {
		return grievanceStatus;
	}
	public void setGrievanceStatus(Integer grievanceStatus) {
		this.grievanceStatus = grievanceStatus;
	}
	public Integer getUserRoleTypeId() {
		return userRoleTypeId;
	}
	public void setUserRoleTypeId(Integer userRoleTypeId) {
		this.userRoleTypeId = userRoleTypeId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getAsType() {
		return asType;
	}
	public void setAsType(Integer asType) {
		this.asType = asType;
	}
	public Integer getServiceDump() {
		return serviceDump;
	}
	public void setServiceDump(Integer serviceDump) {
		this.serviceDump = serviceDump;
	}
	public Integer getFileType() {
		return fileType;
	}
	public void setFileType(Integer fileType) {
		this.fileType = fileType;
	}
	public Integer getAction() {
		return action;
	}
	public void setAction(Integer action) {
		this.action = action;
	}
	public Integer getOperatorTypeId() {
		return operatorTypeId;
	}
	public void setOperatorTypeId(Integer operatorTypeId) {
		this.operatorTypeId = operatorTypeId;
	}
	public Integer getChannel() {
		return channel;
	}
	public void setChannel(Integer channel) {
		this.channel = channel;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getDeviceIdType() {
		return deviceIdType;
	}
	public void setDeviceIdType(Integer deviceIdType) {
		this.deviceIdType = deviceIdType;
	}
	public Integer getParentValue() {
		return parentValue;
	}
	public void setParentValue(Integer parentValue) {
		this.parentValue = parentValue;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPort() {
		return port;
	}
	public void setPort(Integer port) {
		this.port = port;
	}
	public Integer getCurrency() {
		return currency;
	}
	public void setCurrency(Integer currency) {
		this.currency = currency;
	}
	 
	public Integer getStockStatus() {
		return stockStatus;
	}
	public void setStockStatus(Integer stockStatus) {
		this.stockStatus = stockStatus;
	}
	public Integer getFeature() {
		return feature;
	}
	public void setFeature(Integer feature) {
		this.feature = feature;
	}
	public Integer getPeriod() {
		return period;
	}
	public void setPeriod(Integer period) {
		this.period = period;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getDataId() {
		return dataId;
	}
	public void setDataId(Integer dataId) {
		this.dataId = dataId;
	}
	public Integer getUsertypeId() {
		return usertypeId;
	}
	public void setUsertypeId(Integer usertypeId) {
		this.usertypeId = usertypeId;
	}
	public Double getDollar() {
		return dollar;
	}
	public void setDollar(Double dollar) {
		this.dollar = dollar;
	}
	public Double getRiel() {
		return riel;
	}
	public void setRiel(Double riel) {
		this.riel = riel;
	}
	public int getRoleTypeId() {
		return roleTypeId;
	}
	public void setRoleTypeId(int roleTypeId) {
		this.roleTypeId = roleTypeId;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRuleName() {
		return ruleName;
	}
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
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
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPublicIp() {
		return publicIp;
	}
	public void setPublicIp(String publicIp) {
		this.publicIp = publicIp;
	}
	public int getDistrictID() {
		return districtID;
	}
	public void setDistrictID(int districtID) {
		this.districtID = districtID;
	}
	public int getCommuneID() {
		return communeID;
	}
	public void setCommuneID(int communeID) {
		this.communeID = communeID;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getDeviceQuantity() {
		return deviceQuantity;
	}
	public void setDeviceQuantity(String deviceQuantity) {
		this.deviceQuantity = deviceQuantity;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	
	
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getBlockingTypeFilter() {
		return blockingTypeFilter;
	}
	public void setBlockingTypeFilter(String blockingTypeFilter) {
		this.blockingTypeFilter = blockingTypeFilter;
	}
	public String getLocalityId() {
		return localityId;
	}
	public void setLocalityId(String localityId) {
		this.localityId = localityId;
	}
	public String getVisaType() {
		return visaType;
	}
	public void setVisaType(String visaType) {
		this.visaType = visaType;
	}
	public String getVisaNumber() {
		return visaNumber;
	}
	public void setVisaNumber(String visaNumber) {
		this.visaNumber = visaNumber;
	}
	public String getVisaExpiryDate() {
		return visaExpiryDate;
	}
	public void setVisaExpiryDate(String visaExpiryDate) {
		this.visaExpiryDate = visaExpiryDate;
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
	public String getBrowser() {
		return browser;
	}
	public void setBrowser(String browser) {
		this.browser = browser;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMsisdn() {
		return msisdn;
	}
	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getIdentifierType() {
		return identifierType;
	}
	public void setIdentifierType(String identifierType) {
		this.identifierType = identifierType;
	}
	
	public String getGraceAction() {
		return graceAction;
	}
	public void setGraceAction(String graceAction) {
		this.graceAction = graceAction;
	}
	public String getPostGraceAction() {
		return postGraceAction;
	}
	public void setPostGraceAction(String postGraceAction) {
		this.postGraceAction = postGraceAction;
	}
	public String getRuleOrder() {
		return ruleOrder;
	}
	public void setRuleOrder(String ruleOrder) {
		this.ruleOrder = ruleOrder;
	}
	public String getFailedRuleActionGrace() {
		return failedRuleActionGrace;
	}
	public void setFailedRuleActionGrace(String failedRuleActionGrace) {
		this.failedRuleActionGrace = failedRuleActionGrace;
	}
	public String getFailedRuleActionPostGrace() {
		return failedRuleActionPostGrace;
	}
	public void setFailedRuleActionPostGrace(String failedRuleActionPostGrace) {
		this.failedRuleActionPostGrace = failedRuleActionPostGrace;
	}
	public String getOutput() {
		return output;
	}
	public void setOutput(String output) {
		this.output = output;
	}
	public String getFilterPublicIp() {
		return filterPublicIp;
	}
	public void setFilterPublicIp(String filterPublicIp) {
		this.filterPublicIp = filterPublicIp;
	}
	public String getFilterBrowser() {
		return filterBrowser;
	}
	public void setFilterBrowser(String filterBrowser) {
		this.filterBrowser = filterBrowser;
	}
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getEnglishName() {
		return englishName;
	}
	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	public String getKhmerName() {
		return khmerName;
	}
	public void setKhmerName(String khmerName) {
		this.khmerName = khmerName;
	}
	public String getImsi() {
		return imsi;
	}
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}
	
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
	public String getModuleStatus() {
		return moduleStatus;
	}
	public void setModuleStatus(String moduleStatus) {
		this.moduleStatus = moduleStatus;
	}
	
	public String getCopyStatus() {
		return copyStatus;
	}
	public void setCopyStatus(String copyStatus) {
		this.copyStatus = copyStatus;
	}
	public String getListType() {
		return listType;
	}
	public void setListType(String listType) {
		this.listType = listType;
	}

	public String actionName;

	public String getActionName() {
		return actionName;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public String getPolice() {
		return police;
	}

	public void setPolice(String police) {
		this.police = police;
	}

	@Override
	public String toString() {
		return "FilterRequest{" +
				"startDate='" + startDate + '\'' +
				", endDate='" + endDate + '\'' +
				", createdOn='" + createdOn + '\'' +
				", modifiedOn='" + modifiedOn + '\'' +
				", roleType='" + roleType + '\'' +
				", userType='" + userType + '\'' +
				", txnId='" + txnId + '\'' +
				", searchString='" + searchString + '\'' +
				", grievanceId='" + grievanceId + '\'' +
				", tag='" + tag + '\'' +
				", remarks='" + remarks + '\'' +
				", deviceId='" + deviceId + '\'' +
				", nid='" + nid + '\'' +
				", childTag='" + childTag + '\'' +
				", field='" + field + '\'' +
				", interp='" + interp + '\'' +
				", tagId='" + tagId + '\'' +
				", value='" + value + '\'' +
				", displayName='" + displayName + '\'' +
				", description='" + description + '\'' +
				", address='" + address + '\'' +
				", featureName='" + featureName + '\'' +
				", subFeatureName='" + subFeatureName + '\'' +
				", userName='" + userName + '\'' +
				", date='" + date + '\'' +
				", fileName='" + fileName + '\'' +
				", invoiceNumber='" + invoiceNumber + '\'' +
				", suplierName='" + suplierName + '\'' +
				", supplierId='" + supplierId + '\'' +
				", stateInterp='" + stateInterp + '\'' +
				", alertId='" + alertId + '\'' +
				", remark='" + remark + '\'' +
				", email='" + email + '\'' +
				", phoneNo='" + phoneNo + '\'' +
				", username='" + username + '\'' +
				", tac='" + tac + '\'' +
				", userDisplayName='" + userDisplayName + '\'' +
				", filterUserName='" + filterUserName + '\'' +
				", FilterUserType='" + FilterUserType + '\'' +
				", raisedBy='" + raisedBy + '\'' +
				", filteredUserType='" + filteredUserType + '\'' +
				", month='" + month + '\'' +
				", source='" + source + '\'' +
				", pageNo=" + pageNo +
				", pageSize=" + pageSize +
				", userId=" + userId +
				", taxPaidStatus=" + taxPaidStatus +
				", consignmentStatus=" + consignmentStatus +
				", featureId=" + featureId +
				", userTypeId=" + userTypeId +
				", fileStatus=" + fileStatus +
				", requestType=" + requestType +
				", sourceType=" + sourceType +
				", grievanceStatus=" + grievanceStatus +
				", userRoleTypeId=" + userRoleTypeId +
				", status=" + status +
				", asType=" + asType +
				", serviceDump=" + serviceDump +
				", fileType=" + fileType +
				", action=" + action +
				", operatorTypeId=" + operatorTypeId +
				", channel=" + channel +
				", type=" + type +
				", deviceIdType=" + deviceIdType +
				", parentValue=" + parentValue +
				", id=" + id +
				", port=" + port +
				", currency=" + currency +
				", stockStatus=" + stockStatus +
				", feature=" + feature +
				", period=" + period +
				", year=" + year +
				", dataId=" + dataId +
				", usertypeId=" + usertypeId +
				", dollar=" + dollar +
				", riel=" + riel +
				", roleTypeId=" + roleTypeId +
				", state='" + state + '\'' +
				", ruleName='" + ruleName + '\'' +
				", quantity='" + quantity + '\'' +
				", deviceQuantity='" + deviceQuantity + '\'' +
				", supplierName='" + supplierName + '\'' +
				", province='" + province + '\'' +
				", district='" + district + '\'' +
				", commune='" + commune + '\'' +
				", village='" + village + '\'' +
				", country='" + country + '\'' +
				", localityId='" + localityId + '\'' +
				", publicIp='" + publicIp + '\'' +
				", districtID=" + districtID +
				", communeID=" + communeID +
				", category='" + category + '\'' +
				", reportName='" + reportName + '\'' +
				", flag='" + flag + '\'' +
				", emailId='" + emailId + '\'' +
				", columnName='" + columnName + '\'' +
				", sort='" + sort + '\'' +
				", blockingTypeFilter='" + blockingTypeFilter + '\'' +
				", visaType='" + visaType + '\'' +
				", visaNumber='" + visaNumber + '\'' +
				", visaExpiryDate='" + visaExpiryDate + '\'' +
				", order='" + order + '\'' +
				", orderColumnName='" + orderColumnName + '\'' +
				", browser='" + browser + '\'' +
				", filteredUsername='" + filteredUsername + '\'' +
				", name='" + name + '\'' +
				", subject='" + subject + '\'' +
				", msisdn='" + msisdn + '\'' +
				", imei='" + imei + '\'' +
				", imsi='" + imsi + '\'' +
				", identifierType='" + identifierType + '\'' +
				", graceAction='" + graceAction + '\'' +
				", postGraceAction='" + postGraceAction + '\'' +
				", ruleOrder='" + ruleOrder + '\'' +
				", failedRuleActionGrace='" + failedRuleActionGrace + '\'' +
				", failedRuleActionPostGrace='" + failedRuleActionPostGrace + '\'' +
				", output='" + output + '\'' +
				", filterPublicIp='" + filterPublicIp + '\'' +
				", filterBrowser='" + filterBrowser + '\'' +
				", language='" + language + '\'' +
				", label='" + label + '\'' +
				", englishName='" + englishName + '\'' +
				", khmerName='" + khmerName + '\'' +
				", sno='" + sno + '\'' +
				", moduleName='" + moduleName + '\'' +
				", moduleStatus='" + moduleStatus + '\'' +
				", copyStatus='" + copyStatus + '\'' +
				", listType='" + listType + '\'' +
				", police='" + police + '\'' +
				", actionName='" + actionName + '\'' +
				'}';
	}
}