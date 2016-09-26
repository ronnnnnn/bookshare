package com.ron.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminHomeController extends BaseController {
   @RequestMapping("/toAdminHome")
   public String toAdminHome(){
	   return "admin/index";
   }

   @RequestMapping("/booksheft")
   public String toProductManage(){
   	  return "/admin/productManage/productManage";
   }
   @RequestMapping("/book/all")
   public String toBookManage(){
   	  return "/admin/bookManage/bookManage";
   }

   @RequestMapping("/getTreeList")
   public void getTreeList(HttpServletResponse response){
	   List<Map<String,Object>> maps = new ArrayList<Map<String,Object>>();  
	   List<Map<String,Object>> children = new ArrayList<Map<String,Object>>();
	   
	   Map<String,Object> text = new HashMap<String,Object>();
	   text.put("text", "书架管理");
	   Map<String,String> attributes = new HashMap<String,String>();
	   attributes.put("url", "/admin/productManage/productManage.jsp");
	   text.put("attributes", attributes);
	   children.add(text);
	   
	   Map<String,Object> text1 = new HashMap<String,Object>();
	   text1.put("text", "图书管理");
	   Map<String,String> attributes1 = new HashMap<String,String>();
	   attributes1.put("url", "/admin/bookManage/bookManage.jsp");
	   text1.put("attributes", attributes1);
	   children.add(text1);
	   
	   Map<String,Object> text2 = new HashMap<String,Object>();
	   text2.put("text", "订单管理");
	   Map<String,String> attributes2 = new HashMap<String,String>();
	   attributes2.put("url", "#2");
	   text2.put("attributes", attributes2);
	   children.add(text2);
	   
	   Map<String,Object> map = new HashMap<String,Object>();
	   map.put("text", "首页");
	   map.put("children", children);
	   maps.add(map);
	   super.writeJson(maps, response);
   }
   
   @RequestMapping("/getProduct")
   public void getProduct(){
	   
   }
}
