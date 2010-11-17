package net.jsoj.system.sandbox;

import java.io.StringReader;
import java.io.StringWriter;
import java.util.StringTokenizer;

import org.mozilla.javascript.Function;
import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.ScriptableObject;

/**
 * @author kyungwook
 *
 */
public class Console extends ScriptableObject {
	private static final long serialVersionUID = -461900745944980376L;
	public static StringReader in;
	public static StringWriter out = new StringWriter();
	public static StringTokenizer tok;

	public static void initIO(String src) {
		out.getBuffer().setLength(0);
		in = null; tok = null;
		if ( src != null ) {
			src = src.replaceAll("\r\n", "\n");
			in = new StringReader(src);
			out.getBuffer().setLength(0);
			tok = new StringTokenizer(src);
		}
	}
	/**
	 * Print the string values of its arguments.
	 * 
	 * This method is defined as a JavaScript function. Note that its arguments
	 * are of the "varargs" form, which allows it to handle an arbitrary number
	 * of arguments supplied to the JavaScript function.
	 * @param cx
	 * @param thisObj
	 * @param args
	 * @param funObj
	 */
	public static void log(org.mozilla.javascript.Context cx,
			Scriptable thisObj, Object[] args, Function funObj) {
		for (int i = 0; i < args.length; i++) {
			// Convert the arbitrary JavaScript value into a string form.
			String s = org.mozilla.javascript.Context.toString(args[i]);
			out.write(s);
		}
	}
	
	@Override
	public String getClassName() {
		return "[object console]";
	}
}
