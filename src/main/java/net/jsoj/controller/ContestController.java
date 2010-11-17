package net.jsoj.controller;

import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Submission;
import net.jsoj.persistence.service.MemberService;
import net.jsoj.persistence.service.SubmissionService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ContestController {
	final Logger logger = Logger.getLogger(getClass().getName());

	@RequestMapping(value = "/contests", method = RequestMethod.GET)
	public String top(ModelMap model)  {
		return "contest/top";
	}

	@RequestMapping(value = "/contest/{id}/submit", method = RequestMethod.GET)
	public String add(ModelMap model, @PathVariable(value = "id") String id, @RequestParam(required = false) String pid) {
		return "contest/new";
	}

	@RequestMapping(value = "/contest/{id}/submit", method = RequestMethod.POST)
	public String save(HttpSession session, ModelMap model, @PathVariable(value = "id") String id, @ModelAttribute("contest") Submission contest, BindingResult result) {
	
		return "redirect:/contests";
	}

	@RequestMapping(value = "/contest/{id}", method = RequestMethod.PUT)
	public String update(HttpSession session,
			@PathVariable(value = "id") String id, ModelMap model)
			throws Exception {
		return "contest/view";
	}

	@RequestMapping(value = "/contest/{id}", method = RequestMethod.DELETE)
	public String delete(@PathVariable(value = "id") String id, ModelMap model)
			throws Exception {
		return "contest/top";
	}

	@RequestMapping(value = "/contest/{id}/ranks", method = RequestMethod.GET)
	public String ranklist(Model model) throws Exception {
		model.addAttribute("ranks",
				SubmissionService.getRankLists(MemberService.getAll()));
		return "contest/rank";
	}
	
	@RequestMapping(value = "/contest/{id}/status", method = RequestMethod.GET)
	public String status(Model model) throws Exception {
		model.addAttribute("ranks",
				SubmissionService.getRankLists(MemberService.getAll()));
		return "contest/status";
	}
}
