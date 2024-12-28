package org.gl.ceir.CeirPannelCode.Model;

public class PortalAccessLog {
    private String browser;
    private String publicIp;
    private String userAgent;
    private String username;

    // Getters and setters
    public String getBrowser() {
        return browser;
    }

    public void setBrowser(String browser) {
        this.browser = browser;
    }

    public String getPublicIp() {
        return publicIp;
    }

    public void setPublicIp(String publicIp) {
        this.publicIp = publicIp;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("PortalAccessLog{");
        sb.append("browser='").append(browser).append('\'');
        sb.append(", publicIp='").append(publicIp).append('\'');
        sb.append(", userAgent='").append(userAgent).append('\'');
        sb.append(", username='").append(username).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
