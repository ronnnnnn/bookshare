package com.ron.service.impl;

import com.ron.domain.SysRole;
import com.ron.mapper.SysResourceMapper;
import com.ron.mapper.SysRoleMapper;
import com.ron.service.ResourceService;
import com.ron.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Resource
    SysRoleMapper sysRoleMapper;
    @Resource
    ResourceService resourceService;

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
}
