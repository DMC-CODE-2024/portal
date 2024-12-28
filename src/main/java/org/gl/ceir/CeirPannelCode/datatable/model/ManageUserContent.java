package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class ManageUserContent {

	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String nid;
	private String txnId;
	private String firstName;
	private String middleName;
	private String lastName;
	private String propertyLocation;
	private String street;
	private String locality;
	private String district;
	private String commune;
	private String village;
	private Integer postalCode;
	private String province;
	private String country;
	private String email;
	private String phoneNo;
	private Integer docType;
	private Object docTypeInterp;
	private List<Object> regularizeDeviceDbs = null;
	private String nationality;
	private String onVisa;
	private List<Object> visaDb = null;
	private String isVip;
	private Object userDepartment;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
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
	public Integer getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(Integer postalCode) {
		this.postalCode = postalCode;
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
	public Integer getDocType() {
		return docType;
	}
	public void setDocType(Integer docType) {
		this.docType = docType;
	}
	public Object getDocTypeInterp() {
		return docTypeInterp;
	}
	public void setDocTypeInterp(Object docTypeInterp) {
		this.docTypeInterp = docTypeInterp;
	}
	public List<Object> getRegularizeDeviceDbs() {
		return regularizeDeviceDbs;
	}
	public void setRegularizeDeviceDbs(List<Object> regularizeDeviceDbs) {
		this.regularizeDeviceDbs = regularizeDeviceDbs;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getOnVisa() {
		return onVisa;
	}
	public void setOnVisa(String onVisa) {
		this.onVisa = onVisa;
	}
	public List<Object> getVisaDb() {
		return visaDb;
	}
	public void setVisaDb(List<Object> visaDb) {
		this.visaDb = visaDb;
	}
	public String getIsVip() {
		return isVip;
	}
	public void setIsVip(String isVip) {
		this.isVip = isVip;
	}
	public Object getUserDepartment() {
		return userDepartment;
	}
	public void setUserDepartment(Object userDepartment) {
		this.userDepartment = userDepartment;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "ManageUserContent [id=" + id + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn + ", nid="
				+ nid + ", txnId=" + txnId + ", firstName=" + firstName + ", middleName=" + middleName + ", lastName="
				+ lastName + ", propertyLocation=" + propertyLocation + ", street=" + street + ", locality=" + locality
				+ ", district=" + district + ", commune=" + commune + ", village=" + village + ", postalCode="
				+ postalCode + ", province=" + province + ", country=" + country + ", email=" + email + ", phoneNo="
				+ phoneNo + ", docType=" + docType + ", docTypeInterp=" + docTypeInterp + ", regularizeDeviceDbs="
				+ regularizeDeviceDbs + ", nationality=" + nationality + ", onVisa=" + onVisa + ", visaDb=" + visaDb
				+ ", isVip=" + isVip + ", userDepartment=" + userDepartment + ", additionalProperties="
				+ additionalProperties + "]";
	}
	
	
	
	
	
	
}
