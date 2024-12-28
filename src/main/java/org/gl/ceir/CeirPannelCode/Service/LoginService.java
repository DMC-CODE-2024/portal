package org.gl.ceir.CeirPannelCode.Service;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Response.LoginResponse;
import org.gl.ceir.CeirPannelCode.Response.UpdateProfileResponse;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.gl.ceir.CeirPannelCode.features.GlobalMap;
import org.gl.ceir.CeirPannelCode.features.iconprivilege.Token;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

@Service
public class LoginService {
    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    APIService4Feign apiService4Feign;

    @Autowired
    RegistrationService registerService;

    @Autowired
    PropertyReader propertyReader;

    public ModelAndView loginPage(String isExpired, HttpSession session, HttpServletRequest request) {
        log.info("inside login controller");
        ModelAndView mv = new ModelAndView();
        Integer userid = (Integer) session.getAttribute("userid");
        if (Objects.nonNull(userid) && !(userid.equals(0) || userid.equals(-1))) {
            if ("yes".equalsIgnoreCase(isExpired)) {
                sessionRemoveCode(userid, session, request);
                mv.setViewName("login");
            } else {
                return new ModelAndView("redirect:./?lang=" + (String) session.getAttribute("language"));
            }

        } else {
            mv.setViewName("login");
        }
        log.info("exit from login controller");
        return mv;
    }

    public LoginResponse checkLogin(User user, HttpSession session, HttpServletRequest request) {
        Integer userid = (Integer) session.getAttribute("userid");
        LoginResponse response = new LoginResponse();
        String jwttoken = "";
        if (Objects.isNull(userid) || userid.equals(0) || userid.equals(-1)) {
            try {
                user.setUserName(user.getUsername());
                RestTemplate restTemplate = new RestTemplate();
                ResponseEntity<Token> responseEntity = restTemplate.postForEntity(propertyReader.tokenURL, user, Token.class);
                jwttoken = responseEntity.getBody().getToken();
                log.info("----------signIn API response-----------------" + responseEntity.getStatusCode() + " -----Message----- " + responseEntity.getBody().getMessage());
            } catch (Exception e) {
                log.info("--------exception while calling signIn API-----");
                e.printStackTrace();
            }
            response = apiService4Feign.checkUser(user);
            UserHeader header = registerService.getUserHeaders(request);
            user.setUserAgent(header.getUserAgent());
            user.setPublicIp(header.getPublicIp());
            user.setBrowser(header.getBrowser());
            session.setAttribute("publicIP", user.getPublicIp());
            session.setAttribute("browser", user.getBrowser());
            log.info("user data:  " + user);
            log.info("user agent=  " + user.getUserAgent() + " public ip of user: " + user.getPublicIp() + " browser :" + header.getBrowser());

            log.info("login response:  " + response);
            log.info("language = " + response.getUserLanguage());
            if (response.getStatusCode() == 200) {
                session.setAttribute("username", response.getUsername());
                session.setAttribute("userid", response.getUserId());
                session.setAttribute("usertypeList", response.getUserRoles());
                session.setAttribute("usertype", response.getPrimaryRole());
                session.setAttribute("name", response.getName());
                session.setAttribute("userStatus", response.getStatus());
                session.setAttribute("userStatusValue", response.getStatusValue());
                session.setAttribute("usertypeId", response.getPrimaryRoleId());
                session.setAttribute("operatorTypeId", response.getOperatorTypeId());
                session.setAttribute("operatorTypeName", response.getOperatorTypeName());
                session.setAttribute("language", response.getUserLanguage());
                session.setAttribute("period", response.getPeriod());
                session.setAttribute("selfRegister", response.getSelfRegister());
                session.setAttribute("defaultLink", response.getDefaultLink());
                session.setAttribute("token", response.getToken());
                session.setAttribute("jwttoken", jwttoken);

                session.setMaxInactiveInterval(propertyReader.sessionLogOutTime);

                return response;
            } else {
                response.setResponse(response.getResponse());
                return response;
            }
        } else {
            response.setStatusCode(200);
            response.setDefaultLink((String) session.getAttribute("defaultLink"));
            response.setUserLanguage((String) session.getAttribute("language"));
            return response;
        }


    }

/*    public HttpResponse changeLanguage(String language, HttpSession session, HttpServletRequest request) {
        log.info("inside check change language controller ");
        log.info("language data:  " + language);
        Integer userID = (Integer) session.getAttribute("userid");
        log.info("userID from session: " + userID);
        String username = (String) session.getAttribute("username");
        String userType = (String) session.getAttribute("usertype");
        Integer userTypeId = (Integer) session.getAttribute("usertypeId");
        ChangeLanguage languageData = new ChangeLanguage(language, username, userTypeId, userID, 0, userType);
        UserHeader header = registerService.getUserHeaders(request);
        String publicIp = header.getPublicIp();
        String browser = header.getBrowser();
        HttpResponse response = apiService4Feign.changeUserLanguage(languageData, publicIp, browser);
        if (response != null) {
            log.info("response from controller: " + response);
            session.removeAttribute("updatedLanguage");
            session.setAttribute("updatedLanguage", language);
        }
        log.info("exit from language controller ");
        return response;
    }*/

