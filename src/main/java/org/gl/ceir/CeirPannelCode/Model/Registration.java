package org.gl.ceir.CeirPannelCode.Model;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.gl.ceir.CeirPannelCode.datatable.model.RegistrationUser;

public class Registration extends UserHeader{
	private long id;
	private String firstName;
	private String middleName;
	private String lastName;  
	private String passportNo; 
	private String email;
	private String phoneNo;
	private String companyName;
	private String propertyLocation;
	private String street;
	private String village;
	private String locality;
	private String district;
	private String commune;
	private String postalCode;
	private String province;
	private String country; 
	private Integer type;
	private String asTypeName;
	private Integer vatStatus; 
	private String vatNo; 
	private ArrayList<QuestionPair> questionList;
	private String password;
	private String  rePassword;
	private String username;
	private Long[] roles;
	private String captcha;
	private String usertypeName;
	private Integer userTypeId;
	private String employeeId;
	private String natureOfEmployment;
	private String designation;
	private String authorityName;
	private String authorityEmail;
	private String authorityPhoneNo;
	private String operatorTypeName;
    private Integer operatorTypeId;
	private String nidFilename;
	private String photoFilename;
	private String idCardFilename;
	private Integer arrivalPort;
	private String arrivalPortName;
    private String vatFilename;
    private String userLanguage;
    private String nidFilePath;
    private String photoFilePath;
    private String idCardFilePath;
    private String vatFilePath;
    private Integer portAddress;
    private String portAddressName;
    private RegistrationUser user;
    private String natureOfEmploymentInterp;
    private List<RoleList> rolesList = null;
    private Integer userId;
	public long getId() {
		return id;
	}
	public void setId(long id) {
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
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
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
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
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
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getAsTypeName() {
		return asTypeName;
	}
	public void setAsTypeName(String asTypeName) {
		this.asTypeName = asTypeName;
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
	public ArrayList<QuestionPair> getQuestionList() {
		return questionList;
	}
	public void setQuestionList(ArrayList<QuestionPair> questionList) {
		this.questionList = questionList;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRePassword() {
		return rePassword;
	}
	public void setRePassword(String rePassword) {
		this.rePassword = rePassword;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Long[] getRoles() {
		return roles;
	}
	public void setRoles(Long[] roles) {
		this.roles = roles;
	}
	public String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}
	public String getUsertypeName() {
		return usertypeName;
	}
	public void setUsertypeName(String usertypeName) {
		this.usertypeName = usertypeName;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getNatureOfEmployment() {
		return natureOfEmployment;
	}
	public void setNatureOfEmployment(String natureOfEmployment) {
		this.natureOfEmployment = natureOfEmployment;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getAuthorityName() {
		return authorityName;
	}
	public void setAuthorityName(String authorityName) {
		this.authorityName = authorityName;
	}
	public String getAuthorityEmail() {
		return authorityEmail;
	}
	public void setAuthorityEmail(String authorityEmail) {
		this.authorityEmail = authorityEmail;
	}
	public String getAuthorityPhoneNo() {
		return authorityPhoneNo;
	}
	public void setAuthorityPhoneNo(String authorityPhoneNo) {
		this.authorityPhoneNo = authorityPhoneNo;
	}
	public String getOperatorTypeName() {
		return operatorTypeName;
	}
	public void setOperatorTypeName(String operatorTypeName) {
		this.operatorTypeName = operatorTypeName;
	}
	public Integer getOperatorTypeId() {
		return operatorTypeId;
	}
	public void setOperatorTypeId(Integer operatorTypeId) {
		this.operatorTypeId = operatorTypeId;
	}
	public String getNidFilename() {
		return nidFilename;
	}
	public void setNidFilename(String nidFilename) {
		this.nidFilename = nidFilename;
	}
	public String getPhotoFilename() {
		return photoFilename;
	}
	public void setPhotoFilename(String photoFilename) {
		this.photoFilename = photoFilename;
	}
	public String getIdCardFilename() {
		return idCardFilename;
	}
	public void setIdCardFilename(String idCardFilename) {
		this.idCardFilename = idCardFilename;
	}
	public Integer getArrivalPort() {
		return arrivalPort;
	}
	public void setArrivalPort(Integer arrivalPort) {
		this.arrivalPort = arrivalPort;
	}
	public String getArrivalPortName() {
		return arrivalPortName;
	}
	public void setArrivalPortName(String arrivalPortName) {
		this.arrivalPortName = arrivalPortName;
	}
	public String getVatFilename() {
		return vatFilename;
	}
	public void setVatFilename(String vatFilename) {
		this.vatFilename = vatFilename;
	}
	public String getUserLanguage() {
		return userLanguage;
	}
	public void setUserLanguage(String userLanguage) {
		this.userLanguage = userLanguage;
	}
	public String getNidFilePath() {
		return nidFilePath;
	}
	public void setNidFilePath(String nidFilePath) {
		this.nidFilePath = nidFilePath;
	}
	public String getPhotoFilePath() {
		return photoFilePath;
	}
	public void setPhotoFilePath(String photoFilePath) {
		this.photoFilePath = photoFilePath;
	}
	public String getIdCardFilePath() {
		return idCardFilePath;
	}
	public void setIdCardFilePath(String idCardFilePath) {
		this.idCardFilePath = idCardFilePath;
	}
	public String getVatFilePath() {
		return vatFilePath;
	}
	public void setVatFilePath(String vatFilePath) {
		this.vatFilePath = vatFilePath;
	}
	public Integer getPortAddress() {
		return portAddress;
	}
	public void setPortAddress(Integer portAddress) {
		this.portAddress = portAddress;
	}
	public String getPortAddressName() {
		return portAddressName;
	}
	public void setPortAddressName(String portAddressName) {
		this.portAddressName = portAddressName;
	}
	public RegistrationUser getUser() {
		return user;
	}
	public void setUser(RegistrationUser user) {
		this.user = user;
	}
	public String getNatureOfEmploymentInterp() {
		return natureOfEmploymentInterp;
	}
	public void setNatureOfEmploymentInterp(String natureOfEmploymentInterp) {
		this.natureOfEmploymentInterp = natureOfEmploymentInterp;
	}
	public List<RoleList> getRolesList() {
		return rolesList;
	}
	public void setRolesList(List<RoleList> rolesList) {
		this.rolesList = rolesList;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Registration [id=");
		builder.append(id);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", middleName=");
		builder.append(middleName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", passportNo=");
		builder.append(passportNo);
		builder.append(", email=");
		builder.append(email);
		builder.append(", phoneNo=");
		builder.append(phoneNo);
		builder.append(", companyName=");
		builder.append(companyName);
		builder.append(", propertyLocation=");
		builder.append(propertyLocation);
		builder.append(", street=");
		builder.append(street);
		builder.append(", village=");
		builder.append(village);
		builder.append(", locality=");
		builder.append(locality);
		builder.append(", district=");
		builder.append(district);
		builder.append(", commune=");
		builder.append(commune);
		builder.append(", postalCode=");
		builder.append(postalCode);
		builder.append(", province=");
		builder.append(province);
		builder.append(", country=");
		builder.append(country);
		builder.append(", type=");
		builder.append(type);
		builder.append(", asTypeName=");
		builder.append(asTypeName);
		builder.append(", vatStatus=");
		builder.append(vatStatus);
		builder.append(", vatNo=");
		builder.append(vatNo);
		builder.append(", questionList=");
		builder.append(questionList);
		builder.append(", password=");
		builder.append(password);
		builder.append(", rePassword=");
		builder.append(rePassword);
		builder.append(", username=");
		builder.append(username);
		builder.append(", roles=");
		builder.append(Arrays.toString(roles));
		builder.append(", captcha=");
		builder.append(captcha);
		builder.append(", usertypeName=");
		builder.append(usertypeName);
		builder.append(", userTypeId=");
		builder.append(userTypeId);
		builder.append(", employeeId=");
		builder.append(employeeId);
		builder.append(", natureOfEmployment=");
		builder.append(natureOfEmployment);
		builder.append(", designation=");
		builder.append(designation);
		builder.append(", authorityName=");
		builder.append(authorityName);
		builder.append(", authorityEmail=");
		builder.append(authorityEmail);
		builder.append(", authorityPhoneNo=");
		builder.append(authorityPhoneNo);
		builder.append(", operatorTypeName=");
		builder.append(operatorTypeName);
		builder.append(", operatorTypeId=");
		builder.append(operatorTypeId);
		builder.append(", nidFilename=");
		builder.append(nidFilename);
		builder.append(", photoFilename=");
		builder.append(photoFilename);
		builder.append(", idCardFilename=");
		builder.append(idCardFilename);
		builder.append(", arrivalPort=");
		builder.append(arrivalPort);
		builder.append(", arrivalPortName=");
		builder.append(arrivalPortName);
		builder.append(", vatFilename=");
		builder.append(vatFilename);
		builder.append(", userLanguage=");
		builder.append(userLanguage);
		builder.append(", nidFilePath=");
		builder.append(nidFilePath);
		builder.append(", photoFilePath=");
		builder.append(photoFilePath);
		builder.append(", idCardFilePath=");
		builder.append(idCardFilePath);
		builder.append(", vatFilePath=");
		builder.append(vatFilePath);
		builder.append(", portAddress=");
		builder.append(portAddress);
		builder.append(", portAddressName=");
		builder.append(portAddressName);
		builder.append(", user=");
		builder.append(user);
		builder.append(", natureOfEmploymentInterp=");
		builder.append(natureOfEmploymentInterp);
		builder.append(", rolesList=");
		builder.append(rolesList);
		builder.append(", userId=");
		builder.append(userId);
		builder.append("]");
		return builder.toString();
	}
    
    
}