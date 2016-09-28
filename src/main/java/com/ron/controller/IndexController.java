package com.ron.controller;

import com.ron.domain.SysResource;
import com.ron.domain.SysUser;
import com.ron.service.SysResourceService;
import com.ron.service.SysUserservice;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

/**
 * Created by ron on 16-9-20.
 */
@Controller
public class IndexController {

    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(IndexController.class);

    @Resource
    SysUserservice userservice;
    @Resource
    SysResourceService resourceService;

    @RequestMapping("/")
    public String index(HttpServletRequest request, Model model){
        Set<String> perssions = userservice.findPermissions(((SysUser)request.getAttribute("user")).getUsername());
        List<SysResource> menus = resourceService.findMenus(perssions);
        model.addAttribute("menus",menus);
        return "admin/index";
    }
}
