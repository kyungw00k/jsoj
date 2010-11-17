package net.jsoj.system.judge;

import java.util.ArrayList;
import java.util.StringTokenizer;

public class Validation {

	final static ArrayList<String> tokenize(String string) {
		ArrayList<String> array = new ArrayList<String>();
		StringTokenizer st = new StringTokenizer(string);
		while (st.hasMoreTokens()) {
			array.add(st.nextToken());
		}
		return array;
	}

	final static String str_rstrip(String string) {
		return str_rstrip(string, null);
	}

	final static String str_rstrip(String string, String sep) {
		char[] chars = string.toCharArray();
		int n = chars.length;
		int end = n - 1;
		if (sep == null) {
			while (end >= 0 && Character.isWhitespace(chars[end])) {
				end--;
			}
		} else {
			while (end >= 0 && sep.indexOf(chars[end]) >= 0) {
				end--;
			}
		}
		return (end < n - 1) ? string.substring(0, end + 1) : string;
	}

	final static String[] removeTrailingSpaces(String exp) {
		String[] lines = str_rstrip(exp).split("\n");
		for (int idx = 0 ; idx < lines.length ; idx++) {
			lines[idx] = str_rstrip(lines[idx]);
		}
		return lines;
	}
	
	public static boolean strict(String string, String expected) {
		return string.equals(expected);
	}
	
	public static boolean ignoreWhiteSpace(String string, String expected) {
		return tokenize(string).equals(tokenize(expected));
	}

	public static boolean ignoreTrailingSpace(String string, String expected) {
		String[] source = removeTrailingSpaces(string);
		String[] target = removeTrailingSpaces(expected);
		
		boolean result = source.length == target.length;
		int idx = source.length-1;
		if ( result ) {
			
			for (  ; idx > -1 && result ; --idx ) {
				result = source[idx].equals(target[idx]);
			}
		}
		return result && idx == -1;
	}
	
	public static boolean ignoreTrailingEmptyLine(String string, String expected) {
		return str_rstrip(string, "\n").equals(str_rstrip(expected,"\n"));
	}
	
	public static boolean computeFloat(String output, String expected ) {
		final double THRESHOLD = 1e-8;
		if ( output.equals(expected) ) { return true; }
		
		double out, exp;
		
		try {
			out = Double.parseDouble(output);
			exp = Double.parseDouble(expected);
		} catch (Exception e) {
			return strict(output,expected) || ignoreTrailingEmptyLine(output,expected) || ignoreTrailingSpace(output,expected);
		}
		return Math.abs(exp-out) <= THRESHOLD*Math.max(Math.abs(out), 1);
	}
	
	public static boolean relativeFloat(String output, String expected) {
		ArrayList<String> outputArray = tokenize(output);
		ArrayList<String> expectedArray = tokenize(expected);
		
		if ( outputArray.size() != expectedArray.size() ) {
			return false;
		}
		
		for ( int idx = 0, len = outputArray.size(); idx < len ; idx++ ) {
			if ( !computeFloat( outputArray.get(idx), expectedArray.get(idx) ) ) {
				return false;
			}
		}
		return true;
	}
}