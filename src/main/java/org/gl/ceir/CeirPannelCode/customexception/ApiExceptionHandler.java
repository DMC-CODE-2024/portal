package org.gl.ceir.CeirPannelCode.customexception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler({RuntimeException.class})
    public ModelAndView error500(RuntimeException ex) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("500");
        mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        return mav;
    }
}
