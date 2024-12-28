package org.gl.ceir.CeirPannelCode.features.cc.model;

public class CustomerCareRequest {
    private String requestId;
    private String featureName;
    private String feature;

    public String getFeature() {
        return feature;
    }

    public CustomerCareRequest setFeature(String feature) {
        this.feature = feature;
        return this;
    }

    public String getRequestId() {
        return requestId;
    }

    public CustomerCareRequest setRequestId(String requestId) {
        this.requestId = requestId;
        return this;
    }

    public String getFeatureName() {
        return featureName;
    }

    public CustomerCareRequest setFeatureName(String featureName) {
        this.featureName = featureName;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("CustomerCareRequest{");
        sb.append("requestId='").append(requestId).append('\'');
        sb.append(", featureName='").append(featureName).append('\'');
        sb.append(", feature='").append(feature).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
