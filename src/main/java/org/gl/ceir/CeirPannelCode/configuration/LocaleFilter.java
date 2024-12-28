package org.gl.ceir.CeirPannelCode.configuration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.io.IOException;
import java.util.Locale;

public class LocaleFilter implements Filter {

    private final SessionLocaleResolver localeResolver;

    public LocaleFilter(SessionLocaleResolver localeResolver) {
        this.localeResolver = localeResolver;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String lang = httpRequest.getParameter("lang");
        if (lang != null) {
            Locale locale = Locale.forLanguageTag(lang);
            localeResolver.setLocale(httpRequest, httpResponse, locale);
        }
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
