package org.gl.ceir.CeirPannelCode.features.trc.model;

import org.springframework.stereotype.Component;

@Component
public class MDR {
    private Integer id;
private String remark;
private String action;
    private String modelName;
    private String manufacturer;
    private String manufacturingLocation;
    private String os;
    private String launchDate;
    private String deviceType;
    private Integer simSlot;
    private String tac;
    private String trcApprovedStatus;
    private String approvedBy;
    private String deviceId;

    private AuditTrailModel auditTrailModel;

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getTrcApprovedStatus() {
        return trcApprovedStatus;
    }

    public void setTrcApprovedStatus(String trcApprovedStatus) {
        this.trcApprovedStatus = trcApprovedStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getManufacturingLocation() {
        return manufacturingLocation;
    }

    public void setManufacturingLocation(String manufacturingLocation) {
        this.manufacturingLocation = manufacturingLocation;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getLaunchDate() {
        return launchDate;
    }

    public void setLaunchDate(String launchDate) {
        this.launchDate = launchDate;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public Integer getSimSlot() {
        return simSlot;
    }

    public void setSimSlot(Integer simSlot) {
        this.simSlot = simSlot;
    }

    public String getTac() {
        return tac;
    }

    public void setTac(String tac) {
        this.tac = tac;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public void setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("MDR{");
        sb.append("id=").append(id);
        sb.append(", remark='").append(remark).append('\'');
        sb.append(", action='").append(action).append('\'');
        sb.append(", modelName='").append(modelName).append('\'');
        sb.append(", manufacturer='").append(manufacturer).append('\'');
        sb.append(", manufacturingLocation='").append(manufacturingLocation).append('\'');
        sb.append(", os='").append(os).append('\'');
        sb.append(", launchDate='").append(launchDate).append('\'');
        sb.append(", deviceType='").append(deviceType).append('\'');
        sb.append(", simSlot=").append(simSlot);
        sb.append(", tac='").append(tac).append('\'');
        sb.append(", trcApprovedStatus='").append(trcApprovedStatus).append('\'');
        sb.append(", approvedBy='").append(approvedBy).append('\'');
        sb.append(", deviceId='").append(deviceId).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append('}');
        return sb.toString();
    }
}

