package com.ron.service.impl;

import com.ron.domain.SysRole;
import com.ron.mapper.SysRoleMapper;
import com.ron.model.Datagrid;
import com.ron.model.PageModel;
import com.ron.service.SysResourceService;
import com.ron.service.SysRoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
@Service
public class SysRoleServiceImpl implements SysRoleService {
    @Resource
    SysRoleMapper sysRoleMapper;
    @Resource
    SysResourceService resourceService;

    @Override
    public Set<String> findRoles(Long... roleIds) {
        Set<String> roles = new HashSet<String>();
        for (Long roleId : roleIds){
            SysRole role = sysRoleMapper.selectByPrimaryKey(roleId);
            if(role != null) {
                roles.add(role.getRole());
            }
        }
        return roles;
    }

    @Override
    public Set<String> findPermissions(Long[] roleIds) {
        Set<Long> permissionIds = new HashSet<Long>();
        for(Long roleId : roleIds){
            SysRole role = sysRoleMapper.selectByPrimaryKey(roleId);
            String[] mpermissionIds = role.getResourceIds().split(",");
            for(String mpermissionId:mpermissionIds){
                permissionIds.add(Long.parseLong(mpermissionId));
            }

        }
        return resourceService.findPermissions(permissionIds);
    }

    @Override
    public Integer save(SysRole sysRole) {
        return null;
    }

    @Override
    public Integer update(SysRole sysRole) {
        return null;
    }

    @Override
    public Datagrid getAll(PageModel pageModel) {
        return null;
    }

    @Override
    public SysRole getOneById(SysRole sysRole) {
        return sysRoleMapper.selectByPrimaryKey(sysRole.getId());
    }

    @Override
    public Integer deleteOneById(SysRole sysRole) {
        return null;
    }

    @Override
    public List<SysRole> getAllRoles() {
        return sysRoleMapper.selectAll();
    }
}
