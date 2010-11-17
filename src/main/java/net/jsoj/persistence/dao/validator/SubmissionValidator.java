package net.jsoj.persistence.dao.validator;

import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.ProblemStatus;
import net.jsoj.persistence.dao.Submission;
import net.jsoj.persistence.service.ProblemService;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class SubmissionValidator implements Validator {

	public boolean supports(Class<?> arg0) {
		return false;
	}

	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "code", "required", "can't be blank");
		
		Submission current = (Submission)target;

		if ( current.getProblemId() == null || current.getProblemId().trim().isEmpty() ) {
			errors.rejectValue("problemId", "required", "can't be blank");
		} else {
			Problem problem = ProblemService.findById(current.getProblemId());
			if (problem == null) {
				errors.rejectValue("problemId", "required", "doesn't exists");
			} else if ( problem.getStatus().equals(ProblemStatus.Accepted.toString()) == false ) {
				errors.rejectValue("problemId", "required", "can't submit because of status '"+problem.getStatus()+"'");
			}
		}
	}

}
