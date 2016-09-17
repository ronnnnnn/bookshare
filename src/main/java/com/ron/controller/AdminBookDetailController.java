package com.ron.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ron.domain.BookWithBLOBs;
import com.ron.domain.BookWithBLOBsModel;
import com.ron.model.Json;
import com.ron.service.BookDetailService;
import com.ron.service.impl.BookDetailServiceImpl;

@RequestMapping("/admin")
@Controller
public class AdminBookDetailController extends BaseController{
    
	@Resource
	BookDetailService bookDetailService;
	private static final Logger logger = LoggerFactory.getLogger(AdminBookDetailController.class);
	@RequestMapping("/getBookDetail")
	public void getBookDetail(int Bookid,HttpServletResponse response){
		bookDetailService.getBookDetail(Bookid);
		super.writeJson(bookDetailService.getBookDetail(Bookid),response);
	}
	
	@RequestMapping("/bookDetailEdit")
	public void bookDetailEdit(BookWithBLOBsModel mBloBsModel,HttpServletResponse response){
		
		Json json = new Json();
		try {
			logger.info("add");
			bookDetailService.updataBookWithBLOBsById(mBloBsModel);
			json.setSuccess(true);
			json.setMsg("修改成功！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());  
		}

		super.writeJson(json, response);
	}
	
}
