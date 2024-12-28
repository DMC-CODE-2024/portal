package org.gl.ceir.CeirPannelCode.Model.constants;

public enum ApproveTypeStatus {
	APPROVED(0, "Approved"), REJECTED(1, "Rejected");
	private Integer code;
	private String description;

	ApproveTypeStatus(Integer code, String description) {
		this.code = code;
		this.description = description; 
	}       

	public Integer getCode() {
		return code;
	}
            
	public String getDescription() {
		return description;
	}
	

	public static ApproveTypeStatus getUserStatusByCode(Integer code) {
		for (ApproveTypeStatus approveStatus : ApproveTypeStatus.values()) {
			if (approveStatus.getCode() == code)
				return approveStatus;
		}

		return null;
	}
	
	public static ApproveTypeStatus getUserStatusByDesc(String desc) {
		for (ApproveTypeStatus approveStatus : ApproveTypeStatus.values()) {
			if (approveStatus.getDescription().equals(desc))
				return approveStatus;
		}

		return null;
	}
}
