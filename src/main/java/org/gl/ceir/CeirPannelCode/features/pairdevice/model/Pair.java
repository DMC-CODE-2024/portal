package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

public class Pair {
    private String imei;
    private String msisdn;
    private String actualImei;
    private String imsie;
    private String recordTime;
    private String gsmaStatus;
    private String pairMode;
    private String pairingDate;
    private Integer allowedDays;

    public String getActualImei() {
        return actualImei;
    }

    public Pair setActualImei(String actualImei) {
        this.actualImei = actualImei;
        return this;
    }

    public String getImei() {
        return imei;
    }

    public Pair setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public Pair setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public String getImsie() {
        return imsie;
    }

    public Pair setImsie(String imsie) {
        this.imsie = imsie;
        return this;
    }

    public String getRecordTime() {
        return recordTime;
    }

    public Pair setRecordTime(String recordTime) {
        this.recordTime = recordTime;
        return this;
    }

    public String getGsmaStatus() {
        return gsmaStatus;
    }

    public Pair setGsmaStatus(String gsmaStatus) {
        this.gsmaStatus = gsmaStatus;
        return this;
    }

    public String getPairMode() {
        return pairMode;
    }

    public Pair setPairMode(String pairMode) {
        this.pairMode = pairMode;
        return this;
    }

    public String getPairingDate() {
        return pairingDate;
    }

    public Pair setPairingDate(String pairingDate) {
        this.pairingDate = pairingDate;
        return this;
    }

    public Integer getAllowedDays() {
        return allowedDays;
    }

    public Pair setAllowedDays(Integer allowedDays) {
        this.allowedDays = allowedDays;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Pair{");
        sb.append("imei='").append(imei).append('\'');
        sb.append(", msisdn='").append(msisdn).append('\'');
        sb.append(", actualImei='").append(actualImei).append('\'');
        sb.append(", imsie='").append(imsie).append('\'');
        sb.append(", recordTime='").append(recordTime).append('\'');
        sb.append(", gsmaStatus='").append(gsmaStatus).append('\'');
        sb.append(", pairMode='").append(pairMode).append('\'');
        sb.append(", pairingDate='").append(pairingDate).append('\'');
        sb.append(", allowedDays=").append(allowedDays);
        sb.append('}');
        return sb.toString();
    }
}
