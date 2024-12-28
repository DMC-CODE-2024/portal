package org.gl.ceir.CeirPannelCode.datatable.model;

public class PoliceStationDetailModel {

    private String police;
    private String policeKm;
    private CommuneDetails communeDb;

    public String getPolice() {
        return police;
    }

    public void setPolice(String police) {
        this.police = police;
    }

    public String getPoliceKm() {
        return policeKm;
    }

    public void setPoliceKm(String policeKm) {
        this.policeKm = policeKm;
    }

    public CommuneDetails getCommuneDb() {
        return communeDb;
    }

    public void setCommuneDb(CommuneDetails communeDb) {
        this.communeDb = communeDb;
    }

    @Override
    public String toString() {
        return "PoliceStationDetailModel{" +
                "police='" + police + '\'' +
                ", policeKm='" + policeKm + '\'' +
                ", communeDb=" + communeDb +
                '}';
    }
}
