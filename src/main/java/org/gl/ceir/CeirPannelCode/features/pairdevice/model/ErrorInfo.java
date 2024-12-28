package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

public class ErrorInfo {
    private Integer errorCode;
    private String errorLevel;
    private String errorMessage;

    public Integer getErrorCode() {
        return errorCode;
    }

    public ErrorInfo setErrorCode(Integer errorCode) {
        this.errorCode = errorCode;
        return this;
    }

    public String getErrorLevel() {
        return errorLevel;
    }

    public ErrorInfo setErrorLevel(String errorLevel) {
        this.errorLevel = errorLevel;
        return this;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public ErrorInfo setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("ErrorInfo{");
        sb.append("errorCode=").append(errorCode);
        sb.append(", errorLevel='").append(errorLevel).append('\'');
        sb.append(", errorMessage='").append(errorMessage).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
