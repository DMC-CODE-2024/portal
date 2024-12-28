package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class NotificationSort {

	private Boolean sorted;
	private Boolean unsorted;
	private Boolean empty;
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
	public Boolean getEmpty() {
		return empty;
	}
	public void setEmpty(Boolean empty) {
		this.empty = empty;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "NotificationSort [sorted=" + sorted + ", unsorted=" + unsorted + ", empty=" + empty
				+ ", additionalProperties=" + additionalProperties + "]";
	}
		
}
