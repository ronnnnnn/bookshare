package com.ron.service;

import com.ron.domain.SysUser;

import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
public interface SysUserservice extends BaseService<SysUser> {

    public void changePassword(Long userId, String newPassword); //修改密码

    public SysUser findByUsername(String username); //根据用户名查找用户

    public Set<String> findRoles(String username);// 根据用户名查找其角色

    public Set<String> findPermissions(String username);// 根据用户名查找其权限

}
