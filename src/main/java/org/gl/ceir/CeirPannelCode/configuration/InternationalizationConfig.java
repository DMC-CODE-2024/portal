package org.gl.ceir.CeirPannelCode.configuration;

import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.util.Locale;

@Configuration
public class InternationalizationConfig {

    @Autowired
    PropertyReader propertyReader;

    @Bean
    public SessionLocaleResolver localeResolver() {
        SessionLocaleResolver slr = new SessionLocaleResolver();
        slr.setDefaultLocale(new Locale("en"));
        return slr;
    }


    @Bean
    public FilterRegistrationBean<LocaleFilter> localeFilter(SessionLocaleResolver localeResolver) {
        FilterRegistrationBean<LocaleFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new LocaleFilter(localeResolver()));
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }


    @Bean
    public ReloadableResourceBundleMessageSource messageSource(Environment environment) {
        ReloadableResourceBundleMessageSource rs = new ReloadableResourceBundleMessageSource();
        String guiConfigPath = environment.getProperty("GUI_CONFIG_PATH") + "/messages";
        rs.setBasename("file:" + guiConfigPath);
       // rs.setBasename("classpath:messages");
        rs.setUseCodeAsDefaultMessage(true);
        rs.setDefaultEncoding("UTF-8");
        //rs.setCacheMillis(1);
        //  rs.clearCache();
        return rs;
    }
}
