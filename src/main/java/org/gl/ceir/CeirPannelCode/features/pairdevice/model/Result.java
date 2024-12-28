package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

import java.util.List;

public class Result {

    private String requestId;
    private String response;
    private String description;
    private List<Pair> pairs;
    private List<Pairsstatus> pairsStatus;

    public List<Pairsstatus> getPairsStatus() {
        return pairsStatus;
    }

    public Result setPairsStatus(List<Pairsstatus> pairsStatus) {
        this.pairsStatus = pairsStatus;
        return this;
    }

    public String getRequestId() {
        return requestId;
    }

    public Result setRequestId(String requestId) {
        this.requestId = requestId;
        return this;
    }

    public String getResponse() {
        return response;
    }

    public Result setResponse(String response) {
        this.response = response;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Result setDescription(String description) {
        this.description = description;
        return this;
    }

    public List<Pair> getPairs() {
        return pairs;
    }

    public Result setPairs(List<Pair> pairs) {
        this.pairs = pairs;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Result{");
        sb.append("requestId='").append(requestId).append('\'');
        sb.append(", response='").append(response).append('\'');
        sb.append(", description='").append(description).append('\'');
        sb.append(", pairs=").append(pairs);
        sb.append(", pairsStatus=").append(pairsStatus);
        sb.append('}');
        return sb.toString();
    }
}
