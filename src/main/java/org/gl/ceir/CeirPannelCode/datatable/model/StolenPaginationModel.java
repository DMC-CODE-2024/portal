package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.gl.ceir.CeirPannelCode.Model.LostStolenModel;
import org.springframework.stereotype.Component;
@Component
public class StolenPaginationModel {
	private List<StolenContent> content = null;
	//private Pageable pageable;
	private Integer totalPages;
	private Integer totalElements;
	public List<StolenContent> getContent() {
		return content;
	}
	public void setContent(List<StolenContent> content) {
		this.content = content;
	}

	public Integer getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(Integer totalPages) {
		this.totalPages = totalPages;
	}
	@Override
	public String toString() {
		return "StolenPaginationModel [content=" + content + ", totalPages=" + totalPages
				+ ", totalElements=" + totalElements + ", last=" + last + ", first=" + first + ", numberOfElements=" + numberOfElements + ", size=" + size + ", number=" + number + ", empty="
				+ empty + ", additionalProperties=" + additionalProperties + "]";
	}
	public Integer getTotalElements() {
		return totalElements;
	}
	public void setTotalElements(Integer totalElements) {
		this.totalElements = totalElements;
	}
	public Boolean getLast() {
		return last;
	}
	public void setLast(Boolean last) {
		this.last = last;
	}
	public Boolean getFirst() {
		return first;
	}
	public void setFirst(Boolean first) {
		this.first = first;
	}

	public Integer getNumberOfElements() {
		return numberOfElements;
	}
	public void setNumberOfElements(Integer numberOfElements) {
		this.numberOfElements = numberOfElements;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
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
	private Boolean last;
	private Boolean first;
	//private Sort sort;
	private Integer numberOfElements;
	private Integer size;
	private Integer number;
	private Boolean empty;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
}
