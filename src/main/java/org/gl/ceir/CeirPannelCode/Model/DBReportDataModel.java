package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class DBReportDataModel {
	private List<String> columns;
	private List<Map<String, String>> rowData;
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
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("DBReportDataModel [columns=");
		builder.append(columns);
		builder.append(", rowData=");
		builder.append(rowData);
		builder.append("]");
		return builder.toString();
	}
	
	
	 
}
