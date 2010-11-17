package net.jsoj.controller;

import java.io.FileInputStream;
import java.util.Properties;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.MemberType;
import net.jsoj.persistence.service.MemberService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.RequestToken;

@Controller
public class TwitterOAuthController {
	final Logger logger = Logger.getLogger(getClass().getName());
	private static final String PROPERTIES_NAME = "twitter.oauth.config.file";

	@RequestMapping(value = "/login/twitter", method = RequestMethod.GET)
	public String twitterLogin(HttpSession session,@RequestParam(value = "host") String host, ModelMap model) {
		RequestToken requestToken = null;
		Properties props = new Properties();
		Twitter twitter = new TwitterFactory().getInstance();
		String returnUrl = "/login";
		try {
			props.load(new FileInputStream(System.getProperty(PROPERTIES_NAME)));
			
			twitter.setOAuthConsumer(props.getProperty("consumer.key"), props.getProperty("consumer.secret"));
			requestToken = twitter.getOAuthRequestToken("http://"+host+"/callback/twitter");
			
			session.setAttribute("requestToken", requestToken);
			session.setAttribute("twitter", twitter);
			
			returnUrl = requestToken.getAuthenticationURL();
		} catch (Exception e) {
			logger.warning(e.getMessage());
			model.addAttribute("error", "Twitter is Over Capacity.");
		}
		return "redirect:"+returnUrl;
	}

	@RequestMapping(value = "/callback/twitter", method = RequestMethod.GET)
	public String twitterCallback(HttpSession session,
			@RequestParam(value = "oauth_token") String oauthToken,
			@RequestParam(value = "oauth_verifier") String oauthVerifier,
			ModelMap model) {
		Twitter twitter = (Twitter) session.getAttribute("twitter");
		RequestToken requestToken = (RequestToken) session.getAttribute("requestToken");
		session.removeAttribute("requestToken");
		session.removeAttribute("twitter");
		try {
			twitter.getOAuthAccessToken(requestToken, oauthVerifier);
			Member member = MemberService.findById(new Long((twitter.verifyCredentials().getId())));
			if ( member == null ) {
				member = new Member(
						new Long((twitter.verifyCredentials().getId())),
						MemberType.twitter,
						twitter.verifyCredentials().getScreenName(),
						twitter.verifyCredentials().getName(),
						twitter.verifyCredentials().getProfileImageURL(),
						twitter.verifyCredentials().getDescription(),
						twitter.verifyCredentials().getLocation()
					);
				
				if ( !MemberService.save(member) ) {
					logger.warning("Cannot save or update member information");
				} else {
					logger.info("Saved or updated member information");
				}
			} else {
				logger.info("Member information saved to session");
			}
			session.removeAttribute("member");
			session.setAttribute("member", member);
		} catch (TwitterException e) {
			logger.warning("Cannot sign in with twitter");
			logger.warning(e.getMessage());
			model.addAttribute("error", "Twitter is Over Capacity. Try again later!");
		} catch (Exception e) {
			logger.warning("Something went wrong");
			logger.warning(e.getMessage());	
			model.addAttribute("error", "Cannot sign in with twitter!<br />In this time, GAE went wrong. Try refresh again! ");
		}
		return "member/oauth";
	}
}
