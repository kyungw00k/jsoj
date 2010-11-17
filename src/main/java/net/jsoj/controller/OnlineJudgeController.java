package net.jsoj.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.concurrent.ExecutionException;
import java.util.logging.Logger;

import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.Rank;
import net.jsoj.persistence.dao.Submission;
import net.jsoj.persistence.service.MemberService;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.persistence.service.SubmissionService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class OnlineJudgeController {
	final Logger logger = Logger.getLogger(getClass().getName());

	@RequestMapping(value = "/onlinejudge", method = RequestMethod.GET)
	public String top(ModelMap model) throws InterruptedException, ExecutionException {
		ArrayList< Rank > ranks = SubmissionService.getRankLists(MemberService.getAll());
		if ( ranks != null && ranks.size() > 0 ) {
			model.addAttribute("ranks", ranks);
		}
		
		Iterator<Submission> submissions = SubmissionService.getAll(); 
		if ( submissions != null && submissions.hasNext()) {
			model.addAttribute("submissions", submissions);
		}
		
		Iterator<Problem> problems = ProblemService.getRecentProblems();
		if ( problems != null && problems.hasNext() ) {
			model.addAttribute("newProblems", problems);
		}
		
		return "onlinejudge/top";
	}
}
