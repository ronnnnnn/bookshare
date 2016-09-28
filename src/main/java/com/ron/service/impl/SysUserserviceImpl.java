package com.ron.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ron.domain.SysRole;
import com.ron.domain.SysUser;
import com.ron.mapper.SysResourceMapper;
import com.ron.mapper.SysRoleMapper;
import com.ron.mapper.SysUserMapper;
import com.ron.model.Datagrid;
import com.ron.model.PageModel;
import com.ron.service.SysRoleService;

import com.ron.service.SysUserservice;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
@Service
public class SysUserserviceImpl implements SysUserservice {

    @Resource
    SysUserMapper sysUserMapper;

    @Resource
    SysResourceMapper sysResourceMapper;

    @Resource
    SysRoleMapper sysRoleMapper;

    @Resource
    SysRoleService roleService;

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
        Long mroleids[] = new Long[roleIds.length];
        for (int i = 0; i < roleIds.length ; i++) {
            mroleids[i] = Long.parseLong(roleIds[i]);
        }
        return roleService.findPermissions(mroleids);
    }

    @Override
    public Integer save(SysUser sysUser) {
        return sysUserMapper.insert(sysUser);
    }

    @Override
    public Integer update(SysUser sysUser) {
        return sysUserMapper.insert(sysUser);
    }

    @Override
    public Datagrid getAll(PageModel pageModel){
        PageHelper.startPage(pageModel.getPage(),pageModel.getRows());
        List<SysUser> users = sysUserMapper.selectAll();
        PageInfo pageInfo = new PageInfo(users);
        Datagrid datagrid = new Datagrid();
        datagrid.setRows(users);
        datagrid.setTotal(pageInfo.getTotal());
        return datagrid;
    }

    @Override
    public SysUser getOneById(SysUser sysUser) {
        return sysUserMapper.selectByPrimaryKey(sysUser.getId());
    }

    @Override
    public Integer deleteOneById(SysUser sysUser) {
        return sysUserMapper.deleteByPrimaryKey(sysUser.getId());
    }
}
