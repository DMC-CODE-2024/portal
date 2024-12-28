package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class ConfigContentModel {
	private Integer id;
	private String createdOn;
	private String creationDate;
	private String modifiedOn;
	private String tag,tac;
	private String value;
	private String description;
	private Integer type;
	public String publicIp;
	private String browser;
	private String typeInterp,roleType,userType,userName,modifiedBy;
	private String featureName;
	private String remarks;
	private String label,englishName,khmerName;
	private String imei,imsi,msisdn,sno,copyStatus,listType,fileName,filePath,operatorName,recordCount,fileCopyInterp,fileTypeInterp;
	private String remark;
	private String language;

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getTypeInterp() {
		return typeInterp;
	}
	public void setTypeInterp(String typeInterp) {
		this.typeInterp = typeInterp;
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	
	public String getTac() {
		return tac;
	}
	public void setTac(String tac) {
		this.tac = tac;
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
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	public String getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(String recordCount) {
		this.recordCount = recordCount;
	}
	public String getFileCopyInterp() {
		return fileCopyInterp;
	}
	public void setFileCopyInterp(String fileCopyInterp) {
		this.fileCopyInterp = fileCopyInterp;
	}
	public String getFileTypeInterp() {
		return fileTypeInterp;
	}
	public void setFileTypeInterp(String fileTypeInterp) {
		this.fileTypeInterp = fileTypeInterp;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder("ConfigContentModel{");
		sb.append("id=").append(id);
		sb.append(", createdOn='").append(createdOn).append('\'');
		sb.append(", creationDate='").append(creationDate).append('\'');
		sb.append(", modifiedOn='").append(modifiedOn).append('\'');
		sb.append(", tag='").append(tag).append('\'');
		sb.append(", tac='").append(tac).append('\'');
		sb.append(", value='").append(value).append('\'');
		sb.append(", description='").append(description).append('\'');
		sb.append(", type=").append(type);
		sb.append(", publicIp='").append(publicIp).append('\'');
		sb.append(", browser='").append(browser).append('\'');
		sb.append(", typeInterp='").append(typeInterp).append('\'');
		sb.append(", roleType='").append(roleType).append('\'');
		sb.append(", userType='").append(userType).append('\'');
		sb.append(", userName='").append(userName).append('\'');
		sb.append(", modifiedBy='").append(modifiedBy).append('\'');
		sb.append(", featureName='").append(featureName).append('\'');
		sb.append(", remarks='").append(remarks).append('\'');
		sb.append(", label='").append(label).append('\'');
		sb.append(", englishName='").append(englishName).append('\'');
		sb.append(", khmerName='").append(khmerName).append('\'');
		sb.append(", imei='").append(imei).append('\'');
		sb.append(", imsi='").append(imsi).append('\'');
		sb.append(", msisdn='").append(msisdn).append('\'');
		sb.append(", sno='").append(sno).append('\'');
		sb.append(", copyStatus='").append(copyStatus).append('\'');
		sb.append(", listType='").append(listType).append('\'');
		sb.append(", fileName='").append(fileName).append('\'');
		sb.append(", filePath='").append(filePath).append('\'');
		sb.append(", operatorName='").append(operatorName).append('\'');
		sb.append(", recordCount='").append(recordCount).append('\'');
		sb.append(", fileCopyInterp='").append(fileCopyInterp).append('\'');
		sb.append(", fileTypeInterp='").append(fileTypeInterp).append('\'');
		sb.append(", remark='").append(remark).append('\'');
		sb.append(", language='").append(language).append('\'');
		sb.append('}');
		return sb.toString();
	}
}
