package org.gl.ceir.CeirPannelCode.features.listmanagement;

import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.BlockListEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/block-list")
public class BlockIMEIRestController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private BlockIMEIListService blockIMEIListService;

    public BlockIMEIRestController(BlockIMEIListService blockIMEIListService) {
        this.blockIMEIListService = blockIMEIListService;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return blockIMEIListService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return blockIMEIListService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody BlockListEntity blockListEntity, HttpSession session) {
        return blockIMEIListService.export(blockListEntity, session);
    }

}
