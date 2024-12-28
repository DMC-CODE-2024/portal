package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;
import java.util.Map;

public class MapDatatableResponse {
	private List<DbListDataHeaders> columns;
	private List<Map<String, String>> data;
	public List<DbListDataHeaders> getColumns() {
		return columns;
	}
	public void setColumns(List<DbListDataHeaders> columns) {
		this.columns = columns;
	}
	public List<Map<String, String>> getData() {
		return data;
	}
	public void setData(List<Map<String, String>> data) {
		this.data = data;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MapDatatableResponse [columns=");
		builder.append(columns);
		builder.append(", data=");
		builder.append(data);
		builder.append("]");
		return builder.toString();
	}



}

