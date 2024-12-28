package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class CCNotificationPagination {

	private List<CCNotificationContent> content = null;
	//private Pageable pageable;
	private Integer totalPages;
	private Integer totalElements;
	private Boolean last;
	private Boolean first;
	//private Sort sort;
	private Integer numberOfElements;
	private Integer size;
	private Integer number;
	private Boolean empty;
	public List<CCNotificationContent> getContent() {
		return content;
	}
	public void setContent(List<CCNotificationContent> content) {
		this.content = content;
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
	@Override
	public String toString() {
		return "CCNotificationPagination [content=" + content + ", totalPages=" + totalPages
				+ ", totalElements=" + totalElements + ", last=" + last + ", first=" + first
				+ ", numberOfElements=" + numberOfElements + ", size=" + size + ", number=" + number + ", empty="
				+ empty + "]";
	}
	
	
}
