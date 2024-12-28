package org.gl.ceir.CeirPannelCode.features.listmanagement;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.ExceptionListEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/exception-list")
public class ExceptionListRestController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private ExceptionListService exceptionListService;
    private APIService6Feign apiService6Feign;

    public ExceptionListRestController(ExceptionListService exceptionListService, APIService6Feign apiService6Feign) {
        this.exceptionListService = exceptionListService;
        this.apiService6Feign = apiService6Feign;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return exceptionListService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return exceptionListService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody ExceptionListEntity exceptionListEntity, HttpSession session) {
        return exceptionListService.export(exceptionListEntity, session);
    }

}
