package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;

public class DBTableModel {
	private String dbName;
	private List<String> tableNames;
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	public List<String> getTableNames() {
		return tableNames;
	}
	public void setTableNames(List<String> tableNames) {
		this.tableNames = tableNames;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TableName [dbName=");
		builder.append(dbName);
		builder.append(", tableNames=");
		builder.append(tableNames);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
}
