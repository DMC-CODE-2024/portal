package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.List;

import org.springframework.stereotype.Component;
@Component
public class DatatableModel {
	private Integer recordsTotal;
	//Integer recordsTotal = new Integer(10)     int recordsTotal;  int x= recordsTotal.intValue();
	private Integer recordsFiltered;
	private List<List<String>> data = null;
	@Override
	public String toString() {
		return "DatatableModel [recordsTotal=" + recordsTotal + ", recordsFiltered=" + recordsFiltered + "]";
	}
	public Integer getRecordsTotal() {
		return recordsTotal;
	}
	public void setRecordsTotal(Integer recordsTotal) {
		this.recordsTotal = recordsTotal;
	}
	public Integer getRecordsFiltered() {
		return recordsFiltered;
	}
	public void setRecordsFiltered(Integer recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}
	public List<List<String>> getData() {
		return data;
	}
	public void setData(List<List<String>> data) {
		this.data = data;
	}
}
