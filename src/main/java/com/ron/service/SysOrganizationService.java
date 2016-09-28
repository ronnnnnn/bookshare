package com.ron.service;

import com.ron.domain.SysOrganization;

import java.util.List;

/**
 * Created by ron on 16-9-28.
 */
public interface SysOrganizationService extends BaseService<SysOrganization> {
    public List<SysOrganization> getAllOrg();
}
