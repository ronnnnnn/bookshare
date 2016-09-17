package com.ron.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ron.domain.product;
import com.ron.model.Datagrid;
import com.ron.model.Json;
import com.ron.model.PageModel;
import com.ron.service.BookListService;
import com.ron.service.ProductManageService;
@RequestMapping("/admin")
@Controller
public class AdminProductManageController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(AdminProductManageController.class);

	@Resource
	BookListService bookListService;
	
	@Resource
	ProductManageService productManageService;
	
	@RequestMapping("/getProductByCatId")
	public void getProductByCatId(int catId,PageModel page,HttpServletResponse response){
		Datagrid bookList = bookListService.getBookList(catId,page);
		super.writeJson(bookList, response);
	}


	@RequestMapping("/proAdd")
	public void proAdd(String ids,Integer catId,HttpServletResponse response){
		Json json = new Json();
		try {
			logger.info("add");
			String mCatId = String.valueOf(catId);
			productManageService.proInsert(ids,mCatId);
			json.setSuccess(true);
			json.setMsg("添加成功！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());
		}

		super.writeJson(json, response);
	}

	@RequestMapping("/proRemove")
    public void proRemove(String ids,HttpServletResponse response){
		Json json = new Json();
		try {
			logger.info("remove");
            productManageService.proRemove(ids);
			json.setSuccess(true);
			json.setMsg("删除成功！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());
		}

		super.writeJson(json, response);
	}


	@RequestMapping("/proEdit")
	public void proEdit(product product,HttpServletResponse response){
		
		Json json = new Json();
		try {
			logger.info("add");
			productManageService.proEdit(product);
			json.setSuccess(true);
			json.setMsg("修改成功！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());  
		}

		super.writeJson(json, response);
	}
	
	@RequestMapping("/proOnSale")
	public void proOnSale(String ids ,HttpServletResponse response){
		Json json = new Json();
		try {
			logger.info("OnSale");
			productManageService.proToOnSaleEdit(ids);
			json.setSuccess(true);
			json.setMsg("图书已上架！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());  
		}

		super.writeJson(json, response);
	}
	
	@RequestMapping("/proOutSale")
	public void proOutSale(String ids ,HttpServletResponse response){
		Json json = new Json();
		try {
			logger.info("OutSale");
			productManageService.proToOutSaleEdit(ids);
			json.setSuccess(true);
			json.setMsg("图书已下架！");

		} catch (Exception e) {
			json.setMsg(e.getMessage());  
		}

		super.writeJson(json, response);
	}
}
