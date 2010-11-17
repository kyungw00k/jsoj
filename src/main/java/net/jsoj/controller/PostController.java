package net.jsoj.controller;

import java.util.Iterator;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Comment;
import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Post;
import net.jsoj.persistence.dao.validator.CommentValidator;
import net.jsoj.persistence.dao.validator.PostValidator;
import net.jsoj.persistence.service.CommentService;
import net.jsoj.persistence.service.PostService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PostController {
	final Logger logger = Logger.getLogger(getClass().getName());

	@RequestMapping(value = "/posts", method = RequestMethod.GET)
	public String top(ModelMap model) {
		Iterator<Post> posts = PostService.getAll();

		if (posts.hasNext()) {
			model.addAttribute("posts", posts);
		}
		return "post/top";
	}

	@RequestMapping(value = "/post/{id}", method = RequestMethod.GET)
	public String show(ModelMap model, HttpSession session,
			@PathVariable(value = "id") Long id) {
		Post post = PostService.findById(id);
		if (post != null) {
			model.addAttribute("post", post);
		}

		Object obj = session.getAttribute("member");

		if (obj != null && obj instanceof Member) {
			model.addAttribute("comment", new Comment());
		}
		model.addAttribute("comments",
				CommentService.getByOwnerId(post.getId().toString()));
		model.addAttribute("comment", new Comment());
		return "post/show";
	}

	@RequestMapping(value = "/post/add", method = RequestMethod.GET)
	public String add(ModelMap model, HttpSession session) {
		Object obj = session.getAttribute("member");

		if (obj == null || obj instanceof Member == false) {
			return "redirect:/login";
		}

		model.addAttribute("post", new Post());
		model.addAttribute("isNew", true);
		return "post/edit";
	}

	@RequestMapping(value = "/post/save", method = RequestMethod.POST)
	public String save(ModelMap model, HttpSession session,
			@ModelAttribute("post") Post post, BindingResult result) {
		Object obj = session.getAttribute("member");

		if (obj == null || obj instanceof Member == false) {
			return "redirect:/login";
		}
		post.setMember((Member)obj);

		new PostValidator().validate(post, result);
		if (result.hasErrors()) {
			model.addAttribute("isNew", true);
			return "/post/edit";
		}

		if (!PostService.save(post)) {
			model.addAttribute("error", "Your post can't save!");
			return "redirect:/post/add";
		}

		return "redirect:/posts";
	}

	@RequestMapping(value = "/post/{id}/edit", method = RequestMethod.GET)
	public String edit(ModelMap model, HttpSession session,
			@PathVariable(value = "id") Long id) {
		Object obj = session.getAttribute("member");

		if (obj == null || obj instanceof Member == false) {
			return "redirect:/login";
		}

		Post post = PostService.findById(id);

		if (post != null) {
			logger.info("Editing post #" + id);
			model.addAttribute("post", post);
			model.addAttribute("isNew", false);
			return "post/edit";
		}
		logger.info("Cannot editing post #" + id);
		return "redirect:/post/" + id;
	}

	@RequestMapping(value = "/post/{id}", method = RequestMethod.PUT)
	public String modify(ModelMap model, HttpSession session,
			@PathVariable(value = "id") Long id,
			@ModelAttribute("post") Post post, BindingResult result) {
		Object obj = session.getAttribute("member");

		if (obj == null || obj instanceof Member == false) {
			return "redirect:/login";
		}

		post.setId(id);
		post.setMember((Member)obj);

		new PostValidator().validate(post, result);
		if (result.hasErrors()) {
			model.addAttribute("isNew", false);
			return "/post/edit";
		}

		if (!PostService.save(post)) {
			model.addAttribute("error", "Can't update post #" + id);
			return "redirect:/post/add";
		}

		return "redirect:/post/" + id;
	}

	@RequestMapping(value = "/post/{id}/delete", method = RequestMethod.DELETE)
	public String delete(ModelMap model, HttpSession session,
			@PathVariable(value = "id") Long id) {
		Object obj = session.getAttribute("member");

		if (obj == null || obj instanceof Member == false) {
			return "redirect:/login";
		}
		Post post = PostService.findById(id);
		if (post != null) {
			boolean status = PostService.delete(post);
			logger.info("Deleting post " + id + " : " + status);
		}
		return "redirect:/posts";
	}

	@RequestMapping(value = "/post/{id}/comment", method = RequestMethod.POST)
	public String saveComment(ModelMap model, HttpSession session,
			@PathVariable(value = "id") Long id,
			@ModelAttribute("comment") Comment comment, BindingResult result) {
		Object obj = session.getAttribute("member");
		if (obj == null || obj instanceof Member == false) {
			logger.warning("sign in first!");
			return "redirect:/post/" + id;
		}

		Post post = PostService.findById(id);
		Member member = (Member) obj;
		if (post == null || member == null) {
			logger.warning("wrong access post id");
			return "redirect:/post/" + id;
		}

		new CommentValidator().validate(comment, result);
		if (result.hasErrors()) {
			model.addAttribute("post", post);
			return "/post/show";
		}

		comment.setPid(post.getId().toString());
		comment.setMember(member);

		if (!CommentService.save(comment)) {
			logger.warning("can't save comment");
		}
		return "redirect:/post/" + id;
	}

	@RequestMapping(value = "/post/{id}/comment/{cid}/delete", method = RequestMethod.DELETE)
	public String deleteComment(ModelMap model, HttpSession session,
			@PathVariable(value = "id") Long id,
			@PathVariable(value = "cid") Long cid) {
		Object obj = session.getAttribute("member");
		if (obj == null || obj instanceof Member == false) {
			logger.warning("sign in first!");
			return "redirect:/post/" + id;
		}
		Comment comment = CommentService.findById(cid);
		if (comment != null) {
			boolean status = CommentService.delete(comment);
			logger.info("Deleting comment " + cid + " : " + status);
		}
		return "redirect:/post/" + id;
	}
}
