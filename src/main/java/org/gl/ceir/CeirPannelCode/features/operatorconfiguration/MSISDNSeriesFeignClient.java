package org.gl.ceir.CeirPannelCode.features.operatorconfiguration;

import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.MSISDNSeriesLengthResponse;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.MSISDNSeriesModel;
import org.gl.ceir.CeirPannelCode.features.trc.model.MDR;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Component
@FeignClient(url = "${feignClientPath}", value = "msisdnSeriesFeign")
public interface MSISDNSeriesFeignClient {
    @PostMapping("/v1/operator-configuration/msisdn-series/paging")
    public Object paging(@RequestBody MSISDNSeriesModel msisdnSeriesModel,
                         @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                         @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                         @RequestParam(value = "file", defaultValue = "0") Integer file);

    @PostMapping("/v1/operator-configuration/msisdn-series")
    public ResponseEntity<GenricResponse> save(@RequestBody MSISDNSeriesModel msisdnSeriesModel);

    @PutMapping("/v1/operator-configuration/msisdn-series")
    public ResponseEntity<GenricResponse> update(@RequestBody MSISDNSeriesModel msisdnSeriesModel);

    @DeleteMapping("/v1/operator-configuration/msisdn-series")
    public ResponseEntity<GenricResponse> delete(@RequestBody MSISDNSeriesModel msisdnSeriesModel);

    @PostMapping("/v1/operator-configuration/msisdn-series/distinct")
    public Map<String, List<?>> val(@RequestBody List<String> param);

    @PostMapping("/v1/operator-configuration/msisdn-series/export")
    public FileExportResponse export(@RequestBody MSISDNSeriesModel msisdnSeriesModel);

    @GetMapping("/v1/operator-configuration/msisdn-series/{id}")
    public MSISDNSeriesModel findByID(@PathVariable(name = "id") Long id);

    @GetMapping("/v1/operator-series/series/{msisdn}")
    public MSISDNSeriesLengthResponse seriesLength(@PathVariable String msisdn);

}
