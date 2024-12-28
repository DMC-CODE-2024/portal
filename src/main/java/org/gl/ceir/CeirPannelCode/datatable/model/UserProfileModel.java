package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
@Component
public class UserProfileModel {
	private Integer id;
	private String firstName;
	private String middleName;
	private String lastName;
	private String companyName;
	private String type;
	private Integer vatStatus;
	private String vatNo;
	private String propertyLocation;
	private String street;
	private String locality;
	private String province;
	private String country;
	private String passportNo;
	private String email;
	private String phoneNo;
	private String createdOn;
	private String modifiedOn;
	private String phoneOtp;
	private String emailOtp;
	private String displayName;
	private Object employeeId;
	private Object natureOfEmployment;
	private Object designation;
	private Object authorityName;
	private Object authorityEmail;
	private Object authorityPhoneNo;
	private Object operatorTypeName;
	private Object operatorTypeId;
	private Object nidFilename;
	private Object photoFilename;
	private Object idCardFilename;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getVatStatus() {
		return vatStatus;
	}
	public void setVatStatus(Integer vatStatus) {
		this.vatStatus = vatStatus;
	}
	public String getVatNo() {
		return vatNo;
	}
	public void setVatNo(String vatNo) {
		this.vatNo = vatNo;
	}
	public String getPropertyLocation() {
		return propertyLocation;
	}
	public void setPropertyLocation(String propertyLocation) {
		this.propertyLocation = propertyLocation;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getLocality() {
		return locality;
	}
	public void setLocality(String locality) {
		this.locality = locality;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPassportNo() {
		return passportNo;
	}
	public void setPassportNo(String passportNo) {
		this.passportNo = passportNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
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
	public String getPhoneOtp() {
		return phoneOtp;
	}
	public void setPhoneOtp(String phoneOtp) {
		this.phoneOtp = phoneOtp;
	}
	public String getEmailOtp() {
		return emailOtp;
	}
	public void setEmailOtp(String emailOtp) {
		this.emailOtp = emailOtp;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public Object getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Object employeeId) {
		this.employeeId = employeeId;
	}
	public Object getNatureOfEmployment() {
		return natureOfEmployment;
	}
	public void setNatureOfEmployment(Object natureOfEmployment) {
		this.natureOfEmployment = natureOfEmployment;
	}
	public Object getDesignation() {
		return designation;
	}
	public void setDesignation(Object designation) {
		this.designation = designation;
	}
	public Object getAuthorityName() {
		return authorityName;
	}
	public void setAuthorityName(Object authorityName) {
		this.authorityName = authorityName;
	}
	public Object getAuthorityEmail() {
		return authorityEmail;
	}
	public void setAuthorityEmail(Object authorityEmail) {
		this.authorityEmail = authorityEmail;
	}
	public Object getAuthorityPhoneNo() {
		return authorityPhoneNo;
	}
	public void setAuthorityPhoneNo(Object authorityPhoneNo) {
		this.authorityPhoneNo = authorityPhoneNo;
	}
	public Object getOperatorTypeName() {
		return operatorTypeName;
	}
	public void setOperatorTypeName(Object operatorTypeName) {
		this.operatorTypeName = operatorTypeName;
	}
	public Object getOperatorTypeId() {
		return operatorTypeId;
	}
	public void setOperatorTypeId(Object operatorTypeId) {
		this.operatorTypeId = operatorTypeId;
	}
	public Object getNidFilename() {
		return nidFilename;
	}
	public void setNidFilename(Object nidFilename) {
		this.nidFilename = nidFilename;
	}
	public Object getPhotoFilename() {
		return photoFilename;
	}
	public void setPhotoFilename(Object photoFilename) {
		this.photoFilename = photoFilename;
	}
	public Object getIdCardFilename() {
		return idCardFilename;
	}
	public void setIdCardFilename(Object idCardFilename) {
		this.idCardFilename = idCardFilename;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "UserProfileModel [id=" + id + ", firstName=" + firstName + ", middleName=" + middleName + ", lastName="
				+ lastName + ", companyName=" + companyName + ", type=" + type + ", vatStatus=" + vatStatus + ", vatNo="
				+ vatNo + ", propertyLocation=" + propertyLocation + ", street=" + street + ", locality=" + locality
				+ ", province=" + province + ", country=" + country + ", passportNo=" + passportNo + ", email=" + email
				+ ", phoneNo=" + phoneNo + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn + ", phoneOtp="
				+ phoneOtp + ", emailOtp=" + emailOtp + ", displayName=" + displayName + ", employeeId=" + employeeId
				+ ", natureOfEmployment=" + natureOfEmployment + ", designation=" + designation + ", authorityName="
				+ authorityName + ", authorityEmail=" + authorityEmail + ", authorityPhoneNo=" + authorityPhoneNo
				+ ", operatorTypeName=" + operatorTypeName + ", operatorTypeId=" + operatorTypeId + ", nidFilename="
				+ nidFilename + ", photoFilename=" + photoFilename + ", idCardFilename=" + idCardFilename
				+ ", additionalProperties=" + additionalProperties + "]";
	}	
	}
