package com.ron.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ron.domain.CategoryProduct;
import com.ron.domain.product;
import com.ron.mapper.CategoryProductMapper;
import com.ron.mapper.productMapper;
import com.ron.model.Datagrid;
import com.ron.model.Page;
import com.ron.model.PageModel;
import com.ron.service.BookListService;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class BookListServiceImpl implements BookListService {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(BookListServiceImpl.class);

	@Resource
	CategoryProductMapper categoryProductMapper;
	@Resource
	productMapper productMapper;
	@Resource
	JdbcTemplate jdbcTemplate;
	
	@Override
	public Datagrid getBookList(int id,int page) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, 6);
		List<CategoryProduct> proList = categoryProductMapper.selectByCatIdKey(id);
		PageInfo pages = new PageInfo(proList);
		List<product> productList = new ArrayList<product>();
		for (int i = 0; i < proList.size(); i++) {
			product product = new product();
			int productId = proList.get(i).getProductId();
			product = productMapper.selectByPrimaryKey(productId);
			productList.add(product);
		}
		Datagrid datagrid = new Datagrid();
		datagrid.setRows(productList);
		long totalPage = pages.getPages();
		datagrid.setTotal(totalPage);
		return datagrid;
	}

	@Override
	public Datagrid getBookNotInCat(int id, PageModel page) {
		String sql = "SELECT P.id FROM dang.d_product  P WHERE  P.id not in(\n" +
				     "SELECT product_id FROM dang.d_category_product CP where CP.cat_id = ?)";
		List<Integer> productId = jdbcTemplate.queryForList(sql,Integer.class,id);
		List<product> mList = new ArrayList<product>();
		for (int i = 0; i < productId.size(); i++) {
			product mproduct = new product();
			int mid = productId.get(i);
			logger.info(mid+"");
			mproduct = productMapper.selectByPrimaryKey(mid);
			mList.add(mproduct);

		}

		Datagrid datagrid = new Datagrid();
		datagrid.setRows(mList);
		Long size =new Long(mList.size());
		datagrid.setTotal(size);
		return datagrid;
	}

	@Override
	public Page getBookListSize(int id) {
		// TODO Auto-generated method stub
		List<CategoryProduct> proList = categoryProductMapper.selectByCatIdKey(id);
		List<product> productList = new ArrayList<product>();
		for (int i = 0; i < proList.size(); i++) {
			product product = new product();
			int productId = proList.get(i).getProductId();
			product = productMapper.selectByPrimaryKey(productId);
			productList.add(product);
		}
		
		Page page = new Page();
		page.setPages(productList.size());
		return page;
	}

	@Override
	public Datagrid getBookList(int id,PageModel page) {
		
		PageHelper.startPage(page.getPage(), page.getRows());
		List<CategoryProduct> proList = categoryProductMapper.selectByCatIdKey(id);
		PageInfo pages = new PageInfo(proList);
		List<product> productList = new ArrayList<product>();
		for (int i = 0; i < proList.size(); i++) {
			product product = new product();
			int productId = proList.get(i).getProductId();
			product = productMapper.selectByPrimaryKey(productId);
			productList.add(product);
		}
		Datagrid datagrid = new Datagrid();
		datagrid.setRows(productList);
		
		datagrid.setTotal(pages.getTotal());
		return datagrid;
	}

}
