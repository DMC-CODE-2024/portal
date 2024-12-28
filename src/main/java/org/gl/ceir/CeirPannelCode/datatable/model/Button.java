package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class Button {
	private String type = null;
	private String buttonTitle = null;
	private String buttonURL = null;
	private String id =null;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getButtonTitle() {
		return buttonTitle;
	}
	public void setButtonTitle(String buttonTitle) {
		this.buttonTitle = buttonTitle;
	}
	public String getButtonURL() {
		return buttonURL;
	}
	public void setButtonURL(String buttonURL) {
		this.buttonURL = buttonURL;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "Button [type=" + type + ", buttonTitle=" + buttonTitle + ", buttonURL=" + buttonURL + ", id=" + id
				+ "]";
	}
	
}
