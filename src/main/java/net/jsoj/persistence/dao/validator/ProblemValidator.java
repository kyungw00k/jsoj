package net.jsoj.persistence.dao.validator;

import java.util.regex.Pattern;

import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.service.ProblemService;
import net.jsoj.system.interpreter.InterpreterType;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class ProblemValidator implements Validator {

	public void validate(Object target, Errors errors) {
		Problem problem = (Problem)target;

		if (problem.getId() == null || problem.getId().trim().isEmpty() ) {
			errors.rejectValue("id", "required","can't be blank");
		} else if ( problem.getId() != null && ProblemService.findById(problem.getId()) == null) {
			if (!Pattern.matches("[a-zA-Z]+[a-zA-Z0-9]*", problem.getId()) ) {
				errors.rejectValue("id", "required","use alphabet and 0-9 only");
			} else if ( problem.getId() != null && ProblemService.findById(problem.getId()) != null ){
				errors.rejectValue("id", "required","id already exists!");
			}
		}
		
		if (problem.getTestFuncName() == null || problem.getTestFuncName().trim().isEmpty() ) {
			errors.rejectValue("testFuncName", "required","can't be blank");
		} else if ( !Pattern.matches("[a-zA-Z]+[a-zA-Z0-9]*", problem.getTestFuncName()) ) {
			errors.rejectValue("testFuncName", "required","use alphabet and 0-9 only");
		}
		
		if (problem.getType() == InterpreterType.Core ) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "testOutput", "required", "can't be blank");
		}
		
		if (problem.getType() == InterpreterType.DOM ) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "markupDocument", "required", "can't be blank");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "scriptDocumentTest", "required", "can't be blank");
		}
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "required", "can't be blank");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "required", "can't be blank");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "timeLimit", "required", "can't be blank");
	}

	public boolean supports(Class<?> arg0) {
		return false;
	}
}
