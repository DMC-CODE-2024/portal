package org.gl.ceir.CeirPannelCode.interfacepackage;

import org.springframework.http.ResponseEntity;

public interface HeaderInterface {
	public ResponseEntity<?> headers(String role);
	
}
