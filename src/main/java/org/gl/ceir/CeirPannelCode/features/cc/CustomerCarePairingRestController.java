package org.gl.ceir.CeirPannelCode.features.cc;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.features.cc.model.CustomerCareRequest;
import org.gl.ceir.CeirPannelCode.features.cc.model.CustomerCareResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/pair-device-id")
public class CustomerCarePairingRestController {
    private final Logger logger = LogManager.getLogger(this.getClass());

    private APIService6Feign apiService6Feign;

    public CustomerCarePairingRestController(APIService6Feign apiService6Feign) {
        this.apiService6Feign = apiService6Feign;
    }

    @PostMapping
    public ResponseEntity<?> get(@RequestBody CustomerCareRequest customerCareRequest) {
        logger.info("[ customerCareRequest " + customerCareRequest + "]");
        return new ResponseEntity<>(apiService6Feign.getByRequestID(customerCareRequest), HttpStatus.OK);
    }
}
