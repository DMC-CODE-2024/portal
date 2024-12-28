package org.gl.ceir.CeirPannelCode.datatable.model;

public class ProvinceDetails {

    private  String province;

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Override
    public String toString() {
        return "ProvinceDetails{" +
                "province='" + province + '\'' +
                '}';
    }
}
