package net.jsoj.persistence.dao.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class PostValidator implements Validator {

	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "required", "can't be blank");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "required", "can't be blank");
	}

	public boolean supports(Class<?> arg0) {
		return false;
	}
}
