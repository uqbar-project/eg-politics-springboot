package ar.edu.unsam.politics

import java.lang.RuntimeException

class UserException extends RuntimeException {
	
	new(String message) { super(message) }
}