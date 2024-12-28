package org.gl.ceir.CeirPannelCode.features.listmanagement;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.GrayListEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/gray-list")
public class GrayListRestController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private GrayListService grayListService;

    public GrayListRestController(GrayListService grayListService) {
        this.grayListService = grayListService;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return grayListService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return grayListService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody GrayListEntity grayListEntity, HttpSession session) {
        return grayListService.export(grayListEntity, session);
    }

}
