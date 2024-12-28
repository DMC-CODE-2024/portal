package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

import java.util.Date;
@Component
public class EirsResponseParamContentModel {
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
    private String status;
    private String publicIp;
    private String browser;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getActive() {
        return active;
    }

    public void setActive(Integer active) {
        this.active = active;
    }

    public String getFeatureName() {
        return featureName;
    }

    public void setFeatureName(String featureName) {
        this.featureName = featureName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

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

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("EirsResponseParamContentModel [id=");
        builder.append(id);
        builder.append(", createdOn=");
        builder.append(createdOn);
        builder.append(", description=");
        builder.append(description);
        builder.append(", modifiedOn=");
        builder.append(modifiedOn);
        builder.append(", tag=");
        builder.append(tag);
        builder.append(", type=");
        builder.append(type);
        builder.append(", value=");
        builder.append(value);
        builder.append(", active=");
        builder.append(active);
        builder.append(", featureName=");
        builder.append(featureName);
        builder.append(", remarks=");
        builder.append(remarks);
        builder.append(", userType=");
        builder.append(userType);
        builder.append(", modifiedBy=");
        builder.append(modifiedBy);
        builder.append(", language=");
        builder.append(language);
        builder.append(", status=");
        builder.append(status);
        builder.append(", publicIp=");
        builder.append(publicIp);
        builder.append(", browser=");
        builder.append(browser);
        builder.append("]");
        return builder.toString();
    }
}