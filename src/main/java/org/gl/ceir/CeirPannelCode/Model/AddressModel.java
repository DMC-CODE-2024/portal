package org.gl.ceir.CeirPannelCode.Model;

import org.springframework.stereotype.Component;

@Component
public class AddressModel {

	private String province;
	private Long districtID;
	private Long communeID;

	//------Initiate Recovery Start -----

	private String Lang;
	private Integer id;

	public String getLang() {
		return Lang;
	}

	public void setLang(String lang) {
		Lang = lang;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	//---------Initiate Recovery End----------------

	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public Long getDistrictID() {
		return districtID;
	}
	public void setDistrictID(Long districtID) {
		this.districtID = districtID;
	}
	public Long getCommuneID() {
		return communeID;
	}
	public void setCommuneID(Long communeID) {
		this.communeID = communeID;
	}

	@Override
	public String toString() {
		return "AddressModel{" +
				"province='" + province + '\'' +
				", districtID=" + districtID +
				", communeID=" + communeID +
				", Lang='" + Lang + '\'' +
				", id=" + id +
				'}';
	}
}
