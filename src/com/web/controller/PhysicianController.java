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

import com.web.entity.PhysicianItem;
import com.web.utils.ServiceWrapper;

@Controller
public class PhysicianController {
	
	@Autowired
	private ServiceWrapper serviceWrapper;

	@RequestMapping(value = "/admin/physician", method = {RequestMethod.GET})
	public ModelAndView mainPage(@RequestParam(value = "id", required = false) Long id) {
		ModelAndView model = new ModelAndView();
		if(id != null){
			serviceWrapper.deletePhysicianById(id);
		}
		List<PhysicianItem> listData = serviceWrapper.getPhysicians();
		model.addObject("listData", listData);
		model.setViewName("/admin/physician");
		return model;
	}
	
	@RequestMapping(value = {"/admin/physician_add"}, method = RequestMethod.GET)
	public ModelAndView addPhysicianRequest(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "id", required = false) Long id) {
		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", error);
		}
		//when ID not null -> modify physician
		if(id != null){
			PhysicianItem item = serviceWrapper.getPhysicianById(id);
			model.addObject("id", item.getId());
			model.addObject("firstname", item.getFirstname());
			model.addObject("lastname", item.getLastname());
			model.addObject("address", item.getAddress());
			model.addObject("phone", item.getPhone());
			model.addObject("email", item.getEmail());
			model.addObject("specId", item.getSpecId());
			model.addObject("deptId", item.getDeptId());
			model.addObject("username", item.getUsername());
			model.addObject("password", item.getPassword());
		}
		model.setViewName("/admin/physician_add");
		return model;
	}
	
	@RequestMapping(value = {"/admin/physician_add"}, method = RequestMethod.POST)
	public ModelAndView addPhysicianAction(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "id", required = false) Long id,
			@RequestParam(value = "firstname", required = false) String firstname,
			@RequestParam(value = "lastname", required = false) String lastname,
			@RequestParam(value = "address", required = false) String address,
			@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "specId", required = false) Long specId,
			@RequestParam(value = "deptId", required = false) Long deptId,
			@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "password", required = false) String password,
			HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		ModelAndView model = new ModelAndView();
		error = serviceWrapper.addPhysician(id, firstname, lastname, address, phone, email, specId, deptId,
				username, password);
		
		if(error == null ){
			response.sendRedirect(request.getContextPath() + "/admin/physician"); 
		}else{
			model.addObject("error", error);
			model.addObject("id", id);
			model.addObject("firstname", firstname);
			model.addObject("lastname", lastname);
			model.addObject("address", address);
			model.addObject("phone", phone);
			model.addObject("email", email);
			model.addObject("specId", specId);
			model.addObject("deptId", deptId);
			model.addObject("username", username);
			model.addObject("password", password);
			model.setViewName("/admin/physician_add");
		}
		return model;
	}
	
}