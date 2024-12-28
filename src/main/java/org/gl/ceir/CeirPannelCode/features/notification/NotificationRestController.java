package org.gl.ceir.CeirPannelCode.features.notification;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.features.notification.model.NotificationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/notification")
public class NotificationRestController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private NotificationService notificationService;
    private APIService6Feign apiService6Feign;

    public NotificationRestController(NotificationService notificationService, APIService6Feign apiService6Feign) {
        this.notificationService = notificationService;
        this.apiService6Feign = apiService6Feign;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return notificationService.paging(request, session);
    }

    @PostMapping
    public ResponseEntity<?> viewById(@RequestBody NotificationModel notificationModel) {
        return new ResponseEntity<>(apiService6Feign.viewById(notificationModel), HttpStatus.OK);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return notificationService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody NotificationModel notificationModel, HttpSession session) {
        return notificationService.export(notificationModel, session);
    }

}
