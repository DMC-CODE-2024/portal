package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Objects;

@Service
@FeignClient(url = "${TicketAuthenticationFeigntPath}", value = "TicketAuthentication")

public interface TicketAuthenticationFeign {

    //-------------------Customer Care search IMEI get table details Controller-------------------//

    @GetMapping("/ticket/{ticketId}")
    public @ResponseBody Object verifyTicketFeign(
            @PathVariable("ticketId") String ticketId,
            @RequestHeader("X-Client-Type") String clientType,
            @RequestHeader("X-Client-Id") String clientId,
            @RequestHeader("loggedInUser") String loggedInUser);
}
