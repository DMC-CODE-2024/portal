package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class StolenImeiStatusPaginitionModel {

    private List<StolenImeiStatusContentModel> content;
    ////private Pageable pageable;
    private Boolean last;
    private Integer totalPages;
    private Integer totalElements;
    private Integer size;
    private Integer number;
    ////private Sort sort;
    private Boolean first;
    private Integer numberOfElements;
    private Boolean empty;

    public Integer getNumberOfElements() {
        return numberOfElements;
    }

    public void setNumberOfElements(Integer numberOfElements) {
        this.numberOfElements = numberOfElements;
    }

    public List<StolenImeiStatusContentModel> getContent() {
        return content;
    }

    public void setContent(List<StolenImeiStatusContentModel> content) {
        this.content = content;
    }



    public Boolean getLast() {
        return last;
    }

    public void setLast(Boolean last) {
        this.last = last;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public Integer getTotalElements() {
        return totalElements;
    }

    public void setTotalElements(Integer totalElements) {
        this.totalElements = totalElements;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }



    public Boolean getFirst() {
        return first;
    }

    public void setFirst(Boolean first) {
        this.first = first;
    }

    public Boolean getEmpty() {
        return empty;
    }

    public void setEmpty(Boolean empty) {
        this.empty = empty;
    }

    @Override
    public String toString() {
        return "StolenImeiStatusPaginitionModel{" +
                "content=" + content +
                ", last=" + last +
                ", totalPages=" + totalPages +
                ", totalElements=" + totalElements +
                ", size=" + size +
                ", number=" + number +
                ", first=" + first +
                ", numberOfElements=" + numberOfElements +
                ", empty=" + empty +
                '}';
    }
}
