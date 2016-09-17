package com.ron.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ron.domain.Category;
import com.ron.mapper.CategoryMapper;
import com.ron.model.CategoryItems;
import com.ron.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Resource
	CategoryMapper categoryMapper;
	/**
	 * 获取分类菜单父项及子项
	 */
	@Override
	public List<CategoryItems> getCategory() {
		// TODO Auto-generated method stub
		
		List<CategoryItems> categoryItems = new ArrayList<CategoryItems>();
		List<Category> parentItems = categoryMapper.selectByParentId(1);
		for (int i = 0; i < parentItems.size(); i++) {
			CategoryItems myCategoryItems = new CategoryItems();
			Category parentItem = new Category();
			parentItem = parentItems.get(i);
			String name = parentItem.getName();
			int parentId = parentItem.getId();
			List<Category> subItems = categoryMapper.selectByParentId(parentId);
			myCategoryItems.setParentItem(name);
			myCategoryItems.setParentId(parentId);
			myCategoryItems.setSubItems(subItems);
			categoryItems.add(myCategoryItems);
		}
		return categoryItems;
	}
	@Override
	public List<Category> getParentCat() {
		// TODO Auto-generated method stub
		List<Category> parentItems = categoryMapper.selectByParentId(1);
		return parentItems;
	}
	@Override
	public List<Category> getSubCatByParentId(int id) {
		// TODO Auto-generated method stub
		return categoryMapper.selectByParentId(id);
	}

}
