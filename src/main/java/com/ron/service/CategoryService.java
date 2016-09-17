package com.ron.service;

import java.util.List;

import com.ron.domain.Category;
import com.ron.model.CategoryItems;

public interface CategoryService {
	public List<CategoryItems> getCategory();
	
	public List<Category> getParentCat();
	
	public List<Category> getSubCatByParentId(int id);
}
