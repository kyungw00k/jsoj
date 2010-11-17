package net.jsoj.system.interpreter;

import java.util.logging.Logger;

import javax.servlet.ServletContext;

import net.jsoj.system.sandbox.SandboxContextFactory;

import org.mozilla.javascript.ContextFactory;
import org.mozilla.javascript.EvaluatorException;
import org.mozilla.javascript.Function;
import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.WrappedException;

import com.vobject.appengine.java.io.File;
import com.vobject.appengine.java.io.FileInputStream;

/**
 * @author kyungwook
 * 
 */
public class CoreInterpreter implements Interpreter {
	final static Logger logger = Logger.getLogger(CoreInterpreter.class.getName());
	static String testScript = null;
	private Long executionTime = 0L;
	
	public void init(ServletContext context) {
	}

	public Context createContext() {
		return new Ctx(null/*new EnvJsCtx().scope*/);
	}

	public Object execute(net.jsoj.system.interpreter.Context context,
			String script, String arguments) throws Exception {
		logger.info("Default execution mode(3s)");
		return execute(context, script, arguments, 3L, "main", null, null, null);
	}
	
	public Object execute(Context context, String script, String arguments,
			Long limitedTime, String funcName, String globalScript) throws Exception {
		Ctx ctx = (Ctx) context;
		Object output = null;
		funcName = funcName == null ? "main" : funcName;
		try {
			logger.info("Setting limited time");
			ctx.jsContext.putThreadLocal("limitedTime", limitedTime);

			if (globalScript != null) {
				logger.info("Initialized global environment...");
				ctx.jsContext.evaluateString(ctx.scope, globalScript, "GLOBAL", 0, null);
			}
			
			logger.info("Evaluate user code...");
			ctx.jsContext.evaluateString(ctx.scope, script, "code", 1, null);
			
			logger.info("Finding user defined function...");
			Object fObj = ctx.scope.get(funcName, ctx.scope);
			if ( fObj == Scriptable.NOT_FOUND ) {
				return new EvaluatorException(funcName + " is undefined");
			} else if (!(fObj instanceof Function)) {
				return new EvaluatorException(funcName + " is not a function");
			}
			
			logger.info("Run test drive...");
			Object[] args = {funcName, arguments.replaceAll("\n|\r\n", "\n")};
			Object result = ctx.testFunction.call(ctx.jsContext, ctx.scope, ctx.scope,args);
			output = org.mozilla.javascript.Context.toString(result);
		} catch (WrappedException wrappedEx) {
			logger.warning("Wrapped Exception occurs : "+wrappedEx.getMessage()+"\n"+ wrappedEx.lineSource());
			output = wrappedEx;			
		} catch (EvaluatorException ex) {
			logger.warning("Evaluator Exception occurs : "+ex.getMessage());
			output = ex;
		} catch (Exception ex) {
			logger.warning("Exception occurs : "+ex.getMessage());
			output = ex;
		} catch (Error err){
			logger.warning(err.getMessage());
			output = err;
		} finally {
			this.executionTime = (Long) ctx.jsContext
					.getThreadLocal("executionTime");
			org.mozilla.javascript.Context.exit();
		}
		return output;
	}


	public Double getExecutionTime() {
		return this.executionTime != null ? (this.executionTime / 1000.0) : 0.0;
	}
	/*
	class EnvJsCtx implements Context {
		org.mozilla.javascript.Context context;
		Scriptable scope;
		
		EnvJsCtx() {
			logger.info("Initializing Envjs...");
			String envjsContent = null;
			
			if ( envjsContent == null ) {
				logger.info("Fetching Envjs...");
				String envjsPath = "/javascripts/envjs/env.min.js";
				try {
					byte[] buffer = new byte[(int) new File(envjsPath).length()];
				    FileInputStream f = new FileInputStream(envjsPath);
				    f.read(buffer);
				    envjsContent = new String(buffer);
				} catch (Exception e) {
					logger.warning(e.getMessage());
				}
			}	

			context = org.mozilla.javascript.Context.enter();
			
			logger.info("Set Optimization Level to -1 without 64kb limit");
			context.setOptimizationLevel(-1); 
			
			logger.info("Set JavaScript Version to 1.5");
			context.setLanguageVersion(org.mozilla.javascript.Context.VERSION_1_5);
			
			logger.info("Initialize the standard objects (Object, Function, etc.)");
			GlobalFunctions globalObj = new GlobalFunctions();
			scope = context.initStandardObjects(globalObj);
			
			// TODO : DOM Model 지원
			logger.info("Define some global functions. Note that these functions are not part of ECMA.");
			String[] names = { "print", "read", "readtoken", "readline", "__currentContext__" };
			
			globalObj.defineFunctionProperties(names, GlobalFunctions.class,
					ScriptableObject.DONTENUM);
			
			logger.info("Evaluating Envjs...");
			context.evaluateString(scope, envjsContent, "envJs", 0, null);
			logger.info("Initialized Envjs");
		}
	}*/
	
	static class Ctx implements Context {
		org.mozilla.javascript.Context jsContext;
		Scriptable scope;
		Function testFunction;
		static {
			ContextFactory.initGlobal(new SandboxContextFactory());
		}
		Ctx(Scriptable shared) {
			if ( testScript == null ) {
				logger.info("Fetching Test Scripts...");
				String testScriptPath = "/WEB-INF/lib/_testScript_.js";
				// String testScript = null;
				try {
					byte[] buffer = new byte[(int) new File(testScriptPath).length()];
				    FileInputStream f = new FileInputStream(testScriptPath);
				    f.read(buffer);
				    testScript = new String(buffer);
				} catch (Exception e) {
					logger.warning(e.getMessage());
				}
			}
			logger.info("Entering custom context");
			jsContext = org.mozilla.javascript.Context.enter();
			
			logger.info("Set optimization level to 1(with 64kb limit");
			jsContext.setOptimizationLevel(1);
			
			logger.info("Set JavaScript version to 1.7");
			jsContext.setLanguageVersion(org.mozilla.javascript.Context.VERSION_1_7);
			
			logger.info("Initialize the standard objects (Object, Function, etc.)");
			scope = jsContext.initStandardObjects();
			
			logger.info("Compile test function");
			testFunction = jsContext.compileFunction(scope, testScript, "arg", 0, null);
			
			if (shared != null) {
				scope.setPrototype(shared);
			}
		}
	}

	public Object execute(Context context, String script, String input,
			Long limitedTime, String funcName, String globalScript,
			String markupDocument, String scriptDocumentTest) throws Exception {
		return execute(context,script,input,limitedTime,funcName,globalScript);
	}
}
