package org.gl.ceir.CeirPannelCode.features.addressmgmt.model;

import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;
public class AddressMgmtModel {
    private Long id;
    private String createdOn;
    private String modifiedOn;
    private String province;
    private String district;
    private String commune;
    private String provinceKm;
    private String districtKm;
    private String communeKm;
    private String language;
    private long provinceId;

    public String getProvinceKm() {
        return provinceKm;
    }

    public void setProvinceKm(String provinceKm) {
        this.provinceKm = provinceKm;
    }

    public String getDistrictKm() {
        return districtKm;
    }

    public void setDistrictKm(String districtKm) {
        this.districtKm = districtKm;
    }

    public String getCommuneKm() {
        return communeKm;
    }

    public void setCommuneKm(String communeKm) {
        this.communeKm = communeKm;
    }

    private AuditTrailModel auditTrailModel;

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Long getId() {
        return id;
    }

    public long getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(long provinceId) {
        this.provinceId = provinceId;
    }

    public AddressMgmtModel setId(Long id) {
        this.id = id;
        return this;
    }

    public String getProvince() {
        return province;
    }

    public AddressMgmtModel setProvince(String province) {
        this.province = province;
        return this;
    }

    public String getDistrict() {
        return district;
    }

    public AddressMgmtModel setDistrict(String district) {
        this.district = district;
        return this;
    }

    public String getCommune() {
        return commune;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public AddressMgmtModel setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public AddressMgmtModel setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
        return this;
    }

    public AddressMgmtModel setCommune(String commune) {
        this.commune = commune;
        return this;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public AddressMgmtModel setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("AddressMgmtModel{");
        sb.append("id=").append(id);
        sb.append(", createdOn='").append(createdOn).append('\'');
        sb.append(", modifiedOn='").append(modifiedOn).append('\'');
        sb.append(", province='").append(province).append('\'');
        sb.append(", district='").append(district).append('\'');
        sb.append(", commune='").append(commune).append('\'');
        sb.append(", provinceKm='").append(provinceKm).append('\'');
        sb.append(", districtKm='").append(districtKm).append('\'');
        sb.append(", communeKm='").append(communeKm).append('\'');
        sb.append(", language='").append(language).append('\'');
        sb.append(", provinceId='").append(provinceId).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append('}');
        return sb.toString();
    }
}
