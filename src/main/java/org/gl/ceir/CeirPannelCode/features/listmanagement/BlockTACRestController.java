package org.gl.ceir.CeirPannelCode.features.listmanagement;

import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.BlockTACEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/block-tac")
public class BlockTACRestController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private BlockTACService blockTACService;

    public BlockTACRestController(BlockTACService blockTACService) {
        this.blockTACService = blockTACService;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return blockTACService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return blockTACService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody BlockTACEntity blockTACEntity, HttpSession session) {
        return blockTACService.export(blockTACEntity, session);
    }

}
