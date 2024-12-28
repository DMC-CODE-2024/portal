package org.gl.ceir.CeirPannelCode.configuration;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Component;

@Component
public class Translator {

    @Autowired
    MessageSource messageSource;

    @Autowired
    Translator(ReloadableResourceBundleMessageSource messageSource) {
        this.messageSource = messageSource;
    }

    public String toLocale(String msgCode) {
        Locale locale = LocaleContextHolder.getLocale();
        try {
            return messageSource.getMessage(msgCode, null, locale);
        } catch (NoSuchMessageException e) {
            return msgCode;
        }
    }
}