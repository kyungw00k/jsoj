package net.jsoj.controller;

import java.util.Iterator;
import java.util.concurrent.ExecutionException;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.Submission;
import net.jsoj.persistence.dao.SubmissionStatus;
import net.jsoj.persistence.dao.validator.SubmissionValidator;
import net.jsoj.persistence.service.MemberService;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.persistence.service.SubmissionService;
import net.jsoj.system.interpreter.CoreInterpreter;
import net.jsoj.system.interpreter.Interpreter;
import net.jsoj.system.interpreter.InterpreterFactory;
import net.jsoj.system.interpreter.InterpreterType;
import net.jsoj.system.judge.Judge;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskHandle;
import com.google.appengine.api.taskqueue.TaskOptions;
import com.google.appengine.api.taskqueue.TaskOptions.Method;

/**
 * 문제 제출하기
 * 
 * @author kyungwook
 * 
 */
@Controller
public class SubmissionController {
	final Logger logger = Logger.getLogger(getClass().getName());

	/**
	 * @param model
	 * @return
	 * @throws ExecutionException
	 * @throws InterruptedException
	 */
	@RequestMapping(value = "/status", method = RequestMethod.GET)
	public String top(ModelMap model) throws InterruptedException,
			ExecutionException {
		Iterator<Submission> submissions = SubmissionService.getAll();
		if (submissions.hasNext()) {
			model.addAttribute("submissions", submissions);
		}
		return "submission/top";
	}

	@RequestMapping(value = "/submits", method = RequestMethod.GET)
	public String add(ModelMap model)
			throws Exception {
		Submission current = new Submission();
		current.setCode("");
		
		model.addAttribute("submission", current);
		model.addAttribute("languages", InterpreterType.values());
		return "submission/new";
	}
	
	@RequestMapping(value = "/submit/{pid}", method = RequestMethod.GET)
	public String addProb(ModelMap model, @PathVariable(value = "pid") String pid)
			throws Exception {
		Submission current = new Submission();
		current.setCode("");
		if ( pid != null ) {
			current.setProblemId(pid);
		}
		model.addAttribute("submission", current);
		model.addAttribute("languages", InterpreterType.values());
		return "submission/new";
	}

	/**
	 * @param code
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public String save(HttpSession session, ModelMap model,
			@ModelAttribute("submission") Submission submission,
			BindingResult result) {

		Object obj = session.getAttribute("member");
		if (obj != null && obj instanceof Member) {
			new SubmissionValidator().validate(submission, result);
			if (result.hasErrors()) {
				return "submission/new";
			}

			Problem problem = ProblemService
					.findById(submission.getProblemId());
			if (problem == null) {
				return "submission/new";
			}

			submission.setMember((Member) obj);
			submission.setProblemId(problem.getId());
			submission.setProblemTitle(problem.getTitle());
			
			InterpreterType type = problem.getType();
			submission.setLanguage(type == null ? InterpreterType.Core : type);
			
			if (SubmissionService.insert(submission) == null) {
				logger.warning("Submission is not found");
				return "redirect:/submit";
			}

			TaskHandle th = null;
			for (int queueIndex = 0; queueIndex < 5 && th == null; queueIndex++) {
				Queue queue = QueueFactory.getQueue("submission-queue-"
						+ queueIndex);
				try {
					th = queue.add(TaskOptions.Builder
							.withUrl("/submission/" + submission.getId())
							.method(Method.PUT).countdownMillis(2000));
				} catch (Exception e) {
					logger.warning(e.getMessage());
				}
			}
		} else {
			logger.warning("Access denied.");
			return "redirect:/login";
		}
		return "redirect:/status/";
	}

	/**
	 * Task Queue의 Callback으로 호출되어 정보 업데이트
	 * 
	 * @param id
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/submission/{id}", method = RequestMethod.PUT)
	public String update(HttpSession session,
			@PathVariable(value = "id") Long id, ModelMap model)
			throws Exception {
		String returnPage = "submission/update";

		logger.info("Updating status of submission #" + id);
		Submission current = SubmissionService.findById(id);

		if (current == null) {
			logger.warning("Cannot be found submission #" + id);
			return returnPage;
		}

		Problem currentProblem = ProblemService
				.findById(current.getProblemId());

		if (currentProblem == null) {
			logger.warning("Cannot be found problem of submission #" + id);
			return returnPage;
		}

		InterpreterFactory factory = new InterpreterFactory();

		Interpreter interpreterObj = factory.createInterpreter(current
				.getLanguage());

		Object output = null;
		String funcName = currentProblem.getTestFuncName();
		
		funcName = funcName == null || funcName.length() < 1
				? "main"
				: funcName;
		
		Double executionTime = 0.0;

		if (interpreterObj instanceof CoreInterpreter) {
			logger.info("Use JavaScript Interpreter");
			current.setStatus(SubmissionStatus.Running);
			if (!SubmissionService.update(current)) {
				logger.warning("Cannot update current submission #" + id);
			}
			output = ((CoreInterpreter) interpreterObj).execute(
					((CoreInterpreter) interpreterObj).createContext(),
					current.getCode(), currentProblem.getTestInput(),
					currentProblem.getTimeLimit(),
					funcName, currentProblem.getScriptGlobal()/*, currentProblem.getMarkupDocument(), currentProblem.getScriptDocumentTest()*/);

			executionTime = ((CoreInterpreter) interpreterObj)
					.getExecutionTime();

			current.setExecutionTime(executionTime);

			if (output != null && output instanceof String) {
				current.setStatus(Judge.getStatus(
						currentProblem.getValidationType(), (String) output,
						currentProblem.getTestOutput()));
			} else if (output instanceof Exception) {
				current.setStatus(Judge.handleException((Exception) output));
			} else {
				current.setStatus(SubmissionStatus.RuntimeError);
			}
		}

		logger.info("Output\n"+output);
		
		if (!SubmissionService.update(current)) {
			logger.warning("Cannot update current submission #" + id);
		}
		return returnPage;
	}

	/**
	 * @param id
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/submission/{id}", method = RequestMethod.DELETE)
	public String delete(@PathVariable(value = "id") String id, ModelMap model)
			throws Exception {
		return "submission/top";
	}

	@RequestMapping(value = "/ranks", method = RequestMethod.GET)
	public String ranklist(Model model) throws Exception {
		model.addAttribute("ranks",
				SubmissionService.getRankLists(MemberService.getAll()));
		return "submission/rank";
	}
}
