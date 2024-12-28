package org.gl.ceir.CeirPannelCode.features.notification;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NotificationController {
    @GetMapping("/notificationData")
    public ModelAndView view(@RequestParam(name = "featureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingNotificationDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

}
