package org.gl.ceir.CeirPannelCode.Model;




public class CountryCodeModel {

    private String modifiedOn;
    private String phoneCode;
    private  String countryName;
    private Integer id;
    private String createdOn;

    public String getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public String getPhoneCode() {
        return phoneCode;
    }

    public void setPhoneCode(String phoneCode) {
        this.phoneCode = phoneCode;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
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

    @Override
    public String toString() {
        return "CountryCodeModel{" +
                "modifiedOn='" + modifiedOn + '\'' +
                ", phoneCode='" + phoneCode + '\'' +
                ", countryName='" + countryName + '\'' +
                ", id=" + id +
                ", createdOn='" + createdOn + '\'' +
                '}';
    }
}
