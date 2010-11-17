package net.jsoj.system.sandbox;

import org.mozilla.javascript.ClassShutter;

public class DenyAllClassShutter implements ClassShutter {
	public boolean visibleToScripts(String className) {
		if (className.startsWith("net.jsoj.system.sandbox.SandboxContextFactory")) {
			return true;
		}
		return false;
	}
}