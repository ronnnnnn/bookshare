package com.ron.controller;

import com.ron.domain.SysUser;
import com.ron.model.PageModel;
import com.ron.service.SysUserservice;
import com.ron.service.impl.PasswordHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by ron on 16-9-27.
 */
@RequestMapping("/admin")
@Controller
public class AdminUserController extends BaseController {
    @Resource
    SysUserservice userservice;

    @Resource
    PasswordHelper passwordHelper;

    @RequestMapping("/user/panel")
    public String toUserManage(){
        return "admin/userManage/userManage";
    }
    @RequestMapping("/user/editpanel")
    public String toUserEdit(){
        return "admin/userManage/userManageEdit";
    }
    @RequestMapping("/user/all")
    public void getAllUser(PageModel pageModel, HttpServletResponse response){
        super.writeJson(userservice.getAll(pageModel),response);
    }
    @RequestMapping(value = "/user/register",method = RequestMethod.POST)
    @ResponseBody
    public Object registerUser(@RequestBody SysUser user, HttpServletResponse response){
        SysUser safeUser = userservice.getOneById(user);
        if(safeUser != null){
            return false;
        } else {
            passwordHelper.encryptPassword(user);
            Integer sava = userservice.save(user);
            if(sava > 1){
                return true;
            }
            return user;
        }
    }
}
