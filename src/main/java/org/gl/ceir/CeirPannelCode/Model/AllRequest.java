package org.gl.ceir.CeirPannelCode.Model;

public class AllRequest {

	private String username,userType,imei,nid,txnId;
    private long userId,featureId,userTypeId;
	private String publicIp;
	private String browser;
	private String type;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getFeatureId() {
		return featureId;
	}
	public void setFeatureId(long featureId) {
		this.featureId = featureId;
	}
	public long getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(long userTypeId) {
		this.userTypeId = userTypeId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder("AllRequest{");
		sb.append("username='").append(username).append('\'');
		sb.append(", userType='").append(userType).append('\'');
		sb.append(", imei='").append(imei).append('\'');
		sb.append(", nid='").append(nid).append('\'');
		sb.append(", txnId='").append(txnId).append('\'');
		sb.append(", userId=").append(userId);
		sb.append(", featureId=").append(featureId);
		sb.append(", userTypeId=").append(userTypeId);
		sb.append(", publicIp='").append(publicIp).append('\'');
		sb.append(", browser='").append(browser).append('\'');
		sb.append(", type='").append(type).append('\'');
		sb.append('}');
		return sb.toString();
	}

	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}
	public String getPublicIp() {
		return publicIp;
	}
	public void setPublicIp(String publicIp) {
		this.publicIp = publicIp;
	}
	public String getBrowser() {
		return browser;
	}
	public void setBrowser(String browser) {
		this.browser = browser;
	}


}
