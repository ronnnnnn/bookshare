package com.ron.service;

import com.ron.domain.product;

public interface ProductManageService {
    public void proEdit(product product);

    public void proInsert(String ids, String catId);

    public void proRemove(String ids);
    
    public void proToOnSaleEdit(String ids);
    
    public void proToOutSaleEdit(String ids);

}
