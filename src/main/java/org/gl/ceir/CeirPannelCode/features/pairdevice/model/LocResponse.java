package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

public class LocResponse {
    int statusCode;
    String statusMessage;
    String countryCode;
    String countryName;
    public int getStatusCode() {
        return statusCode;
    }
    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }
    public String getStatusMessage() {
        return statusMessage;
    }
    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }
    public String getCountryCode() {
        return countryCode;
    }
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
    public String getCountryName() {
        return countryName;
    }
    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }
    @Override
    public String toString() {
        return "LocResponse [statusCode=" + statusCode + ", statusMessage=" + statusMessage + ", countryCode="
                + countryCode + ", countryName=" + countryName + "]";
    }
}
