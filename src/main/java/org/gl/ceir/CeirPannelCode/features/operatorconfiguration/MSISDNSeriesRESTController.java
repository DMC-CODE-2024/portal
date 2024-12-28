package org.gl.ceir.CeirPannelCode.features.operatorconfiguration;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignClientImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.MSISDNSeriesLengthResponse;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.MSISDNSeriesModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/msisdn-series")
public class MSISDNSeriesRESTController {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    private final MSISDNSeriesService msisdnSeriesService;
    private final APIService6Feign apiService6Feign;
    private final MSISDNSeriesFeignClient msisdnSeriesFeignClient;

    @Autowired
    public MSISDNSeriesRESTController(MSISDNSeriesService msisdnSeriesService, APIService6Feign apiService6Feign, MSISDNSeriesFeignClient msisdnSeriesFeignClient) {
        this.msisdnSeriesService = msisdnSeriesService;
        this.apiService6Feign = apiService6Feign;
        this.msisdnSeriesFeignClient = msisdnSeriesFeignClient;
    }

    @PostMapping
    public ResponseEntity<GenricResponse> save(@RequestBody MSISDNSeriesModel msisdnSeriesModel) {
        logger.info("POST payload [" + msisdnSeriesModel + "]");
        ResponseEntity<GenricResponse> save = msisdnSeriesService.save(msisdnSeriesModel);
        return save;
    }

    @PutMapping
    public ResponseEntity<GenricResponse> update(@RequestBody MSISDNSeriesModel msisdnSeriesModel) {
        logger.info("PUT payload [" + msisdnSeriesModel + "]");
        ResponseEntity<GenricResponse> update = msisdnSeriesService.update(msisdnSeriesModel);
        return update;
    }

    @DeleteMapping
    public ResponseEntity<GenricResponse> delete(@RequestBody MSISDNSeriesModel msisdnSeriesModel) {
        logger.info("DELETE payload [" + msisdnSeriesModel + "]");
        ResponseEntity<GenricResponse> delete = msisdnSeriesService.delete(msisdnSeriesModel);
        return delete;
    }

    @PostMapping("/const")
    public Map<String, List<?>> val(@RequestBody List<String> param) {
        logger.info("Distinct params [" + param + "]");
        Map<String, List<?>> val = msisdnSeriesService.val(param);
        return val;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session, @RequestParam(value = "source", defaultValue = "menu", required = false) String source) {
        return msisdnSeriesService.paging(request, session, source);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return msisdnSeriesService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody MSISDNSeriesModel msisdnSeriesModel, HttpSession session) {
        return msisdnSeriesService.export(msisdnSeriesModel, session);
    }

    @GetMapping("/{id}")
    public MSISDNSeriesModel findByID(@PathVariable(name = "id") Long id) {
        logger.info("path varibale {}", id);
        return msisdnSeriesService.find(id);
    }

    @GetMapping("/series/{msisdn}")
    public MSISDNSeriesLengthResponse seriesLength(@PathVariable String msisdn) {
        return msisdnSeriesFeignClient.seriesLength(msisdn);
    }
}
