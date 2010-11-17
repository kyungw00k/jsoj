package net.jsoj.system.sandbox;

import org.mozilla.javascript.NativeJavaObject;
import org.mozilla.javascript.Scriptable;

/**
 * @author kyungwook
 *
 */
@SuppressWarnings("serial")
public class SandboxNativeJavaObject extends NativeJavaObject {

	/**
	 * @param scope
	 * @param javaObject
	 * @param staticType
	 */
	@SuppressWarnings("rawtypes")
	public SandboxNativeJavaObject(Scriptable scope, Object javaObject, Class staticType) {
		super(scope, javaObject, staticType);
	}
 
	/* (non-Javadoc)
	 * @see org.mozilla.javascript.NativeJavaObject#get(java.lang.String, org.mozilla.javascript.Scriptable)
	 */
	@Override
	public Object get(String name, Scriptable start) {
		if (name.equals("getClass")) {
			return NOT_FOUND;
		}
		return super.get(name, start);
	}
}
