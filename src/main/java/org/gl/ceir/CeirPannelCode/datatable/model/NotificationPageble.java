package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class NotificationPageble {
	
	private NotificationSort sort;
	private Integer pageSize;
	private Integer pageNumber;
	private Integer offset;
	private Boolean unpaged;
	private Boolean paged;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public NotificationSort getSort() {
		return sort;
	}
	public void setSort(NotificationSort sort) {
		this.sort = sort;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}
	public Integer getOffset() {
		return offset;
	}
	public void setOffset(Integer offset) {
		this.offset = offset;
	}
	public Boolean getUnpaged() {
		return unpaged;
	}
	public void setUnpaged(Boolean unpaged) {
		this.unpaged = unpaged;
	}
	public Boolean getPaged() {
		return paged;
	}
	public void setPaged(Boolean paged) {
		this.paged = paged;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "NotificationPageble [sort=" + sort + ", pageSize=" + pageSize + ", pageNumber=" + pageNumber
				+ ", offset=" + offset + ", unpaged=" + unpaged + ", paged=" + paged + ", additionalProperties="
				+ additionalProperties + "]";
	}
	
	
}
