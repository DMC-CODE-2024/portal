package org.gl.ceir.CeirPannelCode.config;

import org.owasp.html.HtmlPolicyBuilder;
import org.owasp.html.PolicyFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

@Component
public class HtmlSanitizingFilter extends GenericFilterBean {

    private final PolicyFactory policy;
    
    public HtmlSanitizingFilter() {
        HtmlPolicyBuilder policyBuilder = new HtmlPolicyBuilder();
        // Allow only safe HTML elements and attributes
        policyBuilder.allowElements("a", "p", "div", "span", "strong", "em", "ul", "ol", "li");
        policyBuilder.allowAttributes("href").onElements("a");

        // Disallow script tags and event attributes
        policyBuilder.disallowElements("script");
        policyBuilder.disallowAttributes("on*").onElements("*");

        policy = policyBuilder.toFactory();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Sanitize user inputs before rendering
        SanitizedRequestWrapper sanitizedRequest = new SanitizedRequestWrapper((HttpServletRequest) request, policy);
        
        if (containsScriptTag(sanitizedRequest)) {
            // Reject the request with a forbidden status code (HTTP 403)
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            httpResponse.setStatus(HttpStatus.FORBIDDEN.value());
            logger.info("Request rejected: Script tags are not allowed.");
            httpResponse.getWriter().write("Request rejected: Script tags are not allowed.");
            return;
        }
        
        chain.doFilter(sanitizedRequest, response);
    }

    private static class SanitizedRequestWrapper extends HttpServletRequestWrapper {

        private final PolicyFactory policy;

        public SanitizedRequestWrapper(HttpServletRequest request, PolicyFactory policy) {
            super(request);
            this.policy = policy;
        }

        @Override
        public String getParameter(String name) {
            // Sanitize the parameter value before returning it
            String unsanitizedValue = super.getParameter(name);
            return policy.sanitize(unsanitizedValue);
        }
    }
    
    private boolean containsScriptTag(ServletRequest request) {
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues != null) {
                for (String paramValue : paramValues) {
                    if (paramValue != null && paramValue.contains("<script>")) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
   
}
