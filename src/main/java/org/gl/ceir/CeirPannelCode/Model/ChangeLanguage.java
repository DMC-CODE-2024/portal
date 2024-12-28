package org.gl.ceir.CeirPannelCode.Model;


public class ChangeLanguage {


	private String language;
	private String username;
	private long userTypeId;
	private long userId;
	private long featureId;
	private String userType;	
	
	
	public ChangeLanguage(String language, String username, long userTypeId, long userId, long featureId,
			String userType) {
		super();
		this.language = language;
		this.username = username;

		this.userTypeId = userTypeId;
		this.userId = userId;
		this.featureId = featureId;
		this.userType = userType;
	}
	public ChangeLanguage() {
		super();
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public long getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(long userTypeId) {
		this.userTypeId = userTypeId;
	}
	public long getFeatureId() {
		return featureId;
	}
	public void setFeatureId(long featureId) {
		this.featureId = featureId;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ChangeLanguage [language=");
		builder.append(language);
		builder.append(", username=");
		builder.append(username);
		builder.append(", userTypeId=");
		builder.append(userTypeId);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", featureId=");
		builder.append(featureId);
		builder.append(", userType=");
		builder.append(userType);
		builder.append("]");
		return builder.toString();
	}
	
	
	
}
