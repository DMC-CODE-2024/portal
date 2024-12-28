package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class TrackLostDeviceContentModel {
	private Integer id;
	public String startDate;
	public String endDate;
	private String requestNo;
	private String request_id;
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
	private Integer successCount;
	private Integer failCount;
	private String interpretation;
	private String requestType;
	private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();
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
	
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
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
	public String getRequestNo() {
		return requestNo;
	}
	public void setRequestNo(String requestNo) {
		this.requestNo = requestNo;
	}
	
	/**
	 * @return the request_id
	 */
	public String getRequest_id() {
		return request_id;
	}
	/**
	 * @param request_id the request_id to set
	 */
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	
	public String getInterpretation() {
		return interpretation;
	}
	public void setInterpretation(String interpretation) {
		
		this.interpretation = interpretation;
	}
	
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	@Override
	public String toString() {
		return "TrackLostDeviceContentModel [id=" + id + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", requestNo=" + requestNo + ", request_id=" + request_id + ", createdOn=" + createdOn
				+ ", modifiedOn=" + modifiedOn + ", imei=" + imei + ", imsi=" + imsi + ", msisdn=" + msisdn
				+ ", fileName=" + fileName + ", edrTime=" + edrTime + ", operator=" + operator + ", expiryDate="
				+ expiryDate + ", status=" + status + ", stateInterp=" + stateInterp + ", remarks=" + remarks
				+ ", updatedBy=" + updatedBy + ", successCount=" + successCount + ", failCount=" + failCount
				+ ", interpretation=" + interpretation + ", additionalProperties=" + additionalProperties + "]";
	}
	
	
	
	
	

}
