package net.jsoj.system.sandbox;

import java.util.logging.Logger;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.WrapFactory;

/**
 * @author kyungwook
 * 
 */
public class SandboxWrapFactory extends WrapFactory {
	final static Logger logger = Logger.getLogger(SandboxWrapFactory.class
			.getName());

	@Override
	public Object wrap(Context cx, Scriptable scope, Object obj,
			Class<?> staticType) {
		if (obj instanceof String || obj instanceof Number
				|| obj instanceof Boolean) {
			return obj;
		} else if (obj instanceof Character) {
			char[] a = { ((Character) obj).charValue() };
			return new String(a);
		}
		return super.wrap(cx, scope, obj, staticType);
	}
 
	@SuppressWarnings("rawtypes")
	@Override
	public Scriptable wrapAsJavaObject(Context cx, Scriptable scope,
			Object javaObject, Class staticType) {
		logger.info("Create SandboxNativeJavaObject instance");
		return new SandboxNativeJavaObject(scope, javaObject, staticType);
	}
}
