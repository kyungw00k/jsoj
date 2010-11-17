package net.jsoj.controller;

import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.service.MemberService;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.persistence.service.SubmissionService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class MemberController {
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpSession session, ModelMap model) {
		Object obj = session.getAttribute("member");
		Member member = obj instanceof Member ? (Member)obj : null;
		if ( member != null ) {
			return "redirect:/";
		}
		return "member/login";
	}

	@RequestMapping(value = "/deleteme", method = RequestMethod.POST)
	public String deleteMe(HttpSession session, ModelMap model) {
		Object obj = session.getAttribute("member");
		Member member = obj instanceof Member ? (Member)obj : null;
		if ( member != null && MemberService.delete(member) ) {
			session.removeAttribute("member");
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, ModelMap model, SessionStatus status) {
		status.setComplete();
		session.removeAttribute("member");
		session = null;
		return "redirect:/";
	}
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile(HttpSession session, ModelMap model) {
		Member logonMember = null;
		Object obj = session.getAttribute("member");
		if ( obj != null && obj instanceof Member ) {
			logonMember =  (Member)obj;
			return view(session,logonMember.getNickName(),model);
		}
		model.addAttribute("error","TEST");
		return "redirect:/";
	}

	
	@RequestMapping(value = "/profile/{screenName}", method = RequestMethod.GET)
	public String view(HttpSession session,@PathVariable(value="screenName") String screenName, ModelMap model) {

		Member selectedMember = null;
		Member logonMember = null;

		if ( screenName != null ) {
			model.addAttribute("screenName",screenName);
			selectedMember = MemberService.findByNickName(screenName);
		}
		
		Object obj = session.getAttribute("member");
		if ( obj != null && obj instanceof Member ) {
			logonMember =  (Member)obj;			
		}
		
		boolean isLogonMember =  selectedMember != null && logonMember != null && selectedMember.getNickName().equals(logonMember.getNickName());
		
		if ( selectedMember != null ) {
			HashMap<Problem, HashMap<String, Double>> submissions = SubmissionService.getAcceptedByAccountId(selectedMember.getAccountId());
			model.addAttribute("entry", selectedMember);
			model.addAttribute("submissions", submissions.size() > 0 ? submissions : null);
			model.addAttribute("status", SubmissionService.getStatusByAccountId(selectedMember.getAccountId()) );

			Iterator<Problem> problems = ProblemService.getAllByAccoundId(selectedMember.getAccountId());
			HashMap<Problem, HashMap<String, Integer>> status = new HashMap<Problem, HashMap<String, Integer> >();
			
			while (problems.hasNext()) {
				Problem problem = problems.next();
				status.put(problem, SubmissionService.getStatusByProblemId(problem.getId()));
			}
			if ( status.size() > 0 ) {
				model.addAttribute("problems", status);
			}
		}

		model.addAttribute("realYou", isLogonMember);
		
		return "member/view";
	}
}
