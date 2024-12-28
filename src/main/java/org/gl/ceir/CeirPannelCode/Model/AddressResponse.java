package org.gl.ceir.CeirPannelCode.Model;

import org.springframework.stereotype.Component;

@Component
public class AddressResponse {
	private String province;
	private String district;
	private Long districtID;
	private String commune;
	private Long communeID;
	private String village;
	private String counrty;
	private long id;
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public Long getDistrictID() {
		return districtID;
	}
	public void setDistrictID(Long districtID) {
		this.districtID = districtID;
	}
	public String getCommune() {
		return commune;
	}
	public void setCommune(String commune) {
		this.commune = commune;
	}
	public Long getCommuneID() {
		return communeID;
	}
	public void setCommuneID(Long communeID) {
		this.communeID = communeID;
	}
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	public String getCounrty() {
		return counrty;
	}
	public void setCounrty(String counrty) {
		this.counrty = counrty;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AddressResponse [province=");
		builder.append(province);
		builder.append(", district=");
		builder.append(district);
		builder.append(", districtID=");
		builder.append(districtID);
		builder.append(", commune=");
		builder.append(commune);
		builder.append(", communeID=");
		builder.append(communeID);
		builder.append(", village=");
		builder.append(village);
		builder.append(", counrty=");
		builder.append(counrty);
		builder.append(", id=");
		builder.append(id);
		builder.append("]");
		return builder.toString();
	}

	
	
}
