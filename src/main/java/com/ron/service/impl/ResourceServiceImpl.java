package com.ron.service.impl;

import com.ron.domain.SysResource;
import com.ron.mapper.SysResourceMapper;
import com.ron.service.ResourceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
        return null;
    }
}
