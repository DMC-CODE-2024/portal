package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

public class Pairsstatus {

    private String imei;
    private String actualImei;
    private String msisdn;
    private String guiMsisdn;
    private String imsi;
    private String status;
    private String description;

    public String getGuiMsisdn() {
        return guiMsisdn;
    }

    public Pairsstatus setGuiMsisdn(String guiMsisdn) {
        this.guiMsisdn = guiMsisdn;
        return this;
    }

    public String getActualImei() {
        return actualImei;
    }

    public Pairsstatus setActualImei(String actualImei) {
        this.actualImei = actualImei;
        return this;
    }

    public String getImei() {
        return imei;
    }

    public Pairsstatus setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public Pairsstatus setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public String getImsi() {
        return imsi;
    }

    public Pairsstatus setImsi(String imsi) {
        this.imsi = imsi;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public Pairsstatus setStatus(String status) {
        this.status = status;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Pairsstatus setDescription(String description) {
        this.description = description;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Pairsstatus{");
        sb.append("imei='").append(imei).append('\'');
        sb.append(", actualImei='").append(actualImei).append('\'');
        sb.append(", msisdn='").append(msisdn).append('\'');
        sb.append(", guiMsisdn='").append(guiMsisdn).append('\'');
        sb.append(", imsi='").append(imsi).append('\'');
        sb.append(", status='").append(status).append('\'');
        sb.append(", description='").append(description).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
