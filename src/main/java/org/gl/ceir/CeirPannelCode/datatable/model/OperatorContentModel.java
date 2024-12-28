package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class OperatorContentModel {
	private Integer id;
	private String createdOn;
	private Object dumpType;
	private String dumpTypeInterp;
	private String fileTypeInterp;
	private Integer serviceDump;
	private String fileName;
	private Integer fileType;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public Object getDumpType() {
		return dumpType;
	}
	public void setDumpType(Object dumpType) {
		this.dumpType = dumpType;
	}
	public String getDumpTypeInterp() {
		return dumpTypeInterp;
	}
	public void setDumpTypeInterp(String dumpTypeInterp) {
		this.dumpTypeInterp = dumpTypeInterp;
	}
	public String getFileTypeInterp() {
		return fileTypeInterp;
	}
	public void setFileTypeInterp(String fileTypeInterp) {
		this.fileTypeInterp = fileTypeInterp;
	}
	public Integer getServiceDump() {
		return serviceDump;
	}
	public void setServiceDump(Integer serviceDump) {
		this.serviceDump = serviceDump;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getFileType() {
		return fileType;
	}
	public void setFileType(Integer fileType) {
		this.fileType = fileType;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "OperatorContentModel [id=" + id + ", createdOn=" + createdOn + ", dumpType=" + dumpType
				+ ", dumpTypeInterp=" + dumpTypeInterp + ", fileTypeInterp=" + fileTypeInterp + ", serviceDump="
				+ serviceDump + ", fileName=" + fileName + ", fileType=" + fileType + ", additionalProperties="
				+ additionalProperties + "]";
	}
	
	
}
