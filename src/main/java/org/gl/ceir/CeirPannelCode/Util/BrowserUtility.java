package org.gl.ceir.CeirPannelCode.Util;

import org.gl.ceir.CeirPannelCode.Model.PortalAccessLog;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;
import java.util.Optional;

@Component
public class BrowserUtility {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    public String getBrowser(String userAgent) {
        String browser = "";
        String version = "";
        Integer startLen = 0;
        Integer endLen = 0;
        if (userAgent.toLowerCase().indexOf("msie") != -1) {
            browser = "IE";
            startLen = userAgent.toLowerCase().indexOf("msie");
            endLen = userAgent.indexOf(";", startLen);
            version = userAgent.substring(startLen + 5, endLen);
        } else if (userAgent.toLowerCase().indexOf("trident/7") != -1) {
            browser = "IE";
            startLen = userAgent.toLowerCase().indexOf("rv:") + 3;
            endLen = userAgent.indexOf(")", startLen);
            version = userAgent.substring(startLen, endLen);
        } else if (userAgent.toLowerCase().indexOf("chrome") != -1) {
            browser = "CHROME";
            startLen = userAgent.toLowerCase().indexOf("chrome") + 7;
            endLen = userAgent.indexOf(" ", startLen);
            version = userAgent.substring(startLen, endLen);
        } else if (userAgent.toLowerCase().indexOf("firefox") != -1) {
            browser = "FIREFOX";
            startLen = userAgent.toLowerCase().indexOf("firefox") + 8;
            endLen = userAgent.length();
            version = userAgent.substring(startLen, endLen);

        } else if (userAgent.toLowerCase().indexOf("safari") != -1) {
            browser = "SAFARI";
            startLen = userAgent.toLowerCase().indexOf("version") + 8;
            endLen = userAgent.indexOf(" ", startLen);
            version = userAgent.substring(startLen, endLen);
        } else if (userAgent.toLowerCase().indexOf("opera") != -1) {
            browser = "OPERA";
            startLen = userAgent.toLowerCase().indexOf("opera") + 6;
            endLen = userAgent.length();
            version = userAgent.substring(startLen, endLen);
        } else {
            browser = "OTHER";
        }

        return browser + "_" + version;

    }


    public <T extends AuditTrailModel> T auditTrailOperation(HttpServletRequest request, String featureName, String subFeature, String username) {
        String userAgent = request.getHeader("User-Agent");
        String ip = request.getRemoteAddr();
        AuditTrailModel auditTrailModel = new AuditTrailModel();
        String browser = this.getBrowser(userAgent);
        auditTrailModel.setBrowser(browser);
        auditTrailModel.setPublicIp(ip);
        auditTrailModel.setUserAgent(userAgent);
        auditTrailModel.setFeatureId(100002L);
        auditTrailModel.setFeatureName(featureName);
        auditTrailModel.setSubFeature(subFeature);
        auditTrailModel.setUserName(username);
        logger.info("auditTrailModel payload {}", auditTrailModel);
        return (T) auditTrailModel;
    }

    public <T extends PortalAccessLog> T portalAccessLogOperation(HttpServletRequest request, String username) {
        String userAgent = request.getHeader("User-Agent");
        String ip = request.getRemoteAddr();
        String browser = this.getBrowser(userAgent);

        PortalAccessLog portalAccessLog = new PortalAccessLog();
        portalAccessLog.setBrowser(browser);
        portalAccessLog.setPublicIp(ip);
        portalAccessLog.setUserAgent(userAgent);
        portalAccessLog.setUsername(username);

        logger.info("portalAccessLog payload {}", portalAccessLog);
        return (T) portalAccessLog;
    }

}
