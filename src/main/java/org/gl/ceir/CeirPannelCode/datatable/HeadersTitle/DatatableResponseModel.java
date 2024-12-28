package org.gl.ceir.CeirPannelCode.datatable.HeadersTitle;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

@Component
public class DatatableResponseModel {
    private Integer recordsTotal;
    //Integer recordsTotal = new Integer(10)     int recordsTotal;  int x= recordsTotal.intValue();
    private Integer recordsFiltered;
    private List<List<Object>> data = null;

    public Integer getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(Integer recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public Integer getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Integer recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public List<List<String>> getData() {
        List<String> collect = new ArrayList<>();
        List<List<String>> list = new ArrayList<>();
        for (List<Object> x : data) {
            collect = x.stream().map(y -> {
                String parameter = (String) y;
                return (parameter == null || parameter.trim().isEmpty()) ? "NA" : parameter;
            }).collect(Collectors.toList());
            list.add(collect);
        }
        return list;
    }

    public void setData(List<List<Object>> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "DatatableResponseModel [recordsTotal=" + recordsTotal + ", recordsFiltered=" + recordsFiltered
                + ", data=" + data + "]";
    }
}
