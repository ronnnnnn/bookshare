package com.ron.controller;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ron.domain.Category;
import com.ron.service.CategoryService;

@RequestMapping("/admin")
@Controller
public class AdminCategoryController extends BaseController {

	@Resource
	CategoryService categoryService;
	
	@RequestMapping("/getParentCatJson")
	public void getParentCatJson(HttpServletResponse response){
		List<Category> parentCate = categoryService.getParentCat();
		super.writeJson(parentCate, response);
	}
	
	@RequestMapping("/getSubCatJson")
	public void getSubCatJson(Integer parentId,HttpServletResponse response){
		int id = parentId;
		List<Category> subCate = categoryService.getSubCatByParentId(id);
		super.writeJson(subCate, response);
	}
}
