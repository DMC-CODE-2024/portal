package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

public class PairDeviceResponse {
    private String status;
    private ErrorInfo errorInfo;
    private Result result;

    public String getStatus() {
        return status;
    }

    public PairDeviceResponse setStatus(String status) {
        this.status = status;
        return this;
    }

    public ErrorInfo getErrorInfo() {
        return errorInfo;
    }

    public PairDeviceResponse setErrorInfo(ErrorInfo errorInfo) {
        this.errorInfo = errorInfo;
        return this;
    }

    public Result getResult() {
        return result;
    }

    public PairDeviceResponse setResult(Result result) {
        this.result = result;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("PairDeviceResponse{");
        sb.append("status='").append(status).append('\'');
        sb.append(", errorInfo=").append(errorInfo);
        sb.append(", result=").append(result);
        sb.append('}');
        return sb.toString();
    }
}
