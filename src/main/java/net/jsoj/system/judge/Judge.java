package net.jsoj.system.judge;

import java.util.logging.Logger;

import org.mozilla.javascript.EvaluatorException;

import net.jsoj.persistence.dao.SubmissionStatus;

public class Judge {
	static final Logger logger = Logger.getLogger(Judge.class.getName());
	
	public static SubmissionStatus handleException(Exception e) {
		SubmissionStatus results = SubmissionStatus.RuntimeError;
		
		if ( e instanceof EvaluatorException && ((EvaluatorException)e).getMessage().indexOf("Timeout") > -1 ) {
				results = SubmissionStatus.Timeout;
		}
		return results;	
	}
	
	public static SubmissionStatus getStatus(ValidationType type,
			String output, String expected) {
		SubmissionStatus results = SubmissionStatus.WrongAnswer;
		output = output.replaceAll("\r\n", "\n");
		switch (type) {
		case relativeFloat:
			if (Validation.relativeFloat(output, expected)) {
				results = SubmissionStatus.Accepted;
			}
			break;
		case strict:
			if (Validation.strict(output, expected)) {
				results = SubmissionStatus.Accepted;
			} else if (Validation.ignoreTrailingSpace(output, expected)
					|| Validation.ignoreTrailingEmptyLine(output, expected)
					|| Validation.ignoreWhiteSpace(output, expected) ) {
				results = SubmissionStatus.PresentationError;
			}
			break;
		case ignoreTrailingSpace:
			if (Validation.ignoreTrailingSpace(output, expected)) {
				results = SubmissionStatus.Accepted;
			} else if (Validation.ignoreWhiteSpace(output, expected)
					|| Validation.ignoreTrailingEmptyLine(output, expected) ) {
				results = SubmissionStatus.PresentationError;
			}
			break;
		case ignoreWhiteSpace:
			if (Validation.ignoreWhiteSpace(output, expected)) {
				results = SubmissionStatus.Accepted;
			} else if (Validation.ignoreTrailingSpace(output, expected)
					|| Validation.ignoreTrailingEmptyLine(output, expected) ) {
				results = SubmissionStatus.PresentationError;
			}
			break;
		case ignoreTrailingEmptyLine:
			if (Validation.ignoreTrailingEmptyLine(output, expected) ) {
				results = SubmissionStatus.Accepted;
			} else if (Validation.ignoreTrailingSpace(output, expected)
					|| Validation.ignoreWhiteSpace(output, expected) ) {
				results = SubmissionStatus.PresentationError;
			}
		}
		
		return results;
	}
}
