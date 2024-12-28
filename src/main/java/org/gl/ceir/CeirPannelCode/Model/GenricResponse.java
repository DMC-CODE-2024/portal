package org.gl.ceir.CeirPannelCode.Model;

public class GenricResponse {

	private String errorCode;
	private String txnId;
	private String  message;
	private String response,statusCode,user;
	private Object data ;
	private String tag,status;
	private String requestID;
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRequestID() {
		return requestID;
	}
	public void setRequestID(String requestID) {
		this.requestID = requestID;
	}
	@Override
	public String toString() {
		return "GenricResponse [errorCode=" + errorCode + ", txnId=" + txnId + ", message=" + message + ", response="
				+ response + ", statusCode=" + statusCode + ", user=" + user + ", data=" + data + ", tag=" + tag
				+ ", status=" + status + ", requestID=" + requestID + "]";
	}
	
	
	}
