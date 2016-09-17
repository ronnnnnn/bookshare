package com.ron.mapper;

import com.ron.domain.Book;
import com.ron.domain.BookWithBLOBs;

public interface BookMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BookWithBLOBs record);

    int insertSelective(BookWithBLOBs record);

    BookWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BookWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(BookWithBLOBs record);

    int updateByPrimaryKey(Book record);
    
}