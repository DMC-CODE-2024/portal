package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.CopyFileRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Component
@Service
@FeignClient(url = "${FileCopierFeignClient}", value = "fileCopier")


public interface FileCopierFeignClient {

    // ******************************************** save file copier api ********************************************************************************
    @RequestMapping(value = "/fileCopyApi", method = RequestMethod.POST)
    public GenricResponse saveCopyFileOnANotherServer(@RequestBody CopyFileRequest copyFileRequest);

}
