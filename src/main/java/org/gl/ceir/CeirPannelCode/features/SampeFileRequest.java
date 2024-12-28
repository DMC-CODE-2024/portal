package org.gl.ceir.CeirPannelCode.features;

public class SampeFileRequest {
    private int featureId;
    private String currentContextPath;
private int userTypeId;
    private String url;
    private String fileType;
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getUserTypeId() {
        return userTypeId;
    }

    public void setUserTypeId(int userTypeId) {
        this.userTypeId = userTypeId;
    }

    public String getFileType() {
        return fileType;
    }

    public SampeFileRequest setFileType(String fileType) {
        this.fileType = fileType;
        return this;
    }

    public String getUrl() {
        return url;
    }

    public SampeFileRequest setUrl(String url) {
        this.url = url;
        return this;
    }

    public int getFeatureId() {
        return featureId;
    }

    public SampeFileRequest setFeatureId(int featureId) {
        this.featureId = featureId;
        return this;
    }

    public String getCurrentContextPath() {
        return currentContextPath;
    }

    public SampeFileRequest setCurrentContextPath(String currentContextPath) {
        this.currentContextPath = currentContextPath;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("SampeFileRequest{");
        sb.append("featureId=").append(featureId);
        sb.append(", currentContextPath='").append(currentContextPath).append('\'');
        sb.append(", userTypeId=").append(userTypeId);
        sb.append(", url='").append(url).append('\'');
        sb.append(", fileType='").append(fileType).append('\'');
        sb.append(", type='").append(type).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
