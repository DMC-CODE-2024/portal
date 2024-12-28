package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
@Component
public class DBrowDataModel {
	private String dbName;
	private String tableName;
	private Integer pageNo, pageSize;
	private List<String> columns;
	private List<Map<String, String>> rowData;
	
	private String endDate,startDate,txnId,username,userType,newTxnID ;
	private Integer reportnameId,userTypeId,userId,featureId,typeFlag;
	private String publicIp,browser;
	
	
	
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
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
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
	public List<String> getColumns() {
		return columns;
	}
	public void setColumns(List<String> columns) {
		this.columns = columns;
	}
	public List<Map<String, String>> getRowData() {
		return rowData;
	}
	public void setRowData(List<Map<String, String>> rowData) {
		this.rowData = rowData;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public Integer getReportnameId() {
		return reportnameId;
	}
	public void setReportnameId(Integer reportnameId) {
		this.reportnameId = reportnameId;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public Integer getTypeFlag() {
		return typeFlag;
	}
	public void setTypeFlag(Integer typeFlag) {
		this.typeFlag = typeFlag;
	}
	public String getNewTxnID() {
		return newTxnID;
	}
	public void setNewTxnID(String newTxnID) {
		this.newTxnID = newTxnID;
	}
	@Override
	public String toString() {
		return "DBrowDataModel [dbName=" + dbName + ", tableName=" + tableName + ", pageNo=" + pageNo + ", pageSize="
				+ pageSize + ", columns=" + columns + ", rowData=" + rowData + ", endDate=" + endDate + ", startDate="
				+ startDate + ", txnId=" + txnId + ", username=" + username + ", userType=" + userType + ", newTxnID="
				+ newTxnID + ", reportnameId=" + reportnameId + ", userTypeId=" + userTypeId + ", userId=" + userId
				+ ", featureId=" + featureId + ", typeFlag=" + typeFlag + ", publicIp=" + publicIp + ", browser="
				+ browser + "]";
	}
 

	
	
}
