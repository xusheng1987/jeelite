package com.thinkgem.jeesite.common.rest;

import java.util.Map;

import org.apache.shiro.authc.AuthenticationException;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;

import com.google.common.collect.Maps;

/**
 * 控制层异常统一处理
 */
@ControllerAdvice
public class RestExceptionHandler {

	/**
	 * 授权登录异常
	 */
	@ExceptionHandler({ AuthenticationException.class })
	public String authenticationException() {
		return "error/403";
	}

	/**
	 * 处理RestException.
	 */
	@ExceptionHandler(RestException.class)
	public final ResponseEntity<?> handleException(RestException ex) {
		Map map = Maps.newHashMap();
		map.put("code", ex.status.value());
		map.put("msg", ex.getMessage());
		return ResponseEntity.ok(map);
	}

	/**
	 * standard Spring MVC 异常
	 */
	@ExceptionHandler(value={
			NoSuchRequestHandlingMethodException.class,
			HttpRequestMethodNotSupportedException.class,
			HttpMediaTypeNotSupportedException.class,
			HttpMediaTypeNotAcceptableException.class,
			MissingServletRequestParameterException.class,
			ServletRequestBindingException.class,
			ConversionNotSupportedException.class,
			TypeMismatchException.class,
			HttpMessageNotReadableException.class,
			HttpMessageNotWritableException.class,
			MethodArgumentNotValidException.class,
			MissingServletRequestPartException.class,
			BindException.class,
			NoHandlerFoundException.class
	})
	public final ResponseEntity<?> handleException(Exception ex) {
		HttpStatus status;
		if (ex instanceof NoSuchRequestHandlingMethodException) {
			status = HttpStatus.NOT_FOUND;
		} else if (ex instanceof HttpRequestMethodNotSupportedException) {
			status = HttpStatus.METHOD_NOT_ALLOWED;
		} else if (ex instanceof HttpMediaTypeNotSupportedException) {
			status = HttpStatus.UNSUPPORTED_MEDIA_TYPE;
		} else if (ex instanceof HttpMediaTypeNotAcceptableException) {
			status = HttpStatus.NOT_ACCEPTABLE;
		} else if (ex instanceof MissingServletRequestParameterException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof ServletRequestBindingException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof ConversionNotSupportedException) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		} else if (ex instanceof TypeMismatchException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof HttpMessageNotReadableException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof HttpMessageNotWritableException) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		} else if (ex instanceof MethodArgumentNotValidException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof MissingServletRequestPartException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof BindException) {
			status = HttpStatus.BAD_REQUEST;
		} else if (ex instanceof NoHandlerFoundException) {
			status = HttpStatus.NOT_FOUND;
		} else {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		Map map = Maps.newHashMap();
		map.put("code", status.value());
		map.put("msg", status.getReasonPhrase());
		return ResponseEntity.ok(map);
	}
}