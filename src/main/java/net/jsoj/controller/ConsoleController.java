package net.jsoj.controller;

import java.util.logging.Logger;

import net.jsoj.system.interpreter.CoreInterpreter;
import net.jsoj.system.interpreter.Interpreter;
import net.jsoj.system.interpreter.InterpreterFactory;
import net.jsoj.system.interpreter.InterpreterType;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ConsoleController {
	final Logger logger = Logger.getLogger(getClass().getName());
	private final String initCode = "var tcase = 1;\n// Main : Entry Point\n"
		+ "function main() {\n"
		+ "  // Write your code\n"
		+ "  return '\\ncase #'+(tcase++)+':\\n'+Array.prototype.slice.call(arguments).join('\\n');\n"
		+ "}";

	@RequestMapping(value = "/sandbox", method = RequestMethod.GET)
	public String show(ModelMap model) {
		model.addAttribute("code", initCode);
		model.addAttribute("output", "");
		model.addAttribute("argument", "'Daddy says', 'I can\\'t play'\n'in my', 'sandbox because'\n'my cat does', 'his business'\n'in there.'\n[1,2,3],[4,5,6]");
		model.addAttribute("languages", InterpreterType.values());
		return "console/show";
	}

	@RequestMapping(value = "/sandbox", method = RequestMethod.POST)
	public String submit(ModelMap model,
			@RequestParam(value = "code") String code,
			@RequestParam(value = "argument") String argument)
			throws Exception {
		InterpreterFactory factory = new InterpreterFactory();
		Interpreter interpreterObj = factory
				.createInterpreter(InterpreterType.Core);
		
		Object output = null;
		Double executionTime = 0.00;
		
		if (interpreterObj instanceof CoreInterpreter) {
			logger.info("Running Script...");
			output = ((CoreInterpreter) interpreterObj).execute(
					((CoreInterpreter) interpreterObj).createContext(),
					code,argument, 1L, "main", null/*, null, null*/);
			executionTime = ((CoreInterpreter) interpreterObj).getExecutionTime();
			logger.info("Execution Time : "+ executionTime);
		}
		model.addAttribute("code", code);
		if ( output instanceof String ) {
			model.addAttribute("output", (StringEscapeUtils.unescapeHtml( (String) output) ) );
		} else if ( output instanceof Exception){
			model.addAttribute("output", output);
		}
		model.addAttribute("argument", argument);
		return "console/show";
	}
}