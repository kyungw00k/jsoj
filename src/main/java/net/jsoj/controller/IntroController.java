package net.jsoj.controller;

import java.util.Iterator;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Post;
import net.jsoj.persistence.service.MemberService;
import net.jsoj.persistence.service.PostService;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.persistence.service.SubmissionService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.channel.*;

/**
 * @author kyungwook
 * 
 */
@Controller
public class IntroController {
	final Logger logger = Logger.getLogger(getClass().getName());
	String channel_id = null;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String top(HttpSession session, ModelMap model) {		
		model.addAttribute("totalMembers",MemberService.getSize());
		model.addAttribute("totalSubmissions",SubmissionService.getSize());
		model.addAttribute("totalProblems",ProblemService.getSize());
		model.addAttribute("totalDiscussions",PostService.getSize());
		model.addAttribute("totalContests",0/*ContestService.getSize()*/);

		Iterator<Post> notices = PostService.getNoticeAll();
		if (notices != null && notices.hasNext()) {
			model.addAttribute("notices", notices);
		}
		Iterator<Post> posts = PostService.getAll();
		if (posts != null && posts.hasNext()) {
			model.addAttribute("posts", posts);
		}
		/*
		ChannelService channelService = ChannelServiceFactory.getChannelService();
		channel_id = channelService.createChannel("intro");
		
		model.addAttribute("channel_id", channel_id);
		
		try {
			channelService.sendMessage(new ChannelMessage("intro", "Hello World"));
		} catch(Exception e) {
			System.out.println(e.getLocalizedMessage());
		}*/
		
		return "intro/top";
	}

	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String about(HttpSession session, ModelMap model) {
		return "intro/about";
	}
	
	@RequestMapping(value = "/errors", method = RequestMethod.GET)
	public String serverError(HttpSession session, ModelMap model) {
		return "errors/serverError";
	}
	
	@RequestMapping(value = "/discussion", method = RequestMethod.GET)
	public String discussion(HttpSession session, ModelMap model) {
		Iterator<Post> posts = PostService.getAll();
		if (posts.hasNext()) {
			model.addAttribute("posts", posts);
		}
		return "intro/discussion";
	}
}