package net.jsoj.system.sandbox;

import java.util.logging.Logger;

import org.mozilla.javascript.Callable;
import org.mozilla.javascript.Context;
import org.mozilla.javascript.ContextFactory;
import org.mozilla.javascript.EvaluatorException;
import org.mozilla.javascript.Scriptable;

/**
 * @author kyungwook
 * 
 */
public class SandboxContextFactory extends ContextFactory {
	final static Logger logger = Logger.getLogger(SandboxContextFactory.class
			.getName());

	/**
	 * @author kyungwook
	 * 
	 */

	@SuppressWarnings("deprecation")
	private static class SandboxContext extends Context implements
			net.jsoj.system.interpreter.Context {
		long startTime, endTime;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.mozilla.javascript.ContextFactory#makeContext()
	 */
	@Override
	protected Context makeContext() {
		SandboxContext cx = new SandboxContext();
		cx.setWrapFactory(new SandboxWrapFactory());
		cx.setClassShutter(new DenyAllClassShutter());
		cx.setInstructionObserverThreshold(1000);
		return cx;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.mozilla.javascript.ContextFactory#hasFeature(org.mozilla.javascript
	 * .Context, int)
	 */
	@Override
	protected boolean hasFeature(Context cx, int featureIndex) {
		switch (featureIndex) {
		case Context.FEATURE_NON_ECMA_GET_YEAR:
			return true;
		case Context.FEATURE_MEMBER_EXPR_AS_FUNCTION_NAME:
			return true;
		case Context.FEATURE_RESERVED_KEYWORD_AS_IDENTIFIER:
			return true;
		case Context.FEATURE_PARENT_PROTO_PROPERTIES:
			return false;
		case Context.FEATURE_E4X:
			return true;
		case Context.FEATURE_ENHANCED_JAVA_ACCESS:
			return false;
		}
		return super.hasFeature(cx, featureIndex);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.mozilla.javascript.ContextFactory#observeInstructionCount(org.mozilla
	 * .javascript.Context, int)
	 */
	@Override
	protected void observeInstructionCount(Context cx, int instructionCount) {
		SandboxContext scx = (SandboxContext) cx;
		scx.endTime = System.currentTimeMillis() - scx.startTime;
		Long limitedTime = (Long) (cx.getThreadLocal("limitedTime"));
		if (limitedTime != null && scx.endTime > limitedTime * 1000) {
			try {
				throw new Exception();
			} catch (Exception e) {
				cx.putThreadLocal("executionTime", scx.endTime);
				throw Context.throwAsScriptRuntimeEx(new EvaluatorException(
						"Timeout"));
			}
		}
	}

	@Override
	protected Object doTopCall(Callable callable, Context cx, Scriptable scope,
			Scriptable thisObj, Object[] args) {
		SandboxContext scx = (SandboxContext) cx;
		scx.startTime = System.currentTimeMillis();
		Object retObj = super.doTopCall(callable, cx, scope, thisObj, args);
		scx.endTime = System.currentTimeMillis() - scx.startTime;
		cx.putThreadLocal("executionTime", scx.endTime);
		return retObj;
	}
}
