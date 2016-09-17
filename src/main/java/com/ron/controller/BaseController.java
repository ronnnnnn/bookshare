package com.ron.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;

public class BaseController {
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(BaseController.class);
	//将json返回页面
	public void writeJson(Object object,HttpServletResponse response) {	
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json);
			response.getWriter().flush();
			response.getWriter().close();
		   } catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	protected String saveUploadFile(HttpServletRequest request,MultipartFile  upload, String uploadpath,String type) {
		if (upload == null)
			return "";
		
		//SimpleDateFormat sdf = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
		String basePath = request.getSession().getServletContext().getRealPath("");
		logger.info("==============" + basePath);
		String subPath = "//productImages//";
		File dir = new File(basePath + subPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String imageName =  UUID.randomUUID().toString() + "."+type;
		String path = basePath + subPath + imageName ;
        File myfile = new File(path);
		try {
			upload.transferTo(myfile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return imageName;
	}
}
