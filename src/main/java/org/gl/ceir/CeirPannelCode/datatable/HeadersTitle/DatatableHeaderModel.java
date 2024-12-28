package org.gl.ceir.CeirPannelCode.datatable.HeadersTitle;

import java.util.Map;
import java.util.Objects;
import java.util.TreeMap;

public class DatatableHeaderModel {
    private String title;
    private Map<Integer, String> keyOrder = new TreeMap<>();


    public DatatableHeaderModel(String title) {
        super();
        this.title = title;
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (object == null || getClass() != object.getClass()) return false;
        DatatableHeaderModel that = (DatatableHeaderModel) object;
        return Objects.equals(title, that.title) && Objects.equals(keyOrder, that.keyOrder);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, keyOrder);
    }

    public DatatableHeaderModel(String title, Map<Integer, String> keyOrder) {
        this.title = title;
        this.keyOrder=keyOrder;
    }

    public Map<Integer, String> getKeyOrder() {
        return keyOrder;
    }

    public void setKeyOrder(Map<Integer, String> keyOrder) {
        this.keyOrder = keyOrder;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("DatatableHeaderModel{");
        sb.append("title='").append(title).append('\'');
        sb.append(", keyOrder=").append(keyOrder);
        sb.append('}');
        return sb.toString();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
