package net.jsoj.interceptor;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Member;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	final Logger logger = Logger.getLogger(getClass().getName());
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		logger.info("Check current session");
		HttpSession session = request.getSession(false);
		
        if (session == null) {
			logger.warning("Session can't be found");
			response.sendRedirect("/login");
			return false;
		}

		logger.info("Check signin user");
		Member member = (Member) session.getAttribute("member");

		if ( member == null) {
			logger.warning("Please sign in");
			response.sendRedirect("/login");
			return false;
		}
		return true;
	}
}
