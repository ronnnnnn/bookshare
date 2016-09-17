package com.ron.model;

import java.util.List;

import com.ron.domain.Category;

public class CategoryItems {
	private String parentItem;
	private int parentId;
	private List<Category> subItems;
	public String getParentItem() {
		return parentItem;
	}
	public void setParentItem(String parentItem) {
		this.parentItem = parentItem;
	}
	public List<Category> getSubItems() {
		return subItems;
	}
	public void setSubItems(List<Category> subItems) {
		this.subItems = subItems;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
}
