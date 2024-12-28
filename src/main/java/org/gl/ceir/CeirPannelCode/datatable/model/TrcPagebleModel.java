package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class TrcPagebleModel {
	
	private TrcSortModel TcSortModel;
	private Integer pageSize;
	private Integer pageNumber;
	private Integer offset;
	private Boolean paged;
	private Boolean unpaged;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public TrcSortModel getTcSortModel() {
		return TcSortModel;
	}
	public void setTcSortModel(TrcSortModel tcSortModel) {
		TcSortModel = tcSortModel;
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
	public Boolean getPaged() {
		return paged;
	}
	public void setPaged(Boolean paged) {
		this.paged = paged;
	}
	public Boolean getUnpaged() {
		return unpaged;
	}
	public void setUnpaged(Boolean unpaged) {
		this.unpaged = unpaged;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "TrcPagebleModel [TcSortModel=" + TcSortModel + ", pageSize=" + pageSize + ", pageNumber=" + pageNumber
				+ ", offset=" + offset + ", paged=" + paged + ", unpaged=" + unpaged + ", additionalProperties="
				+ additionalProperties + "]";
	}
		
	
	
	
}
