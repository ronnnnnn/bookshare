package com.ron.mapper;

import java.util.List;

import com.ron.domain.product;

public interface productMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(product record);

    int insertSelective(product record);

    product selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(product record);

    int updateByPrimaryKey(product record);
    
    List<product> selectAll();
    
    product  selectByAddtime(Long addtime);
}