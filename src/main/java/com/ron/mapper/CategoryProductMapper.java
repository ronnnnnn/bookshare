package com.ron.mapper;

import java.util.List;

import com.ron.domain.CategoryProduct;

public interface CategoryProductMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CategoryProduct record);

    int insertSelective(CategoryProduct record);

    CategoryProduct selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CategoryProduct record);

    int updateByPrimaryKey(CategoryProduct record);
    
    List<CategoryProduct> selectByCatIdKey(Integer id);
}