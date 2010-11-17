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
public class GlobalFunctions extends ScriptableObject {
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
	
	public static void print(org.mozilla.javascript.Context cx,
			Scriptable thisObj, Object[] args, Function funObj) {
		for (int i = 0; i < args.length; i++) {
			// Convert the arbitrary JavaScript value into a string form.
			String s = org.mozilla.javascript.Context.toString(args[i]);
			out.write(s);
		}
	}

	public static org.mozilla.javascript.Context __currentContext__(org.mozilla.javascript.Context cx,
			Scriptable thisObj, Object[] args, Function funObj) {
		return cx;
	}

//	private static void println(org.mozilla.javascript.Context cx,
//			Scriptable thisObj, Object[] args, Function funObj) {
//		print(cx, thisObj, args, funObj);
//		out.write('\n');
//	}

//	public static Object read(org.mozilla.javascript.Context cx,
//			Scriptable thisObj, Object[] args, Function funObj) throws IOException {
//		if ( in == null ) {
//			return -1;
//		}
//		int retVal = in.read();
//		if ( retVal == -1 ) {
//			in = null;
//			return -1;
//		}
//		return new Character((char)retVal).toString();
//	}

//	public static Object readline(org.mozilla.javascript.Context cx,
//			Scriptable thisObj, Object[] args, Function funObj) throws IOException {
//		Object retVal = null;
//		
//		if ( tok.hasMoreTokens() ) {
//			retVal = tok.nextToken("\n ");
//		}
//		
//		return retVal;
//	}
//	
//	public static Object readtoken(org.mozilla.javascript.Context cx,
//			Scriptable thisObj, Object[] args, Function funObj) throws IOException {
//		Object retVal = null;
//		
//		if ( tok.hasMoreTokens() ) {
//			retVal = args.length >= 1 ? tok.nextToken(org.mozilla.javascript.Context.toString(args[0])) : tok.nextToken();  
//		}
//		return retVal;
//	}
	

	@Override
	public String getClassName() {
		return "[object console]";
	}
}
