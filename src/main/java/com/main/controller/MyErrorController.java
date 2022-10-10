package com.main.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyErrorController implements ErrorController {

	@GetMapping("/error")
	public String handleError(HttpServletRequest request) {
		String errorPage = "error"; // default

		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

		if (status != null) {
			Integer statusCode = Integer.valueOf(status.toString());

			if (statusCode == HttpStatus.NOT_FOUND.value()) {
				// handle HTTP 404 Not Found error
				errorPage = "error";

			} else if (statusCode == HttpStatus.FORBIDDEN.value()) {
				// handle HTTP 403 Forbidden error
				errorPage = "error";

			} else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				// handle HTTP 500 Internal Server error
				errorPage = "error";

			}
		}

		return errorPage;
	}

	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return "error";
	}

}
