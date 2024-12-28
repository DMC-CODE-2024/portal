package org.gl.ceir.CeirPannelCode.datatable.model;

public class CommuneDetails {
    private  String commune;

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    @Override
    public String toString() {
        return "CommuneDetails{" +
                "commune='" + commune + '\'' +
                '}';
    }
}
