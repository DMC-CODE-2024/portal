    package org.gl.ceir.CeirPannelCode.features.eirs_response_param.model;

import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

public class EirsResponseParamModel {
    private Long id;
    private String createdOn;
    private String description;
    private String modifiedOn;
    private String tag;
    private Integer type;
    private String value;
    private Integer active;
    private String featureName;
    private String remarks;
    private String userType;
    private String modifiedBy;
    private String language;
    private AuditTrailModel auditTrailModel;

    public Long getId() {
        return id;
    }

    public EirsResponseParamModel setId(Long id) {
        this.id = id;
        return this;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public EirsResponseParamModel setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public EirsResponseParamModel setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public EirsResponseParamModel setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
        return this;
    }

    public String getTag() {
        return tag;
    }

    public EirsResponseParamModel setTag(String tag) {
        this.tag = tag;
        return this;
    }

    public Integer getType() {
        return type;
    }

    public EirsResponseParamModel setType(Integer type) {
        this.type = type;
        return this;
    }

    public String getValue() {
        return value;
    }

    public EirsResponseParamModel setValue(String value) {
        this.value = value;
        return this;
    }

    public Integer getActive() {
        return active;
    }

    public EirsResponseParamModel setActive(Integer active) {
        this.active = active;
        return this;
    }

    public String getFeatureName() {
        return featureName;
    }

    public EirsResponseParamModel setFeatureName(String featureName) {
        this.featureName = featureName;
        return this;
    }

    public String getRemarks() {
        return remarks;
    }

    public EirsResponseParamModel setRemarks(String remarks) {
        this.remarks = remarks;
        return this;
    }

    public String getUserType() {
        return userType;
    }

    public EirsResponseParamModel setUserType(String userType) {
        this.userType = userType;
        return this;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public EirsResponseParamModel setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
        return this;
    }

    public String getLanguage() {
        return language;
    }

    public EirsResponseParamModel setLanguage(String language) {
        this.language = language;
        return this;
    }


    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public EirsResponseParamModel setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("EirsResponseParamModel{");
        sb.append("id=").append(id);
        sb.append(", createdOn='").append(createdOn).append('\'');
        sb.append(", description='").append(description).append('\'');
        sb.append(", modifiedOn='").append(modifiedOn).append('\'');
        sb.append(", tag='").append(tag).append('\'');
        sb.append(", type=").append(type);
        sb.append(", value='").append(value).append('\'');
        sb.append(", active=").append(active);
        sb.append(", featureName='").append(featureName).append('\'');
        sb.append(", remarks='").append(remarks).append('\'');
        sb.append(", userType='").append(userType).append('\'');
        sb.append(", modifiedBy='").append(modifiedBy).append('\'');
        sb.append(", language='").append(language).append('\'');
        sb.append('}');
        return sb.toString();
    }


}