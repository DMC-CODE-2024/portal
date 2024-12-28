package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class TrackLostDevicePaginitionModel {
	private List<TrackLostDeviceContentModel> content;
	//private Pageable pageable;
	private Boolean last;
	private Integer totalPages;
	private Integer totalElements;
	private Integer number;
	//private Sort sort;
	private Integer size;
	private Boolean first;
	private Integer numberOfElements;
	private Boolean empty;
	public List<TrackLostDeviceContentModel> getContent() {
		return content;
	}
	public void setContent(List<TrackLostDeviceContentModel> content) {
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
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
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
	public Boolean getEmpty() {
		return empty;
	}
	public void setEmpty(Boolean empty) {
		this.empty = empty;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TrackLostDevicePaginitionModel [content=");
		builder.append(content);

		builder.append(", last=");
		builder.append(last);
		builder.append(", totalPages=");
		builder.append(totalPages);
		builder.append(", totalElements=");
		builder.append(totalElements);
		builder.append(", number=");
		builder.append(number);

		builder.append(", size=");
		builder.append(size);
		builder.append(", first=");
		builder.append(first);
		builder.append(", numberOfElements=");
		builder.append(numberOfElements);
		builder.append(", empty=");
		builder.append(empty);
		builder.append("]");
		return builder.toString();
	}
	
	
}
