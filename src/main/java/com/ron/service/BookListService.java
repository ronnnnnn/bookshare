package com.ron.service;
import com.ron.model.Datagrid;
import com.ron.model.Page;
import com.ron.model.PageModel;

public interface BookListService {
	
     public Datagrid getBookList(int id, int page);

     public Datagrid getBookNotInCat(int id, PageModel page);

     public Datagrid getBookList(int id, PageModel page);
     
     public Page getBookListSize(int id);
     
}
