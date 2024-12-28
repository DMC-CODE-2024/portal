package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class TrcSortModel {

	private Boolean sorted;
	private Boolean unsorted;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Boolean getSorted() {
		return sorted;
	}
	public void setSorted(Boolean sorted) {
		this.sorted = sorted;
	}
	public Boolean getUnsorted() {
		return unsorted;
	}
	public void setUnsorted(Boolean unsorted) {
		this.unsorted = unsorted;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "TrcSortModel [sorted=" + sorted + ", unsorted=" + unsorted + ", additionalProperties="
				+ additionalProperties + "]";
	}
	
	
	
}
