package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PoliceStationDetailsModel {

    private Integer id;
    private String createdOn;
    private String firstName;
    private String lastName;
    private String phoneNo;
    private String commune;
    private String district;
    private String province;
    private String police;
    private PoliceStationDetailModel policeStationDb;
    private ProvinceDetails provinceDb;
    private DistrictDetails districtDb;


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

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getPolice() {
        return police;
    }

    public void setPolice(String police) {
        this.police = police;
    }

    public PoliceStationDetailModel getPoliceStationDb() {
        return policeStationDb;
    }

    public void setPoliceStationDb(PoliceStationDetailModel policeStationDb) {
        this.policeStationDb = policeStationDb;
    }

    public ProvinceDetails getProvinceDb() {
        return provinceDb;
    }

    public void setProvinceDb(ProvinceDetails provinceDb) {
        this.provinceDb = provinceDb;
    }

    public DistrictDetails getDistrictDb() {
        return districtDb;
    }

    public void setDistrictDb(DistrictDetails districtDb) {
        this.districtDb = districtDb;
    }

    @Override
    public String toString() {
        return "PoliceStationDetailsModel{" +
                "id=" + id +
                ", createdOn='" + createdOn + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", commune='" + commune + '\'' +
                ", district='" + district + '\'' +
                ", province='" + province + '\'' +
                ", police='" + police + '\'' +
                ", policeStationDb=" + policeStationDb +
                ", provinceDb=" + provinceDb +
                ", districtDb=" + districtDb +
                '}';
    }
}
