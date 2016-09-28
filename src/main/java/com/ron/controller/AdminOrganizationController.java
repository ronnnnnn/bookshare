package com.ron.controller;

import com.ron.domain.SysOrganization;
import com.ron.service.SysOrganizationService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ron on 16-9-28.
 */
@RequestMapping("/admin")
@Controller
public class AdminOrganizationController extends BaseController {
    @Resource
    SysOrganizationService sysOrganizationService;

    @RequestMapping(value = "/org/all/list",method = RequestMethod.GET)
    public void getAllOrgList(HttpServletResponse response){
        super.writeJson(sysOrganizationService.getAllOrg(), response);
    }

    @RequestMapping(value = "org/many/{value}",method = RequestMethod.GET)
    public void getOrgByIds(@PathVariable String value,HttpServletResponse response){
        String[] ids = value.split(",");
        List<SysOrganization> orgs = new ArrayList<SysOrganization>();
        for(String id : ids){
            Long mid = Long.valueOf(id);
            SysOrganization morg = new SysOrganization();
            morg.setId(mid);
            SysOrganization sysOrganization = sysOrganizationService.getOneById(morg);
            orgs.add(sysOrganization);
        }
        super.writeJson(orgs,response);
    }

}
