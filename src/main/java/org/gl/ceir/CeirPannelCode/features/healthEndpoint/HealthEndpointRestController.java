package org.gl.ceir.CeirPannelCode.features.healthEndpoint;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.features.trc.model.ResponseModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/health")
public class HealthEndpointRestController {
    private final Logger logger = LogManager.getLogger(this.getClass());

    private APIService6Feign apiService6Feign;

    public HealthEndpointRestController(APIService6Feign apiService6Feign) {
        this.apiService6Feign = apiService6Feign;
    }

    @GetMapping
    public ResponseEntity<?> get() {
        try {
            Object result = apiService6Feign.applicationHealth();
            logger.info(" application health :  {} ", result);
            return new ResponseEntity<>(new ResponseModel(200, result), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseModel(500, "Down"), HttpStatus.OK);
        }
    }
}
