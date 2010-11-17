package net.jsoj.interceptor;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter {
	final Logger logger = Logger.getLogger(getClass().getName());
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		logger.info("Check current session");
		HttpSession session = request.getSession(false);
		
        if (session == null) {
			logger.warning("Session can't be found");
			response.sendRedirect("/");
			return false;
		}

		UserService userService = UserServiceFactory.getUserService();
        
		// Admin User
		if ( userService.isUserLoggedIn() ) {
			if ( userService.isUserAdmin() ) {
				session.setAttribute("admin", userService.getCurrentUser());
			} else {
				session.removeAttribute("admin");
				response.sendRedirect("/");
				return false;
			}
		}
		return true;
	}
}
