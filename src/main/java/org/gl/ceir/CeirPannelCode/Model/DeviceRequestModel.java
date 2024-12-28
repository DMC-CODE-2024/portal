package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;

public class DeviceRequestModel {

	private List<DeviceManagementRequest> content;

	public List<DeviceManagementRequest> getContent() {
		return content;
	}

	public void setContent(List<DeviceManagementRequest> content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "DeviceRequestModel [content=" + content + "]";
	}
	
	
}
