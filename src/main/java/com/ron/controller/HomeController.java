package com.ron.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ron.model.CategoryItems;
import com.ron.model.Datagrid;
import com.ron.model.Page;
import com.ron.service.BookListService;
import com.ron.service.CategoryService;

@Controller
public class HomeController extends BaseController {

	@Resource
	CategoryService categoryService;

	@Resource
	BookListService bookListService;

	@RequestMapping("/toHomePage")
	public String toHomePage(Model model) {
		List<CategoryItems> categoryItems = categoryService.getCategory();
		model.addAttribute("categoryItems", categoryItems);
		return "client/home";
	}

	@RequestMapping("/toHomePage/getBook")
	public void getBook(int id, int page,HttpServletResponse response, Model model) {
		Datagrid datagrid = bookListService.getBookList(id,page);
		super.writeJson(datagrid, response);
	}

	@RequestMapping("/toHomePage/getBookPage")
	public void getBookPage(HttpServletResponse response,int id) {
//		Cookie[] cookies = request.getCookies();
//		int id = 0;
//		if (cookies != null) {
//			for (int i = 0; i < cookies.length; i++) {
//				Cookie cookie = cookies[i];
//				if (cookie.getName().equals("CatId")) {
//					id = Integer.valueOf(cookie.getValue());
//				}
//			}
//		} 

		Page page = bookListService.getBookListSize(id);
		super.writeJson(page, response);
	}
}
