package org.gl.ceir.CeirPannelCode.datatable.model;

public class InputFields {
	private String type;
	private String title;
	private String id;
	private String className;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	@Override
	public String toString() {
		return "InputFields [type=" + type + ", title=" + title + ", id=" + id + ", className=" + className + "]";
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
}
