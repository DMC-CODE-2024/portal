package org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model;

public class MSISDNSeriesModel {
    private Long id;
    private String createdOn;

    private String modifiedOn;

    private Integer seriesStart;

    private Integer seriesEnd;
    private String seriesType;

    private String operatorName;

    private String remarks;
    private UserResponse user;
    private Long userId;
    private String length;
    private String userName;
    private AuditTraildDTO auditTraildDTO;

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

    public String getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public Integer getSeriesStart() {
        return seriesStart;
    }

    public void setSeriesStart(Integer seriesStart) {
        this.seriesStart = seriesStart;
    }

    public Integer getSeriesEnd() {
        return seriesEnd;
    }

    public void setSeriesEnd(Integer seriesEnd) {
        this.seriesEnd = seriesEnd;
    }

    public String getSeriesType() {
        return seriesType;
    }

    public void setSeriesType(String seriesType) {
        this.seriesType = seriesType;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public UserResponse getUser() {
        return user;
    }

    public void setUser(UserResponse user) {
        this.user = user;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public AuditTraildDTO getAuditTraildDTO() {
        return auditTraildDTO;
    }

    public void setAuditTraildDTO(AuditTraildDTO auditTraildDTO) {
        this.auditTraildDTO = auditTraildDTO;
    }

    @Override
    public String toString() {
        return "MSISDNSeriesModel{" +
                "id=" + id +
                ", createdOn='" + createdOn + '\'' +
                ", modifiedOn='" + modifiedOn + '\'' +
                ", seriesStart=" + seriesStart +
                ", seriesEnd=" + seriesEnd +
                ", seriesType='" + seriesType + '\'' +
                ", operatorName='" + operatorName + '\'' +
                ", remarks='" + remarks + '\'' +
                ", user=" + user +
                ", userId=" + userId +
                ", length='" + length + '\'' +
                ", userName='" + userName + '\'' +
                ", auditTraildDTO=" + auditTraildDTO +
                '}';
    }
}
