package com.ron.service;

import com.ron.domain.product;
import com.ron.model.Datagrid;
import com.ron.model.PageModel;

public interface BookManageService {
    public Datagrid getAllBook(PageModel pageModel);
    
    public product insertBook(product poProduct);
    
    public void deleteBook(String ids);
    
    public product getBookUniq(Long addtime);
}
