package org.gl.ceir.CeirPannelCode.Controller;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class Dashboard {
    private final Logger log = LoggerFactory.getLogger(getClass());
    @Autowired
    FeignCleintImplementation feignCleintImplementation;


    @Autowired
    LoginService loginService;
    ModelAndView mv = new ModelAndView();

    @GetMapping("/dashboard")
    public ModelAndView openUserRegisterPage(HttpSession session, HttpServletRequest request) {
        //return loginService.dashBoard(session,request);
        return loginService.dashBoard(session,request);
    }

    @RequestMapping(value = {"/Home_backup"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public ModelAndView Home(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Home");
        return mv;
    }

    @GetMapping("/404")
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public ModelAndView error404(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("404");
        return mv;
    }

    @GetMapping("/500")
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public ModelAndView error500(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("500");
        return mv;
    }

}
