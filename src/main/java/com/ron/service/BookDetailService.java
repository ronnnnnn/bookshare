package com.ron.service;

import com.ron.domain.BookWithBLOBs;
import com.ron.domain.BookWithBLOBsModel;
import com.ron.model.Datagrid;

public interface BookDetailService {
    public Datagrid getBookDetail(int id);
    
    public BookWithBLOBs getBookWithBLOBsById(int id);
    
    public void updataBookWithBLOBsById(BookWithBLOBsModel bloBsModel);  
}
