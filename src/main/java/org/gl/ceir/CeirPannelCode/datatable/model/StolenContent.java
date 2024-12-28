package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
@Component
public class StolenContent {
	private Integer id;
	private Integer userId;
	private String fileName;
	private Integer fileStatus;
	private String txnId;
	private String createdOn;
	private String modifiedOn;
	private String requestType;
	private String source;
	private String roleType;
	private String blockingType;
	private String blockingTimePeriod;
	private String sourceType;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	private String stateInterp;
	private String taxInterp;
	private String requestTypeInterp;
	private String sourceTypeInterp;
	private String operatorTypeIdInterp;
	private Integer qty,deviceQuantity;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getFileStatus() {
		return fileStatus;
	}
	public void setFileStatus(Integer fileStatus) {
		this.fileStatus = fileStatus;
	}
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
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
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public String getBlockingType() {
		return blockingType;
	}
	public void setBlockingType(String blockingType) {
		this.blockingType = blockingType;
	}
	public String getBlockingTimePeriod() {
		return blockingTimePeriod;
	}
	public void setBlockingTimePeriod(String blockingTimePeriod) {
		this.blockingTimePeriod = blockingTimePeriod;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	public String getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}
	public String getTaxInterp() {
		return taxInterp;
	}
	public void setTaxInterp(String taxInterp) {
		this.taxInterp = taxInterp;
	}
	public String getRequestTypeInterp() {
		return requestTypeInterp;
	}
	public void setRequestTypeInterp(String requestTypeInterp) {
		this.requestTypeInterp = requestTypeInterp;
	}
	public String getSourceTypeInterp() {
		return sourceTypeInterp;
	}
	public void setSourceTypeInterp(String sourceTypeInterp) {
		this.sourceTypeInterp = sourceTypeInterp;
	}
	public String getOperatorTypeIdInterp() {
		return operatorTypeIdInterp;
	}
	public void setOperatorTypeIdInterp(String operatorTypeIdInterp) {
		this.operatorTypeIdInterp = operatorTypeIdInterp;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public Integer getDeviceQuantity() {
		return deviceQuantity;
	}
	public void setDeviceQuantity(Integer deviceQuantity) {
		this.deviceQuantity = deviceQuantity;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("StolenContent [id=");
		builder.append(id);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", fileName=");
		builder.append(fileName);
		builder.append(", fileStatus=");
		builder.append(fileStatus);
		builder.append(", txnId=");
		builder.append(txnId);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", requestType=");
		builder.append(requestType);
		builder.append(", source=");
		builder.append(source);
		builder.append(", roleType=");
		builder.append(roleType);
		builder.append(", blockingType=");
		builder.append(blockingType);
		builder.append(", blockingTimePeriod=");
		builder.append(blockingTimePeriod);
		builder.append(", sourceType=");
		builder.append(sourceType);
		builder.append(", additionalProperties=");
		builder.append(additionalProperties);
		builder.append(", stateInterp=");
		builder.append(stateInterp);
		builder.append(", taxInterp=");
		builder.append(taxInterp);
		builder.append(", requestTypeInterp=");
		builder.append(requestTypeInterp);
		builder.append(", sourceTypeInterp=");
		builder.append(sourceTypeInterp);
		builder.append(", operatorTypeIdInterp=");
		builder.append(operatorTypeIdInterp);
		builder.append(", qty=");
		builder.append(qty);
		builder.append(", deviceQuantity=");
		builder.append(deviceQuantity);
		builder.append("]");
		return builder.toString();
	}

	
	
}
