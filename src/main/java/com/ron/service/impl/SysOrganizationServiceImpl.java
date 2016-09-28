package com.ron.service.impl;

import com.ron.domain.SysOrganization;
import com.ron.mapper.SysOrganizationMapper;
import com.ron.model.Datagrid;
import com.ron.model.PageModel;
import com.ron.service.SysOrganizationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ron on 16-9-28.
 */
@Service
public class SysOrganizationServiceImpl implements SysOrganizationService {

    @Resource
    SysOrganizationMapper sysOrganizationMapper;

    @Override
    public Integer save(SysOrganization sysOrganization) {
        return null;
    }

    @Override
    public List<SysOrganization> getAllOrg() {
        return sysOrganizationMapper.selectAll();
    }

    @Override
    public Integer update(SysOrganization sysOrganization) {
        return null;
    }

    @Override
    public Datagrid getAll(PageModel pageModel) {
        return null;
    }

    @Override
    public SysOrganization getOneById(SysOrganization sysOrganization) {
        return sysOrganizationMapper.selectByPrimaryKey(sysOrganization.getId());
    }

    @Override
    public Integer deleteOneById(SysOrganization sysOrganization) {
        return null;
    }
}