    public void sessionRemoveCode(Integer userid, HttpSession session, HttpServletRequest request) {

        log.info("userid from session: " + userid);
        UserHeader header = registerService.getUserHeaders(request);
        String publicIp = null;
        String browser = null;
        HttpResponse response = new HttpResponse();
        String username = (String) session.getAttribute("username");
        log.info("username from session: " + username);
        if (userid != null) {


            publicIp = header.getPublicIp();
            browser = header.getBrowser();
            response = apiService4Feign.sessionTracking(userid, publicIp, browser);
            log.info("response got: " + response);
        }

        if (username == null) {
            log.info("session value is not found no need  clear session");

        } else if (!username.equals(null) || Objects.nonNull(username) || !username.equals("")) {
            log.info("session value is found going to clear session");
            session.removeAttribute("username");
            session.removeAttribute("userid");
            session.removeAttribute("usertypeList");
            session.removeAttribute("usertype");
            session.removeAttribute("name");
            session.removeAttribute("userStatus");
            //session.removeAttribute("currentPageLocation");
            session.invalidate();
            //SecurityContextHolder.clearContext();
        }
    }

    public ModelAndView logout(HttpSession session, HttpServletRequest request) {
        log.info("inside logout controller");
        Integer userid = (Integer) session.getAttribute("userid");
        sessionRemoveCode(userid, session, request);

        ModelAndView mv = new ModelAndView();
        mv.addObject("msg", "you have been logged out successfully");
        mv.setViewName("login");
        log.info("exit logout controller");
        return mv;
    }

    public void indexPageSessionOut(HttpSession session, HttpServletResponse http, HttpServletRequest request) {
        log.info("inside index controller");
        Integer userid = (Integer) session.getAttribute("userid");
        sessionRemoveCode(userid, session, request);
        log.info("exit index controller");
        Tag tagData = new Tag("link_dmc_portal");
        Dropdown dropdown = feignCleintImplementation.dataByTag(tagData);
        try {
            http.sendRedirect(dropdown.getValue());
        } catch (IOException e) {
            e.printStackTrace();
        }
        //return "redirect:.../"+dropdown.getValue();
    }

