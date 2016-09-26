package com.ron.service.impl;

import com.ron.domain.SysResource;
import com.ron.mapper.SysResourceMapper;
import com.ron.service.ResourceService;
import org.apache.shiro.authz.permission.WildcardPermission;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by ron on 16-9-19.
 */
@Service
public class ResourceServiceImpl implements ResourceService {
    @Resource
    SysResourceMapper sysResourceMapper;
    @Override
    public Set<String> findPermissions(Set<Long> resourceIds) {
        Set<String> permissions = new HashSet<String>();
        for(Long resourceId : resourceIds){
            SysResource sysResource = sysResourceMapper.selectByPrimaryKey(resourceId);
            if(sysResource != null){
                permissions.add(sysResource.getPermission());
            }
        }
        return permissions;
    }

    @Override
    public List<SysResource> findMenus(Set<String> permissions) {
        List<SysResource> allResources = sysResourceMapper.selectAll();
        List<SysResource> menus = new ArrayList<SysResource>();
        for (SysResource resource : allResources){
            if(resource.isRootNode()){
                continue;
            }

            String str2 = "menu";
            if(resource.getType().intern() != str2) {
                continue;
            }
            if(!hasPermission(permissions, resource)) {
                continue;
            }
            menus.add(resource);
        }
        return menus;
    }

    private boolean hasPermission(Set<String> permissions, SysResource resource) {
        if(StringUtils.isEmpty(resource.getPermission())) {
            return true;
        }
        for(String permission : permissions) {
            WildcardPermission p1 = new WildcardPermission(permission);
            WildcardPermission p2 = new WildcardPermission(resource.getPermission());
            if(p1.implies(p2) || p2.implies(p1)) {
                return true;
            }
        }
        return false;
    }
}
