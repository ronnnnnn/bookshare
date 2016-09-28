package com.ron.service;

import com.ron.domain.SysRole;
import java.util.List;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
public interface SysRoleService extends BaseService<SysRole> {

    Set<String> findRoles(Long... roleIds); //根据角色编号得到角色标识符列表

    Set<String> findPermissions(Long[] roleIds); //根据角色编号得到权限字符串列表

    List<SysRole> getAllRoles();

}
