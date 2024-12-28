package org.gl.ceir.CeirPannelCode.Response;

import java.util.List;

import org.gl.ceir.CeirPannelCode.Model.DeviceStateResponse;

public class SearchIMEIResponse {
	private List<List<DeviceStateResponse>> result;

	public List<List<DeviceStateResponse>> getResult() {
		return result;
	}

	public void setResult(List<List<DeviceStateResponse>> result) {
		this.result = result;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SearchIMEIResponse [result=");
		builder.append(result);
		builder.append("]");
		return builder.toString();
	}

	
	
	
}
