package org.gl.ceir.CeirPannelCode.features.trc;

import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.features.trc.model.MDR;
import org.gl.ceir.CeirPannelCode.features.trc.model.ResponseModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Component
@FeignClient(url = "${trcModulefeignClientPath}", value = "trcModulefeignClientPath")
public interface ApproveDeviceTACFeignClient {
    @PostMapping("/v1/trc/gsma-tac/paging")
    public Object paging(@RequestBody MDR mobileDeviceRepository, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize);

    @PostMapping("/trc/distinct/approve-device-tac")
    public Map<String, List<?>> distinctApproveDeviceTACDropdown(@RequestBody List<String> param);

    @PostMapping("/v1/trc/gsma-tac/export")
    public FileExportResponse export(@RequestBody MDR mobileDeviceRepository);

    @PostMapping("/v1/trc/gsma-tac")
    public ResponseModel update(MDR mobileDeviceRepository);
}
