package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class RegistrationHandler {

private Map<String, Object> additionalProperties = new HashMap<String, Object>();

public Map<String, Object> getAdditionalProperties() {
	return additionalProperties;
}

public void setAdditionalProperties(Map<String, Object> additionalProperties) {
	this.additionalProperties = additionalProperties;
}

@Override
public String toString() {
	return "RegistrationHandler [getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
			+ super.toString() + "]";
}

}
