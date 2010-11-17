package net.jsoj.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.ExecutionException;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Comment;
import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.ProblemStatus;
import net.jsoj.persistence.dao.validator.CommentValidator;
import net.jsoj.persistence.dao.validator.ProblemValidator;
import net.jsoj.persistence.service.CommentService;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.persistence.service.SubmissionService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petebevin.markdown.MarkdownProcessor;

/**
 * @author parksama
 * 
 */
@Controller
public class ProblemController {
	final Logger logger = Logger.getLogger(getClass().getName());

	/**
	 * 문제 목록 보기
	 * 
	 * @param model
	 * @return
	 * @throws ExecutionException
	 * @throws InterruptedException
	 */
	@RequestMapping(value = "/problem", method = RequestMethod.GET)
	public String top(ModelMap model) throws InterruptedException,
			ExecutionException {
		
		Iterator<Problem> problems = ProblemService.getAll();
		HashMap<Problem, HashMap<String, Integer>> status = new HashMap<Problem, HashMap<String, Integer> >();
		
		while (problems.hasNext()) {
			Problem problem = problems.next();
			status.put(problem, SubmissionService.getStatusByProblemId(problem.getId()));
		}
		if ( status.size() > 0 ) {
			model.addAttribute("status", status);
		}
		return "problem/top";
	}

	/**
	 * 특정 문제 보기
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/problem/{id}", method = RequestMethod.GET)
	public String show(ModelMap model, @PathVariable(value = "id") String id) {
		Problem prob = ProblemService.findById(id);
		if (prob != null) {
			MarkdownProcessor m = new MarkdownProcessor();
			model.addAttribute("problem", prob);
			model.addAttribute("html", m.markdown(prob.getDescription()));
		}
		model.addAttribute("comments",
				CommentService.getByOwnerId(prob.getId()));
		model.addAttribute("comment", new Comment());
		return "problem/show";
	}

	/**
	 * 문제 등록하기
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/problem/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		model.addAttribute("problem", new Problem());
		model.addAttribute("isNew", true);
		return "problem/edit";
	}

	/**
	 * 문제 등록하기
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/problem/save", method = RequestMethod.POST)
	public String save(ModelMap model, HttpSession session,
			@ModelAttribute("problem") Problem problem, BindingResult result) {
		Object obj = session.getAttribute("member");
		
		// Escaping Markup Document
		// problem.setMarkupDocument(StringEscapeUtils.escapeHtml(problem.getMarkupDocument()));

		if (obj != null && obj instanceof Member) {
			new ProblemValidator().validate(problem, result);
			if (result.hasErrors()) {
				model.addAttribute("isNew", true);
				return "problem/edit";
			}
			problem.setCreatedBy((Member) obj);
			if (!ProblemService.save(problem)) {
				model.addAttribute("error", "Your problem can't save!");
				return "redirect:/problem/add";
			}
		}
		return "redirect:/profile";
	}

	@RequestMapping(value = "/problem/{id}/edit", method = RequestMethod.GET)
	public String edit(ModelMap model, HttpSession session, @PathVariable(value = "id")  String id) {
		Object obj = session.getAttribute("member");
		if (obj != null && obj instanceof Member) {
			Member member = (Member)obj;
			Problem problem = ProblemService.findById(id);

			if ( problem != null && problem.getAccountId().equals(member.getAccountId())) {
				logger.info("Editing problem #"+id);
				model.addAttribute("problem", problem);
				model.addAttribute("isNew", false);
				return "problem/edit";
			}
		}
		logger.info("Cannot editing problem #"+id);
		return "redirect:/problem/"+id;
	}

	/**
	 * 문제 수정하기
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/problem/{id}", method = RequestMethod.PUT)
	public String modify(ModelMap model, HttpSession session, @PathVariable(value = "id") String id,
			@ModelAttribute("problem") Problem problem, BindingResult result) {
		Object obj = session.getAttribute("member");
		boolean authorized = ( obj != null && obj instanceof Member );

		if ( authorized ) {
			new ProblemValidator().validate(problem, result);
			if (result.hasErrors()) {
				model.addAttribute("isNew", false);
				return "problem/edit";
			}
			Problem original = ProblemService.findById(id);
			if ( original != null ) {
				if ( !original.getTestFuncName().equals(problem.getTestFuncName()) 
						|| !original.getTestInput().equals(problem.getTestInput())
						|| !original.getTestOutput().equals(problem.getTestOutput())) {
					problem.setStatus(ProblemStatus.Pending);
				}
			}
			problem.setCreatedBy((Member)obj);
			if (!ProblemService.update(problem, false)) {
				model.addAttribute("error", "Can't update problem #"+id);
				return "redirect:/problem/add";
			}
		}
		return "redirect:/problem/"+id;
	}

	/**
	 * 문제 삭제하기(권한 필요)
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/problem/{id}", method = RequestMethod.DELETE)
	public String delete(ModelMap model, HttpSession session, @PathVariable(value = "id") String id) {
		Object obj = session.getAttribute("member");
		if (obj != null && obj instanceof Member) {
			Member member = (Member)obj;
			Problem problem = ProblemService.findById(id);
			if ( problem.getAccountId().equals(member.getAccountId()) ) {
				boolean status = ProblemService.delete(problem);
				logger.info("Deleting problem "+id+" : "+ status);				
			}
		}
		return "redirect:/problem";
	}
	
	@RequestMapping(value = "/problem/{id}/comment", method = RequestMethod.POST)
	public String saveComment(ModelMap model, HttpSession session,
			@PathVariable(value = "id") String id,
			@ModelAttribute("comment") Comment comment, BindingResult result) {
		Object obj = session.getAttribute("member");
		if (obj == null || obj instanceof Member == false) {
			logger.warning("sign in first!");
			return "redirect:/problem/" + id;
		}

		Problem problem = ProblemService.findById(id);
		Member member = (Member) obj;
		if (problem == null || member == null) {
			logger.warning("wrong access post id");
			return "redirect:/problem";
		}

		new CommentValidator().validate(comment, result);
		if (result.hasErrors()) {
			if (problem != null) {
				MarkdownProcessor m = new MarkdownProcessor();
				model.addAttribute("problem", problem);
				model.addAttribute("html", m.markdown(problem.getDescription()));
			}
			return "/problem/show";
		}

		comment.setPid(problem.getId().toString());
		comment.setMember(member);

		if (!CommentService.save(comment)) {
			logger.warning("can't save comment");
		}
		return "redirect:/problem/" + id;
	}

	@RequestMapping(value = "/problem/{id}/comment/{cid}/delete", method = RequestMethod.DELETE)
	public String deleteComment(ModelMap model, HttpSession session,
			@PathVariable(value = "id") String id,
			@PathVariable(value = "cid") Long cid) {
		Object obj = session.getAttribute("member");
		if (obj == null || obj instanceof Member == false) {
			logger.warning("sign in first!");
			return "redirect:/problem/" + id;
		}
		Comment comment = CommentService.findById(cid);
		if (comment != null) {
			boolean status = CommentService.delete(comment);
			logger.info("Deleting comment " + cid + " : " + status);
		}
		return "redirect:/problem/" + id;
	}
}
