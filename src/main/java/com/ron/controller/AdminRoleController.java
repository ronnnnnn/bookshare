package com.ron.controller;

import com.ron.domain.SysRole;
import com.ron.service.SysRoleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ron on 16-9-27.
 */
@RequestMapping("/admin")
@Controller
public class AdminRoleController extends BaseController {
    @Resource
    SysRoleService roleService;

    @RequestMapping(value = "/role/{id}",method= RequestMethod.GET)
    public void getRoleById(@PathVariable Integer id, HttpServletResponse response){
        SysRole sysRole = new SysRole();
        sysRole.setId(Long.valueOf(id));
        super.writeJson(roleService.getOneById(sysRole),response);
    }

    @RequestMapping(value = "/role/all/list",method = RequestMethod.GET)
    public void getAllRoleList(HttpServletResponse response){
        super.writeJson(roleService.getAllRoles(),response);
    }

    @RequestMapping(value = "/role/many/{value}",method = RequestMethod.GET)
    public void getRoleByIds(@PathVariable String value,HttpServletResponse response){
        String[] ids = value.split(",");
        List<SysRole> roles = new ArrayList<SysRole>();
        for(String id : ids){
            Long mid = Long.valueOf(id);
            SysRole mRole = new SysRole();
            mRole.setId(mid);
            SysRole sysRole = roleService.getOneById(mRole);
            roles.add(sysRole);
        }
        super.writeJson(roles,response);
    }
}
