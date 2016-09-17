package com.ron.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.ron.service.TestService;

@Controller
public class MTestController {

	@Resource
	TestService testservice;
	
	@RequestMapping("/test")
	public String toTest(Model model){
		//User user = testservice.getUserById();
		//model.addAttribute(user);
		return "test";
	}
}
