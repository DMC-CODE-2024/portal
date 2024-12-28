package org.gl.ceir.CeirPannelCode.Model;
public class Operator {
	private String interp;
	private Integer value;
	public String getInterp() {
		return interp;
	}
	public void setInterp(String interp) {
		this.interp = interp;
	}
	public Integer getValue() {
		return value;
	}
	public void setValue(Integer value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "Operator [interp=" + interp + ", value=" + value + "]";
	}

}
