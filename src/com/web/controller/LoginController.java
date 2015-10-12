package com.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.web.entity.QuestionItem;
import com.web.utils.ServiceWrapper;

@Controller
public class LoginController {
	
	@Autowired
	private ServiceWrapper serviceWrapper;
	
	@RequestMapping(value = "/frontend/home", method = RequestMethod.GET)
	public ModelAndView frontendHomePage() {

		ModelAndView model = new ModelAndView();
		model.setViewName("/frontend/home");
		return model;

	}
	
	@RequestMapping(value = "/frontend/firstlogin", method = RequestMethod.GET)
	public ModelAndView frontendFirstLogin(HttpServletRequest request) {
		List<QuestionItem> listData = serviceWrapper.getQuestions(5);
		request.getSession(true).setAttribute("firstLoginListQuestion", listData);
		return new ModelAndView("/frontend/firstlogin", "listData", listData);

	}
	
	@RequestMapping(value = {"/frontend/firstlogin"}, method = RequestMethod.POST)
	@SuppressWarnings("unchecked")
	public ModelAndView frontendFirstLoginPost(HttpServletRequest request) throws IOException {
		List<QuestionItem> listData = (List<QuestionItem>)request.getSession(true).getAttribute("firstLoginListQuestion");
		request.getSession(true).removeAttribute("firstLoginListQuestion");
		for (QuestionItem questionItem : listData) {
			questionItem.setAnswer((String)request.getParameter("name" + questionItem.getId()));
		}
		serviceWrapper.saveFirstAnswer(request.getUserPrincipal().getName(), listData);
		return new ModelAndView("/frontend/home");
	}
	
	@RequestMapping(value = "/frontend/notfirstlogin", method = RequestMethod.GET)
	public ModelAndView frontendNotFirstLogin(HttpServletRequest request,
			@RequestParam(value = "error", required = false) String error) {
		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", error);
		}
		List<QuestionItem> listData = serviceWrapper.getQuestions(1);
		request.getSession(true).setAttribute("notFirstLoginListQuestion", listData);
		model.addObject("listData", listData);
		model.setViewName("/frontend/notfirstlogin");
		return model;
	}
	
	@RequestMapping(value = {"/frontend/notfirstlogin"}, method = RequestMethod.POST)
	@SuppressWarnings("unchecked")
	public ModelAndView frontendNotFirstLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "error", required = false) String error) throws IOException {
		ModelAndView model = new ModelAndView();
		List<QuestionItem> listData = (List<QuestionItem>)request.getSession(true).getAttribute("notFirstLoginListQuestion");
		request.getSession(true).removeAttribute("notFirstLoginListQuestion");
		for (QuestionItem questionItem : listData) {
			questionItem.setAnswer((String)request.getParameter("name" + questionItem.getId()));
		}
		boolean result = serviceWrapper.saveNotFirstAnswer(request.getUserPrincipal().getName(), listData);
		if(result){
			response.sendRedirect(request.getContextPath() + "/frontend/home"); 
		}else{
			model.addObject("error", "Incorrect answer. Please try again");
			model.addObject("listData", listData);
			request.getSession(true).setAttribute("notFirstLoginListQuestion", listData);
			model.setViewName("/frontend/notfirstlogin");
		}
		return model;
	}
	
	@RequestMapping(value = "/admin/home", method = RequestMethod.GET)
	public ModelAndView adminHomePage() {

		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/home");
		return model;

	}
	
	@RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");

		return model;

	}

}