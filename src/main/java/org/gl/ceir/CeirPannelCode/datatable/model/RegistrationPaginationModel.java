package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
@Component
public class RegistrationPaginationModel {
	private List<RegistrationContentModel> content = null;
	//private Pageable pageable;
	private Boolean last;
	private Integer totalPages;
	private Integer totalElements;
	private Boolean first;
	//private Sort sort;
	private Integer numberOfElements;
	private Integer size;
	private Integer number;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	@Override
	public String toString() {
		return "RegistrationPaginationModel [content=" + content + ", last=" + last
				+ ", totalPages=" + totalPages + ", totalElements=" + totalElements + ", first=" + first + ", numberOfElements=" + numberOfElements + ", size=" + size + ", number=" + number
				+ ", additionalProperties=" + additionalProperties + "]";
	}
	public List<RegistrationContentModel> getContent() {
		return content;
	}
	public void setContent(List<RegistrationContentModel> content) {
		this.content = content;
	}

	public Boolean getLast() {
		return last;
	}
	public void setLast(Boolean last) {
		this.last = last;
	}
	public Integer getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(Integer totalPages) {
		this.totalPages = totalPages;
	}
	public Integer getTotalElements() {
		return totalElements;
	}
	public void setTotalElements(Integer totalElements) {
		this.totalElements = totalElements;
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
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}

	
}
