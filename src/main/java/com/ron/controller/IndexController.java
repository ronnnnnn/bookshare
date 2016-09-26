package com.ron.controller;

import com.ron.domain.SysResource;
import com.ron.domain.SysUser;
import com.ron.domain.User;
import com.ron.service.ResourceService;
import com.ron.service.Userservice;
import org.apache.log4j.spi.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

/**
 * Created by ron on 16-9-20.
 */
@Controller
public class IndexController {

    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(IndexController.class);

    @Resource
    Userservice userservice;
    @Resource
    ResourceService resourceService;

    @RequestMapping("/")
    public String index(HttpServletRequest request, Model model){
        Set<String> perssions = userservice.findPermissions(((SysUser)request.getAttribute("user")).getUsername());
        List<SysResource> menus = resourceService.findMenus(perssions);
        model.addAttribute("menus",menus);
        return "admin/index";
    }
}
