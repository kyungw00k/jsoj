package net.jsoj.controller;

import java.util.Iterator;
import java.util.concurrent.ExecutionException;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Post;
import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.ProblemStatus;
import net.jsoj.persistence.dao.SubmissionStatus;
import net.jsoj.persistence.dao.validator.ProblemValidator;
import net.jsoj.persistence.service.MemberService;
import net.jsoj.persistence.service.PostService;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.persistence.service.SubmissionService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.appengine.api.quota.QuotaServiceFactory;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.petebevin.markdown.MarkdownProcessor;

@SuppressWarnings("unused")
@Controller
public class AdminController {
	final Logger logger = Logger.getLogger(getClass().getName());

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String top(ModelMap model) throws InterruptedException,
			ExecutionException {
		model.addAttribute("quota", QuotaServiceFactory.getQuotaService());

		Iterator<Problem> problems = ProblemService.getRecentPendingLists();
		if (problems.hasNext()) {
			model.addAttribute("problems", problems);
		}

		Iterator<Member> users = MemberService.getAll();
		if (users.hasNext()) {
			model.addAttribute("users", users);
		}

		return "admin/top";
	}

	@RequestMapping(value = "/admin/problems", method = RequestMethod.GET)
	public String manageProblems(ModelMap model) throws InterruptedException,
			ExecutionException {
		Iterator<Problem> problems = ProblemService.getRecentPendingLists();
		if (problems.hasNext()) {
			model.addAttribute("problems", problems);
		}
		Iterator<Problem> allProblems = ProblemService.getAll();
		if (allProblems.hasNext()) {
			model.addAttribute("allProblems", allProblems);
		}

		return "admin/problems";
	}

	@RequestMapping(value = "/admin/problem/{id}", method = RequestMethod.GET)
	public String problemShow(ModelMap model,
			@PathVariable(value = "id") String id) {
		Problem prob = ProblemService.findById(id);
		if (prob != null) {
			MarkdownProcessor m = new MarkdownProcessor();
			model.addAttribute("problem", prob);
			model.addAttribute("html", m.markdown(prob.getDescription()));
		}
		return "admin/problemShow";
	}

	@RequestMapping(value = "/admin/problem/{id}", method = RequestMethod.PUT)
	public String updateProblems(ModelMap model,
			@PathVariable(value = "id") String problemId,
			@RequestParam(required = false) String status)
			throws InterruptedException, ExecutionException {
		ProblemStatus problemStatus = null;
		if (status != null) {
			for (ProblemStatus stat : ProblemStatus.values()) {
				if (stat.toString().equals(status)) {
					problemStatus = stat;
					break;
				}
			}
			if (problemStatus == null) {
				return "redirect:/admin/problems";
			}
		}

		UserService userService = UserServiceFactory.getUserService();

		// Admin User
		if (userService.isUserLoggedIn() && userService.isUserAdmin()) {
			Problem problem = ProblemService.findById(problemId);
			if (problem != null) {
				if (status != null) {
					problem.setStatus(problemStatus);
				}
				if (!ProblemService.update(problem, true)) {
					logger.warning("Update job is failed.");
				}
			}
		}
		return "redirect:/admin/problems";
	}

	@RequestMapping(value = "/admin/problem/{id}", method = RequestMethod.DELETE)
	public String deleteProblems(ModelMap model,
			@PathVariable(value = "id") String problemId)
			throws InterruptedException, ExecutionException {
		UserService userService = UserServiceFactory.getUserService();

		// Admin User
		if (userService.isUserLoggedIn() && userService.isUserAdmin()) {
			if (!ProblemService.delete(ProblemService.findById(problemId))) {
				logger.warning("Deletion job is failed.");
			}
		}
		return "redirect:/admin/problems";
	}

	@RequestMapping(value = "/admin/users", method = RequestMethod.GET)
	public String manageUsers(ModelMap model) throws InterruptedException,
			ExecutionException {
		Iterator<Member> users = MemberService.getAll();
		if (users.hasNext()) {
			model.addAttribute("users", users);
		}
		return "admin/users";
	}

	@RequestMapping(value = "/admin/users/{id}/delete", method = RequestMethod.DELETE)
	public String deleteUsers(ModelMap model,
			@PathVariable(value = "id") Long accountId) {
		UserService userService = UserServiceFactory.getUserService();

		// Admin User
		if (userService.isUserLoggedIn() && userService.isUserAdmin()) {
			if (!MemberService.delete(MemberService.findById(accountId))) {
				logger.warning("Deletion job is failed.");
			}
		}
		return "redirect:/admin/users";
	}

	@RequestMapping(value = "/admin/contests", method = RequestMethod.GET)
	public String manageContests(ModelMap model) {
		return "admin/contests";
	}

	@RequestMapping(value = "/admin/submissions", method = RequestMethod.GET)
	public String manageSubmissions(ModelMap model) {
		SubmissionService.reStartStandByQueueing(SubmissionStatus.Submitted);
		return "admin/submissions";
	}
}
