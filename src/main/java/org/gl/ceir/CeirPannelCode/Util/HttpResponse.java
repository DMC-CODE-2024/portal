package org.gl.ceir.CeirPannelCode.Util;

import org.gl.ceir.CeirPannelCode.Model.User;

public class HttpResponse {   
private String response;
private Integer statusCode;
private Object data;
private String tag;
private User user;

public User getUser() {
	return user;
}
public void setUser(User user) {
	this.user = user;
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
public Object getData() {
	return data;
}
public void setData(Object data) {
	this.data = data;
}
public String getTag() {
	return tag;
}
public void setTag(String tag) {
	this.tag = tag;
}
@Override
public String toString() {
	StringBuilder builder = new StringBuilder();
	builder.append("HttpResponse [response=");
	builder.append(response);
	builder.append(", statusCode=");
	builder.append(statusCode);
	builder.append(", data=");
	builder.append(data);
	builder.append(", tag=");
	builder.append(tag);
	builder.append(", user=");
	builder.append(user);
	builder.append("]");
	return builder.toString();
}
public HttpResponse(String response, Integer statusCode, String tag) {
	super();
	this.response = response;
	this.statusCode = statusCode;
	this.tag = tag;
}
public HttpResponse() {
	super();
}


}
