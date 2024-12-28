package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.List;

import org.springframework.stereotype.Component;
@Component
public class PageElement {
	private String pageTitle = null;
	private String userStatus = null;
	private List<Button> buttonList = null;
	private List<InputFields> dropdownList =  null;
	private List<InputFields> inputTypeDateList= null;
	@Override
	public String toString() {
		return "PageElement [pageTitle=" + pageTitle + ", userStatus=" + userStatus + ", buttonList=" + buttonList
				+ ", dropdownList=" + dropdownList + ", inputTypeDateList=" + inputTypeDateList + "]";
	}
	public String getPageTitle() {
		return pageTitle;
	}
	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}
	public String getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}
	public List<Button> getButtonList() {
		return buttonList;
	}
	public void setButtonList(List<Button> buttonList) {
		this.buttonList = buttonList;
	}
	public List<InputFields> getDropdownList() {
		return dropdownList;
	}
	public void setDropdownList(List<InputFields> dropdownList) {
		this.dropdownList = dropdownList;
	}
	public List<InputFields> getInputTypeDateList() {
		return inputTypeDateList;
	}
	public void setInputTypeDateList(List<InputFields> inputTypeDateList) {
		this.inputTypeDateList = inputTypeDateList;
	}

}
