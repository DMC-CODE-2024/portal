package org.gl.ceir.CeirPannelCode.features.pairdevice;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.gl.ceir.CeirPannelCode.features.pairdevice.model.LocResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@Controller
public class PairDeviceController {
    private final Logger log = LoggerFactory.getLogger(getClass());
    @Autowired
    private PropertyReader propertyReader;

    @GetMapping("/pair-device")
    public ModelAndView view(HttpServletRequest request,@RequestParam(name="lang",required = false,defaultValue = "en") String lang) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("lang", lang);
        String locUrl=propertyReader.locationFeignClientPath;
        String testing=propertyReader.testing;
        String ipAddress = request.getRemoteAddr();
        log.info("request send to the get location api="+locUrl+" and IP Is ["+ipAddress+"] and test status ["+testing+"]");
        try {
            if(testing.equalsIgnoreCase("false")) {
                if(!checkLocation(ipAddress,locUrl)) {
                    mv.setViewName("NonCambodianUser");
                    return mv;
                }
            }

        } catch (IOException e1) {
            // TODO Auto-generated catch block
            log.info("ip locaton error."+e1);
        }
        mv.setViewName("showingPairDeviceDetails");
        return mv;
    }

    @GetMapping("/repair-device")
    public ModelAndView repairDeviceView(HttpServletRequest request,@RequestParam(name="lang",required = false,defaultValue = "en") String lang) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("lang", lang);
        String locUrl=propertyReader.locationFeignClientPath;
        String testing=propertyReader.testing;
        String ipAddress = request.getRemoteAddr();
        log.info("request send to the get location api="+locUrl+" and IP Is ["+ipAddress+"] and test status ["+testing+"]");
        try {
            if(testing.equalsIgnoreCase("false")) {
                if(!checkLocation(ipAddress,locUrl)) {
                    mv.setViewName("NonCambodianUser");
                    return mv;
                }
            }

        } catch (IOException e1) {
            // TODO Auto-generated catch block
            log.info("ip locaton error."+e1);
        }
        mv.setViewName("showingRepairDeviceDetails");
        return mv;
    }

    @GetMapping("/check-pair-status")
    public ModelAndView checkPairStatus(HttpServletRequest request,@RequestParam(name="lang",required = false,defaultValue = "en") String lang) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("lang", lang);
        String locUrl=propertyReader.locationFeignClientPath;
        String testing=propertyReader.testing;
        String ipAddress = request.getRemoteAddr();
        log.info("request send to the get location api="+locUrl+" and IP Is ["+ipAddress+"] and test status ["+testing+"]");
        try {
            if(testing.equalsIgnoreCase("false")) {
                if(!checkLocation(ipAddress,locUrl)) {
                    mv.setViewName("NonCambodianUser");
                    return mv;
                }
            }

        } catch (IOException e1) {
            // TODO Auto-generated catch block
            log.info("ip locaton error."+e1);
        }
        mv.setViewName("showingCheckPairStatusDetails");
        return mv;
    }


    public boolean checkLocation(String ip, String url) throws IOException {
        String ipType = "ipv4";
        if (ip.contains(":")) {
            ipType = "ipv6";
        }
        String json = "{\"ip\":\"" + ip + "\",\"ipType\":\"" + ipType + "\"}";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(json);
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();
        System.out.println("Response Code: " + responseCode);
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        System.out.println(response.toString());
        log.info("location response from api " + response.toString());
        Gson gson = new Gson();
        LocResponse resp = gson.fromJson(response.toString(), LocResponse.class);
        log.info("Gson location response from api " + resp.toString());
        if (resp.getStatusCode() == 202 || resp.getStatusCode() == 200) {
            return true;
        } else {
            return false;
        }
        //return response.toString();
    }
}
