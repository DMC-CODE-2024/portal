package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;

import org.springframework.stereotype.Component;
@Component
public class ReportResponse {
	private Integer reportnameId,reportCategory;
	private String reportName;
	private Integer status;
	private Integer reportOrder;
	private Object inputQuery;
	private String outputTable;
	private Object insertQuery;
	private Integer viewflag;
	private String txnIdField;
	private Object keyColumn;
	private String createdOn;
	private String modifiedOn;
	//private List<ReportTrends> reportTrends;
	public Integer getReportnameId() {
		return reportnameId;
	}
	public void setReportnameId(Integer reportnameId) {
		this.reportnameId = reportnameId;
	}
	public Integer getReportCategory() {
		return reportCategory;
	}
	public void setReportCategory(Integer reportCategory) {
		this.reportCategory = reportCategory;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getReportOrder() {
		return reportOrder;
	}
	public void setReportOrder(Integer reportOrder) {
		this.reportOrder = reportOrder;
	}
	public Object getInputQuery() {
		return inputQuery;
	}
	public void setInputQuery(Object inputQuery) {
		this.inputQuery = inputQuery;
	}
	public String getOutputTable() {
		return outputTable;
	}
	public void setOutputTable(String outputTable) {
		this.outputTable = outputTable;
	}
	public Object getInsertQuery() {
		return insertQuery;
	}
	public void setInsertQuery(Object insertQuery) {
		this.insertQuery = insertQuery;
	}
	public Integer getViewflag() {
		return viewflag;
	}
	public void setViewflag(Integer viewflag) {
		this.viewflag = viewflag;
	}
	public String getTxnIdField() {
		return txnIdField;
	}
	public void setTxnIdField(String txnIdField) {
		this.txnIdField = txnIdField;
	}
	public Object getKeyColumn() {
		return keyColumn;
	}
	public void setKeyColumn(Object keyColumn) {
		this.keyColumn = keyColumn;
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


/*	public List<ReportTrends> getReportTrends() {
		return reportTrends;
	}
	public void setReportTrends(List<ReportTrends> reportTrends) {
		this.reportTrends = reportTrends;
	}*/
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ReportResponse [reportnameId=");
		builder.append(reportnameId);
		builder.append(", reportCategory=");
		builder.append(reportCategory);
		builder.append(", reportName=");
		builder.append(reportName);
		builder.append(", status=");
		builder.append(status);
		builder.append(", reportOrder=");
		builder.append(reportOrder);
		builder.append(", inputQuery=");
		builder.append(inputQuery);
		builder.append(", outputTable=");
		builder.append(outputTable);
		builder.append(", insertQuery=");
		builder.append(insertQuery);
		builder.append(", viewflag=");
		builder.append(viewflag);
		builder.append(", txnIdField=");
		builder.append(txnIdField);
		builder.append(", keyColumn=");
		builder.append(keyColumn);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", reportTrends=");
		//builder.append(reportTrends);
		builder.append("]");
		return builder.toString();
	}

	
}
