package com.github.flying.jeelite.common.rest;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.AsyncRequestTimeoutException;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.github.flying.jeelite.common.beanvalidator.BeanValidators;
import com.github.flying.jeelite.common.mapper.JsonMapper;
import com.github.flying.jeelite.common.utils.Exceptions;
import com.github.flying.jeelite.common.utils.StringUtils;

/**
 * 控制层异常统一处理
 */
@ControllerAdvice
public class RestExceptionHandler {

	/**
	 * 授权异常
	 */
	@ExceptionHandler({UnauthorizedException.class, AuthenticationException.class})
	public String unauthorizedException() {
		return "error/403";
	}

	/**
	 * 处理RestException.
	 */
	@ExceptionHandler(RestException.class)
	@ResponseBody
	public final Result handleRestException(RestException ex) {
		return new Result(ex.status, ex.getMessage());
	}

	/**
	 * Validation异常
	 */
	@ExceptionHandler(ConstraintViolationException.class)
	@ResponseBody
	public final Result handleValidationException(ConstraintViolationException ex) {
		List<String> errors = BeanValidators.extractMessage(ex.getConstraintViolations());
		StringBuilder sb = new StringBuilder();
		for (String message : errors){
			sb.append(message).append(errors.size()>1?"<br/>":"");
		}
		return new Result(HttpStatus.BAD_REQUEST.value(), sb.toString());
	}

	/**
	 * standard Spring MVC 异常
	 */
	@ExceptionHandler(value={
			HttpRequestMethodNotSupportedException.class,
			HttpMediaTypeNotSupportedException.class,
			HttpMediaTypeNotAcceptableException.class,
			MissingPathVariableException.class,
			MissingServletRequestParameterException.class,
			ServletRequestBindingException.class,
			ConversionNotSupportedException.class,
			TypeMismatchException.class,
			HttpMessageNotReadableException.class,
			HttpMessageNotWritableException.class,
			MethodArgumentNotValidException.class,
			MissingServletRequestPartException.class,
			BindException.class,
			NoHandlerFoundException.class,
			AsyncRequestTimeoutException.class
	})
	@ResponseBody
	public final Result handleStandardException(Exception ex) {
		HttpStatus status;
		if (ex instanceof HttpRequestMethodNotSupportedException) {
			status = HttpStatus.METHOD_NOT_ALLOWED;
		} else if (ex instanceof HttpMediaTypeNotSupportedException) {
			status = HttpStatus.UNSUPPORTED_MEDIA_TYPE;
		} else if (ex instanceof HttpMediaTypeNotAcceptableException) {
			status = HttpStatus.NOT_ACCEPTABLE;
		} else if (ex instanceof MissingPathVariableException) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
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
		} else if (ex instanceof AsyncRequestTimeoutException) {
			status = HttpStatus.SERVICE_UNAVAILABLE;
		} else {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new Result(status.value(), status.getReasonPhrase());
	}

	/**
	 * 处理其他Exception.
	 */
	@ExceptionHandler(Exception.class)
	public Object handleException(Exception ex, HttpServletRequest request, HttpServletResponse response, HandlerMethod handler) {
		request.setAttribute("exception", ex);
		
		boolean isJsonRequest = false;// 是否返回json数据
		if (handler != null) {
			isJsonRequest = handler.getMethod().isAnnotationPresent(ResponseBody.class) ||
					handler.getBeanType().isAnnotationPresent(RestController.class);
		}
		if (isJsonRequest) {//返回json数据
			try {
				response.reset();
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				response.getWriter().print(JsonMapper.toJsonString(new Result(HttpStatus.INTERNAL_SERVER_ERROR.value(), ex.toString())));
				return null;
			} catch (IOException e) {
				return null;
			}
		} else {//返回错误视图
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			StringBuilder sb = new StringBuilder("错误信息：\n");
			if (ex != null) {
				sb.append(Exceptions.getStackTraceAsString(ex));
			} else {
				sb.append("未知错误.\n\n");
			}
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("error/500");
			mav.addObject("errorMsg", ex == null ? "未知错误" : StringUtils.toHtml(ex.toString()));
			mav.addObject("detailMsg", StringUtils.toHtml(sb.toString()));
			return mav;
		}
	}

}