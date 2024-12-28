package org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model;

public class MSISDNSeriesLengthResponse {
    private String tag;
    private String message;
    private int statusCode;
    private Object data;
    private String seriesLength;
    private boolean isValid;

    public boolean isValid() {
        return isValid;
    }

    public MSISDNSeriesLengthResponse setValid(boolean valid) {
        isValid = valid;
        return this;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getSeriesLength() {
        return seriesLength;
    }

    public void setSeriesLength(String seriesLength) {
        this.seriesLength = seriesLength;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("MSISDNSeriesLengthResponse{");
        sb.append("tag='").append(tag).append('\'');
        sb.append(", message='").append(message).append('\'');
        sb.append(", statusCode=").append(statusCode);
        sb.append(", data=").append(data);
        sb.append(", seriesLength='").append(seriesLength).append('\'');
        sb.append(", isValid=").append(isValid);
        sb.append('}');
        return sb.toString();
    }
}
