package com.ron.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.ron.service.BookListService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ron.domain.product;
import com.ron.model.Json;
import com.ron.model.PageModel;
import com.ron.service.BookManageService;
@RequestMapping("/admin")
@Controller
public class AdminBookManageController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(AdminBookManageController.class);


	@Resource
	BookManageService bookManageService;

	@Resource
	BookListService bookListService;

	@RequestMapping("/getAllBook")
	public void getAllBook(PageModel page,HttpServletResponse response){	
		super.writeJson((bookManageService.getAllBook(page)),response);
	}

	@RequestMapping("/getOtherBook")
	public void getOtherBook(int catId ,PageModel page ,HttpServletResponse response){
		super.writeJson(bookListService.getBookNotInCat(catId,page),response);
	}
	
	@RequestMapping("/addBook")
	public void addBook(product product,HttpServletResponse response){
		
		Json json = new Json();
		try {
			logger.info("add");
			bookManageService.insertBook(product);
			json.setSuccess(true);
			json.setMsg("添加成功！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());  
		}

		super.writeJson(json, response);
	}
	
	@RequestMapping("/removeBook")
	public void removeBook(String ids,HttpServletResponse response){
		Json json = new Json();
		try {
			logger.info("add");
			bookManageService.deleteBook(ids);
			json.setSuccess(true);
			json.setMsg("删除成功！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());  
		}

		super.writeJson(json, response);
	}
}
