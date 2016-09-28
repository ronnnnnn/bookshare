package com.ron.service;

import com.ron.domain.SysResource;

import java.util.List;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
public interface SysResourceService {

    Set<String> findPermissions(Set<Long> resourceIds); //得到资源对应的权限字符串

    List<SysResource> findMenus(Set<String> permissions); //根据用户权限得到菜单

}
