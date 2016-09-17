package com.ron.controller;

import java.io.File;





import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.ron.model.Json;

@RequestMapping("/admin")
@Controller
public class AdminImageController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminImageController.class);
	
	
    @RequestMapping("/importImage")
    public void importImage(MultipartFile file,HttpServletResponse response,HttpServletRequest request){
    	 Json json = new Json();     
        
 		try {
 			String imageName = super.saveUploadFile(request,file, "EMPFILE", "jpg");
 			logger.info(imageName);
 			json.setObj(imageName);
 			json.setSuccess(true);
 			json.setMsg("导入成功！");
 		} catch (Exception e) {
 			json.setMsg(e.toString());
 		}
 		
 	    super.writeJson(json,response);
    }
}
