package common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter("/*")
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
 
        if (path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/")) {
            // 정적 리소스에 대해서는 필터를 적용하지 않기
            chain.doFilter(request, response);
        } else {
            // 그 외의 요청에 대해서는 UTF-8 인코딩을 설정
            request.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            chain.doFilter(request, response);
        }
	}

}
