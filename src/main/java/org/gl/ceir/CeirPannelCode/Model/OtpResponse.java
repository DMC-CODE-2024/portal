package org.gl.ceir.CeirPannelCode.Model;

import org.gl.ceir.CeirPannelCode.Util.HttpResponse;

public class OtpResponse {  
	private String response;
	private Integer statusCode;
	private Integer userId;
	private String tag;
	

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getResponse() {
		return response;
	}

	public void setResponse(String response) {
		this.response = response;
	}

	public Integer getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(Integer statusCode) {
		this.statusCode = statusCode;
	}

	
	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	@Override
	public String toString() {
		return "OtpResponse [response=" + response + ", statusCode=" + statusCode + ", userId=" + userId + "]";
	}


}

    

