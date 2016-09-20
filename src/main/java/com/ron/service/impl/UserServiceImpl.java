package com.ron.service.impl;

import com.ron.domain.SysRole;
import com.ron.domain.SysUser;
import com.ron.mapper.SysResourceMapper;
import com.ron.mapper.SysRoleMapper;
import com.ron.mapper.SysUserMapper;
import com.ron.service.RoleService;
import com.ron.service.Userservice;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
@Service
public class UserServiceImpl implements Userservice {

    @Resource
    SysUserMapper sysUserMapper;

    @Resource
    SysResourceMapper sysResourceMapper;

    @Resource
    SysRoleMapper sysRoleMapper;

    @Resource
    RoleService roleService;

    @Override
    public void changePassword(Long userId, String newPassword) {

    }

    @Override
    public SysUser findByUsername(String username) {
        return sysUserMapper.selectByUsername(username);
    }

    @Override
    public Set<String> findRoles(String username) {
        SysUser sysUser = findByUsername(username);
        if(sysUser == null){
            return Collections.EMPTY_SET;
        }
        Set<String> roles = new HashSet<String>();
        String[] roleIds = sysUser.getRoleIds().split(",");
        for (String roleId : roleIds){
            SysRole role = sysRoleMapper.selectByPrimaryKey(Long.parseLong(roleId));
            roles.add(role.getRole());
        }
        return roles;
    }

    @Override
    public Set<String> findPermissions(String username) {
        SysUser sysUser = findByUsername(username);
        String[] roleIds = sysUser.getRoleIds().split(",");
        Long mroleids[] = new Long[]{};
        for (int i = 0; i < roleIds.length ; i++) {
            mroleids[i] = Long.parseLong(roleIds[i]);
        }
        return roleService.findPermissions(mroleids);
    }
}
