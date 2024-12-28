package org.gl.ceir.CeirPannelCode.Model;

public class GsmaDetail {
	
	private String bandName;
	private Integer deviceId;
	private String equipmentType;
	private String imei;
	private String imsi;
	private String modelName;
	private String msisdn;
	private String operatingSystem;
	private String identifierType;
	public String getBandName() {
		return bandName;
	}
	public void setBandName(String bandName) {
		this.bandName = bandName;
	}
	public Integer getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(Integer deviceId) {
		this.deviceId = deviceId;
	}
	public String getEquipmentType() {
		return equipmentType;
	}
	public void setEquipmentType(String equipmentType) {
		this.equipmentType = equipmentType;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getImsi() {
		return imsi;
	}
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getMsisdn() {
		return msisdn;
	}
	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}
	public String getOperatingSystem() {
		return operatingSystem;
	}
	public void setOperatingSystem(String operatingSystem) {
		this.operatingSystem = operatingSystem;
	}
	public String getIdentifierType() {
		return identifierType;
	}
	public void setIdentifierType(String identifierType) {
		this.identifierType = identifierType;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("GsmaDetail [bandName=");
		builder.append(bandName);
		builder.append(", deviceId=");
		builder.append(deviceId);
		builder.append(", equipmentType=");
		builder.append(equipmentType);
		builder.append(", imei=");
		builder.append(imei);
		builder.append(", imsi=");
		builder.append(imsi);
		builder.append(", modelName=");
		builder.append(modelName);
		builder.append(", msisdn=");
		builder.append(msisdn);
		builder.append(", operatingSystem=");
		builder.append(operatingSystem);
		builder.append(", identifierType=");
		builder.append(identifierType);
		builder.append("]");
		return builder.toString();
	}
	
	
}