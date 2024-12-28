package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class StolenImeiStatusContentModel {

    private Integer id;
    private String createdOn;
    private String modifiedOn;
    private String imei1;
    private String imei2;
    private String imei3;
    private String imei4;
    private String status;
    private String remark;
    private String createdBy;
    private String transactionId;
    private String requestMode;
    private String fileName;
    private Integer fileRecordCount;
    private Integer countFoundInLost;

    public String getRequestMode() {
        return requestMode;
    }

    public void setRequestMode(String requestMode) {
        this.requestMode = requestMode;
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

    public String getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public String getImei1() {
        return imei1;
    }

    public void setImei1(String imei1) {
        this.imei1 = imei1;
    }

    public String getImei2() {
        return imei2;
    }

    public void setImei2(String imei2) {
        this.imei2 = imei2;
    }

    public String getImei3() {
        return imei3;
    }

    public void setImei3(String imei3) {
        this.imei3 = imei3;
    }

    public String getImei4() {
        return imei4;
    }

    public void setImei4(String imei4) {
        this.imei4 = imei4;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getFileRecordCount() {
        return fileRecordCount;
    }

    public void setFileRecordCount(Integer fileRecordCount) {
        this.fileRecordCount = fileRecordCount;
    }

    public Integer getCountFoundInLost() {
        return countFoundInLost;
    }

    public void setCountFoundInLost(Integer countFoundInLost) {
        this.countFoundInLost = countFoundInLost;
    }

    @Override
    public String toString() {
        return "StolenImeiStatusContentModel{" +
                "id=" + id +
                ", createdOn='" + createdOn + '\'' +
                ", modifiedOn='" + modifiedOn + '\'' +
                ", imei1='" + imei1 + '\'' +
                ", imei2='" + imei2 + '\'' +
                ", imei3='" + imei3 + '\'' +
                ", imei4='" + imei4 + '\'' +
                ", status='" + status + '\'' +
                ", remark='" + remark + '\'' +
                ", createdBy='" + createdBy + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", requestMode='" + requestMode + '\'' +
                ", fileName='" + fileName + '\'' +
                ", fileRecordCount=" + fileRecordCount +
                ", countFoundInLost=" + countFoundInLost +
                '}';
    }
}
