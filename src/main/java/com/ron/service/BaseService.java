package com.ron.service;

import com.ron.model.Datagrid;
import com.ron.model.Page;
import com.ron.model.PageModel;

import java.util.List;

/**
 * Created by ron on 16-9-26.
 */
public interface BaseService<T> {

        public Integer save(T t);

        public Integer update(T t);

        public Datagrid getAll(PageModel pageModel);

        public T getOneById(T t);

        public Integer deleteOneById(T t);
}
