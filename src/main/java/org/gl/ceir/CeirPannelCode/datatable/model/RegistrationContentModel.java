package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.gl.ceir.CeirPannelCode.Model.QuestionPair;
import org.springframework.stereotype.Component;

@Component
public class RegistrationContentModel {
	
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
	private Object createdOn;
	private Object modifiedOn;
	private String phoneOtp;
	private String emailOtp;
	private Integer status;
	private Object username;
	private List<QuestionPair> questionList ; 
	private long[] roles;
	private Object usertypeId;
	private Object password;
	private String asTypeName;
	private RegistrationUser user;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	private String stateInterp;
	private String displayName;
	
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
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
	public Object getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(Object createdOn) {
		this.createdOn = createdOn;
	}
	public Object getModifiedOn() {
		return modifiedOn;
	}
	public void setModifiedOn(Object modifiedOn) {
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Object getUsername() {
		return username;
	}
	public void setUsername(Object username) {
		this.username = username;
	}
	public List<QuestionPair> getQuestionList() {
		return questionList;
	}
	public void setQuestionList(List<QuestionPair> questionList) {
		this.questionList = questionList;
	}
	public long[] getRoles() {
		return roles;
	}
	public void setRoles(long[] roles) {
		this.roles = roles;
	}
	public Object getUsertypeId() {
		return usertypeId;
	}
	public void setUsertypeId(Object usertypeId) {
		this.usertypeId = usertypeId;
	}
	public Object getPassword() {
		return password;
	}
	public void setPassword(Object password) {
		this.password = password;
	}
	public String getAsTypeName() {
		return asTypeName;
	}
	public void setAsTypeName(String asTypeName) {
		this.asTypeName = asTypeName;
	}
	public RegistrationUser getUser() {
		return user;
	}
	public void setUser(RegistrationUser user) {
		this.user = user;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	public String getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RegistrationContentModel [id=");
		builder.append(id);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", middleName=");
		builder.append(middleName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", companyName=");
		builder.append(companyName);
		builder.append(", type=");
		builder.append(type);
		builder.append(", vatStatus=");
		builder.append(vatStatus);
		builder.append(", vatNo=");
		builder.append(vatNo);
		builder.append(", propertyLocation=");
		builder.append(propertyLocation);
		builder.append(", street=");
		builder.append(street);
		builder.append(", locality=");
		builder.append(locality);
		builder.append(", province=");
		builder.append(province);
		builder.append(", country=");
		builder.append(country);
		builder.append(", passportNo=");
		builder.append(passportNo);
		builder.append(", email=");
		builder.append(email);
		builder.append(", phoneNo=");
		builder.append(phoneNo);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", phoneOtp=");
		builder.append(phoneOtp);
		builder.append(", emailOtp=");
		builder.append(emailOtp);
		builder.append(", status=");
		builder.append(status);
		builder.append(", username=");
		builder.append(username);
		builder.append(", questionList=");
		builder.append(questionList);
		builder.append(", roles=");
		builder.append(roles);
		builder.append(", usertypeId=");
		builder.append(usertypeId);
		builder.append(", password=");
		builder.append(password);
		builder.append(", asTypeName=");
		builder.append(asTypeName);
		builder.append(", user=");
		builder.append(user);
		builder.append(", additionalProperties=");
		builder.append(additionalProperties);
		builder.append(", stateInterp=");
		builder.append(stateInterp);
		builder.append(", displayName=");
		builder.append(displayName);
		builder.append("]");
		return builder.toString();
	}
	
	
}
