package com.github.flying.jeelite.common.rest;

import org.springframework.http.HttpStatus;

/**
 * 专用于Restful Service的异常.
 */
public class RestException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	public int status = HttpStatus.INTERNAL_SERVER_ERROR.value();

	public RestException() {
	}

	public RestException(int status) {
		this.status = status;
	}

	public RestException(String message) {
		super(message);
	}

	public RestException(int status, String message) {
		super(message);
		this.status = status;
	}
}