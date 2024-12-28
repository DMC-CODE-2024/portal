package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class DuplicateContentModel {
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String imei;
	private String imsi;
	private String msisdn;
	private String fileName;
	private String edrTime;
	private String operator;
	private String expiryDate;
	private String status;
	private String stateInterp;
	private String remarks;
	private String updatedBy;
	private String transactionId;
	private String documentType1;
	private String documentType2;
	private String documentType3;
	private String documentType4;
	private String documentPath1;
	private String documentPath2;
	private String documentPath3;
	private String documentPath4;
	private Integer reminderStatus;
	private Integer successCount;
	private Integer failCount;
	private String interpretation;
	private Integer userStatus;
	private String redmineTktId;
	private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

	public String getRedmineTktId() {
		return redmineTktId;
	}

	public void setRedmineTktId(String redmineTktId) {
		this.redmineTktId = redmineTktId;
	}

	public Integer getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(Integer userStatus) {
		this.userStatus = userStatus;
	}
	public String getInterpretation() {
		return interpretation;
	}
	public void setInterpretation(String interpretation) {
		this.interpretation = interpretation;
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
	public String getEdrTime() {
		return edrTime;
	}
	public void setEdrTime(String edrTime) {
		this.edrTime = edrTime;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
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
	public String getDocumentPath1() {
		return documentPath1;
	}
	public void setDocumentPath1(String documentPath1) {
		this.documentPath1 = documentPath1;
	}
	public String getDocumentPath2() {
		return documentPath2;
	}
	public void setDocumentPath2(String documentPath2) {
		this.documentPath2 = documentPath2;
	}
	public String getDocumentPath3() {
		return documentPath3;
	}
	public void setDocumentPath3(String documentPath3) {
		this.documentPath3 = documentPath3;
	}
	public String getDocumentPath4() {
		return documentPath4;
	}
	public void setDocumentPath4(String documentPath4) {
		this.documentPath4 = documentPath4;
	}
	public Integer getReminderStatus() {
		return reminderStatus;
	}
	public void setReminderStatus(Integer reminderStatus) {
		this.reminderStatus = reminderStatus;
	}
	public Integer getSuccessCount() {
		return successCount;
	}
	public void setSuccessCount(Integer successCount) {
		this.successCount = successCount;
	}
	public Integer getFailCount() {
		return failCount;
	}
	public void setFailCount(Integer failCount) {
		this.failCount = failCount;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}

	@Override
	public String toString() {
		return "DuplicateContentModel{" +
				"id=" + id +
				", createdOn='" + createdOn + '\'' +
				", modifiedOn='" + modifiedOn + '\'' +
				", imei='" + imei + '\'' +
				", imsi='" + imsi + '\'' +
				", msisdn='" + msisdn + '\'' +
				", fileName='" + fileName + '\'' +
				", edrTime='" + edrTime + '\'' +
				", operator='" + operator + '\'' +
				", expiryDate='" + expiryDate + '\'' +
				", status='" + status + '\'' +
				", stateInterp='" + stateInterp + '\'' +
				", remarks='" + remarks + '\'' +
				", updatedBy='" + updatedBy + '\'' +
				", transactionId='" + transactionId + '\'' +
				", documentType1='" + documentType1 + '\'' +
				", documentType2='" + documentType2 + '\'' +
				", documentType3='" + documentType3 + '\'' +
				", documentType4='" + documentType4 + '\'' +
				", documentPath1='" + documentPath1 + '\'' +
				", documentPath2='" + documentPath2 + '\'' +
				", documentPath3='" + documentPath3 + '\'' +
				", documentPath4='" + documentPath4 + '\'' +
				", reminderStatus=" + reminderStatus +
				", successCount=" + successCount +
				", failCount=" + failCount +
				", interpretation='" + interpretation + '\'' +
				", userStatus=" + userStatus +
				", redmineTktId='" + redmineTktId + '\'' +
				", additionalProperties=" + additionalProperties +
				'}';
	}


}
