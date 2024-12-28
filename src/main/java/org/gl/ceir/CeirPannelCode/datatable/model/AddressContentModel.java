package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class AddressContentModel {

	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String country;
	private String province;
	private String district;
	private String commune;
	private String village;
	private String updatingProvinceName; //New Province which is going to update
	private String currentDistrictName; //New District which is going to update
	private String currentCommuneName; //New Commune which is going to update
	private String districtID;
	private String districtName;
	private String communeID;
	private String currentVillage;
	private Integer userId;
	private Integer featureId;
	private Integer userTypeId;
	private String userType;
	private String username;
	private String modifiedBy;
	private String publicIp;
	private String browser;
	
	
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
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public String getModifiedOn() {
		return modifiedOn;
	}
	public void setModifiedOn(String modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getCommune() {
		return commune;
	}
	public void setCommune(String commune) {
		this.commune = commune;
	}
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	public String getUpdatingProvinceName() {
		return updatingProvinceName;
	}
	public void setUpdatingProvinceName(String updatingProvinceName) {
		this.updatingProvinceName = updatingProvinceName;
	}
	public String getCurrentDistrictName() {
		return currentDistrictName;
	}
	public void setCurrentDistrictName(String currentDistrictName) {
		this.currentDistrictName = currentDistrictName;
	}
	public String getCurrentCommuneName() {
		return currentCommuneName;
	}
	public void setCurrentCommuneName(String currentCommuneName) {
		this.currentCommuneName = currentCommuneName;
	}
	public String getDistrictID() {
		return districtID;
	}
	public void setDistrictID(String districtID) {
		this.districtID = districtID;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getCommuneID() {
		return communeID;
	}
	public void setCommuneID(String communeID) {
		this.communeID = communeID;
	}
	public String getCurrentVillage() {
		return currentVillage;
	}
	public void setCurrentVillage(String currentVillage) {
		this.currentVillage = currentVillage;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AddressContentModel [id=");
		builder.append(id);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", country=");
		builder.append(country);
		builder.append(", province=");
		builder.append(province);
		builder.append(", district=");
		builder.append(district);
		builder.append(", commune=");
		builder.append(commune);
		builder.append(", village=");
		builder.append(village);
		builder.append(", updatingProvinceName=");
		builder.append(updatingProvinceName);
		builder.append(", currentDistrictName=");
		builder.append(currentDistrictName);
		builder.append(", currentCommuneName=");
		builder.append(currentCommuneName);
		builder.append(", districtID=");
		builder.append(districtID);
		builder.append(", districtName=");
		builder.append(districtName);
		builder.append(", communeID=");
		builder.append(communeID);
		builder.append(", currentVillage=");
		builder.append(currentVillage);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", featureId=");
		builder.append(featureId);
		builder.append(", userTypeId=");
		builder.append(userTypeId);
		builder.append(", userType=");
		builder.append(userType);
		builder.append(", username=");
		builder.append(username);
		builder.append(", modifiedBy=");
		builder.append(modifiedBy);
		builder.append(", publicIp=");
		builder.append(publicIp);
		builder.append(", browser=");
		builder.append(browser);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
}
