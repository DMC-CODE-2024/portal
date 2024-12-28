package org.gl.ceir.CeirPannelCode.config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class PropertyReader {
    @Value("${sessionLogOutTime}")
    public int sessionLogOutTime;

/*
    @Value("${propertiesFileLocation}")
    public String propertiesFileLocation;
*/

    @Value("${locationFeignClientPath}")
    public String locationFeignClientPath;

    @Value("${testing}")
    public String testing;
    @Value("${sourceServerName}")
    public String sourceServerName;
    @Value("${destServerName}")
    public String destServerName;
    @Value("${destFilePath}")
    public String destFilePath;

    @Value("${token.url}")public String tokenURL;
}
