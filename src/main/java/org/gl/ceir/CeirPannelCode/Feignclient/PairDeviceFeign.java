package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.TypeApprovedRequest;
import org.gl.ceir.CeirPannelCode.features.pairdevice.model.*;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Objects;

@Service
@FeignClient(url = "${pairDeviceFeignClientPath}", value = "pairdevicefeign")
public interface PairDeviceFeign {

    @PostMapping(value = "/pair")
    public PairDeviceResponse save(@RequestBody PairDevicePayload pairDevicePayload);

    @PostMapping(value = "/pair/repair")
    public PairDeviceResponse repairDeviceSave(@RequestBody RepairDevicePayload repairDevicePayload);

    @PostMapping(value = "/pair/status")
    public PairDeviceResponse pairStatus(@RequestBody PairStatusPayload pairStatusPayload);

    @PostMapping(value = "/pair/verify-otp")
    public PairDeviceResponse verifyOTP(@RequestBody VerifyOTPPayload verifyOTPPayload);
    @PostMapping(value = "/pair/resend-otp")
    public PairDeviceResponse resendOTP(@RequestBody VerifyOTPPayload verifyOTPPayload);
}

