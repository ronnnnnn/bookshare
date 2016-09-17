package com.ron.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import com.ron.domain.BookWithBLOBs;
import com.ron.domain.product;
import com.ron.mapper.BookMapper;
import com.ron.mapper.productMapper;
import com.ron.model.Datagrid;
import com.ron.model.PageModel;
import com.ron.service.BookManageService;

@Service
public class BookManageServiceImpl implements BookManageService {

	@Resource
	productMapper productMapper;
	@Resource
	BookMapper bookMapper;
    @Resource
	JdbcTemplate jdbcTemplate;

	@Override
	public Datagrid getAllBook(PageModel page) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page.getPage(), page.getRows());
		List<product> bookList = productMapper.selectAll();
		PageInfo pages = new PageInfo(bookList);
		Datagrid datagrid = new Datagrid();
		datagrid.setRows(bookList);
		datagrid.setTotal(pages.getTotal());
		return datagrid;
	}

	@Override
	public product insertBook(product poProduct) {
		// TODO Auto-generated method stub
		product myProduct = new product();
		Long addtime = System.currentTimeMillis();
		myProduct.setAddTime(addtime);
		myProduct.setDangPrice(poProduct.getDangPrice());
		myProduct.setDescription(poProduct.getDescription());
		myProduct.setFixedPrice(poProduct.getFixedPrice());
		myProduct.setHasDeleted(1);
		myProduct.setKeywords(poProduct.getKeywords());
		myProduct.setProductName(poProduct.getProductName());
		myProduct.setProductNum(poProduct.getProductNum());
		myProduct.setProductPic(poProduct.getProductPic());
		productMapper.insert(myProduct);
		
		product product = productMapper.selectByAddtime(addtime);
		BookWithBLOBs myBook = new BookWithBLOBs();
		myBook.setId(product.getId());
		myBook.setAuthor("author");
		myBook.setAuthorSummary("null");
		myBook.setCatalogue("null");
		myBook.setIsbn("null");
		myBook.setPrintNumber("null");
		myBook.setIsbn("null");
		myBook.setPrintTime(1L);
		myBook.setPublishTime(1L);
		bookMapper.insert(myBook);
		return null;
	}

	@Override
	public void deleteBook(String ids) {
		// TODO Auto-generated method stub
		String[] nids = ids.split(",");
		for (String string : nids) {
			int id = Integer.valueOf(string);

//			String sql = "SELECT product_id as productId FROM dang.d_category_product dcp  WHERE dcp.product_id=?";
//            List list = jdbcTemplate.queryForList(sql,id);
//			for (int i = 0; i <list.size() ; i++) {
//				String id2 = list.get(i).toString();
				String sql = "DELETE FROM dang.d_category_product WHERE product_id="+id;
				jdbcTemplate.execute(sql);
//			}

			productMapper.deleteByPrimaryKey(id);
			bookMapper.deleteByPrimaryKey(id);
		}
	}

	@Override
	public product getBookUniq(Long addtime) {
		// TODO Auto-generated method stub
		return productMapper.selectByAddtime(addtime);
	}

}