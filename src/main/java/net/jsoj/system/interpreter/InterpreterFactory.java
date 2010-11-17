package net.jsoj.system.interpreter;

public class InterpreterFactory {
	public Interpreter createInterpreter(InterpreterType type) {
		switch (type) {
		case Core:
			return new CoreInterpreter();
		case DOM:
			return new CoreInterpreter();			
		default:
			throw new RuntimeException(type + " is not yet supported");
		}
	}
}