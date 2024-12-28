package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class NotificationPaginationModel {

	private List<NotificationContent> content = null;
	private NotificationPageble pageable;
	private Integer totalPages;
	private Integer totalElements;
	private Boolean last;
	private Boolean first;
	private NotificationSort sort;
	private Integer numberOfElements;
	private Integer size;
	private Integer number;
	private Boolean empty;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public List<NotificationContent> getContent() {
		return content;
	}
	public void setContent(List<NotificationContent> content) {
		this.content = content;
	}
	public NotificationPageble getPageable() {
		return pageable;
	}
	public void setPageable(NotificationPageble pageable) {
		this.pageable = pageable;
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
	public NotificationSort getSort() {
		return sort;
	}
	public void setSort(NotificationSort sort) {
		this.sort = sort;
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
	@Override
	public String toString() {
		return "NotificationPaginationModel [content=" + content + ", pageable=" + pageable + ", totalPages="
				+ totalPages + ", totalElements=" + totalElements + ", last=" + last + ", first=" + first + ", sort="
				+ sort + ", numberOfElements=" + numberOfElements + ", size=" + size + ", number=" + number + ", empty="
				+ empty + ", additionalProperties=" + additionalProperties + "]";
	}
		
}
