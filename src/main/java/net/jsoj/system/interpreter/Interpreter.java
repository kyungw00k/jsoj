package net.jsoj.system.interpreter;

import javax.servlet.ServletContext;

/**
 * A virtual interpreter for executing statements for a particular programming
 * language.
 * 
 * In theory, {@code Interpreter} would be unnecessary given JSR 223 (Scripting
 * for the Java Platform}, but in practice it's simpler to create our own
 * specific interface for this application.
 * 
 */
public interface Interpreter {
	public void init(ServletContext context);

	public Context createContext();

	public Object execute(Context context, String script, String input)
			throws Exception;

	public Object execute(Context context, String script, String arguments,
			Long limitedTime, String funcName, String globalScript)
			throws Exception;

	public Object execute(Context context, String script, String input,
			Long limitedTime, String funcName, String globalScript,
			String markupDocument, String scriptDocumentTest) throws Exception;

	public Double getExecutionTime();

}