    public void redirectToHome(HttpServletResponse http) {
        log.info("inside index controller");
        log.info("exit index controller");
        Tag tagData = new Tag("link_dmc_portal");
        Dropdown dropdown = feignCleintImplementation.dataByTag(tagData);
        try {
            http.sendRedirect(dropdown.getValue());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public ModelAndView dashBoard(HttpSession session, ServletRequest request) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String lang = httpRequest.getParameter("lang");
        Locale locale = Locale.forLanguageTag(lang);
        ModelAndView mv = new ModelAndView();
        log.info("importer dashboard entry point..");
        String username = (String) session.getAttribute("username");
        String status = (String) session.getAttribute("userStatus");
        try {
            if (username.trim() != null) {
                log.info("username from session:  " + username);
                log.info("user status from session :   " + status);
                Integer userId = (Integer) session.getAttribute("userid");
                List<Feature> features = new ArrayList<Feature>();
                List<Feature> featuresList = new ArrayList<Feature>();
                if (userId != 0) {
                    features = apiService4Feign.featureList(userId);
                }
                //  GlobalMap globalMap = new GlobalMap();
                for (Feature f : features) {
                    String link = f.getLink();
                    f.setLink(link + "?token=" + session.getAttribute("jwttoken") + "&lang=" + locale);
                    featuresList.add(f);
                    GlobalMap.put(f.getId(), f.getIconState());
                }
                log.info("featuresList :   " + featuresList);
                mv.setViewName("dashboard");
                mv.addObject("features", featuresList);
                log.info("importer dashboard exit point..");
                return mv;
            } else {
                mv.addObject("msg", "Please Login first");
                mv.setViewName("login");
                return mv;
            }
        } catch (Exception e) {
            mv.addObject("msg", "Please Login first");
            mv.setViewName("login");
            return mv;
        }
    }

    public UpdateProfileResponse forgotPasswordRequest(ForgotPassword password, HttpServletRequest request) {
        log.info("inside forgot password controller");

        UpdateProfileResponse response = new UpdateProfileResponse();
        UserHeader header = registerService.getUserHeaders(request);

        String publicIp = header.getPublicIp();
        String browser = header.getBrowser();
        log.info("password data is:  " + password + "  publicIp==" + publicIp + "  browser==" + browser);
        response = apiService4Feign.ForgotPassword(password, publicIp, browser);
        return response;
    }

    public HttpResponse updateNewPassword(Password password, HttpServletRequest request) {
        log.info("inside update new password controller");
        log.info("password data is :  " + password);
        if (password.getPassword().equals(password.getConfirmPassword())) {
            HttpResponse response = new HttpResponse();
            UserHeader header = registerService.getUserHeaders(request);

            String publicIp = header.getPublicIp();
            String browser = header.getBrowser();
            response = apiService4Feign.updateNewPassword(password, publicIp, browser);
            return response;
        } else {
            HttpResponse response = new HttpResponse("Both Passwords do the match", 500, "password_mismatch");
            return response;
        }

    }

    public HttpResponse changeExpirePassword(Password password, HttpServletRequest request) {
        log.info("inside expiry   password controller");

        if (password.getPassword().equals(password.getConfirmPassword())) {
            HttpResponse response = new HttpResponse();
            UserHeader header = registerService.getUserHeaders(request);
            password.setPublicIp(header.getPublicIp());
            password.setBrowser(header.getBrowser());
            log.info("password data is :  " + password);
            response = apiService4Feign.updateExpirePassword(password);
            log.info("response got:  " + response);
            return response;
        } else {
            HttpResponse response = new HttpResponse("Both Passwords do the match", 500, "password_mismatch");
            return response;
        }

    }


    public LoginResponse searchUserDetailService(UserStatus userStatus, HttpSession session, HttpServletRequest request) {
        log.info(" data send to searchUserDetail :  " + userStatus);
        //LoginResponse response=new LoginResponse();
        LoginResponse response = apiService4Feign.searchUserDetailFeign(userStatus);
        log.info(" response searchUserDetail :  " + response);
        return response;
    }

    public LoginResponse ipLogInformation(User user, HttpSession session, HttpServletRequest request) {
        // TODO Auto-generated method stub
        UserHeader header = registerService.getUserHeaders(request);
        user.setUserAgent(header.getUserAgent());
        user.setPublicIp(header.getPublicIp());
        user.setBrowser(header.getBrowser());
        session.setAttribute("publicIP", user.getPublicIp());
        session.setAttribute("browser", user.getBrowser());
        String usertype = (String) session.getAttribute("usertype");
        user.setUsertype(usertype);
        log.info("user data:  " + user);
        log.info("user agent=  " + user.getUserAgent() + " public ip of user: " + user.getPublicIp() + " browser :" + header.getBrowser());
        return apiService4Feign.ipLog(user);

    }

}
