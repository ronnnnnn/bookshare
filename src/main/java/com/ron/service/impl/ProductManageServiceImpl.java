package com.ron.service.impl;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ron.domain.product;
import com.ron.mapper.productMapper;
import com.ron.service.ProductManageService;

@Service
public class ProductManageServiceImpl implements ProductManageService {


	@Resource
	productMapper productMapper;

	@Resource
	JdbcTemplate jdbcTemplate;

	@Override
	public void proInsert(String ids,String catId) {
		String[] myid  = ids.split(",");
		for (String id : myid) {
            String sql = "INSERT INTO `dang`.`d_category_product` (`product_id`, `cat_id`) VALUES ('"+id+"', '"+catId+"')";
			jdbcTemplate.execute(sql);
		}
	}

	@Override
	public void proRemove(String ids) {
		String[] myid  = ids.split(",");
		for (String id : myid) {
	        String sql = "DELETE FROM dang.d_category_product WHERE product_id="+id;
			jdbcTemplate.execute(sql);
		}
	}

	@Override
	public void proEdit(product product) {
		// TODO Auto-generated method stub
		product myProduct = productMapper.selectByPrimaryKey(product.getId());
	    myProduct.setDangPrice(product.getDangPrice());
	    myProduct.setDescription(product.getDescription());
	    myProduct.setFixedPrice(product.getFixedPrice());
	    myProduct.setHasDeleted(product.getHasDeleted());
	    myProduct.setProductName(product.getProductName());
	    myProduct.setKeywords(product.getKeywords());
	    myProduct.setProductNum(product.getProductNum());
	    myProduct.setProductPic(product.getProductPic());
	    productMapper.updateByPrimaryKeySelective(myProduct);
	}

	@Override
	public void proToOnSaleEdit(String ids) {
		// TODO Auto-generated method stub
		String[] nids = ids.split(",");
		for (String string : nids) {
			int id = Integer.valueOf(string);
			product product = productMapper.selectByPrimaryKey(id);
			product.setHasDeleted(0);
			productMapper.updateByPrimaryKeySelective(product);
		}
		
	}

	@Override
	public void proToOutSaleEdit(String ids) {
		// TODO Auto-generated method stub
		String[] nids = ids.split(",");
		for (String string : nids) {
			int id = Integer.valueOf(string);
			product product = productMapper.selectByPrimaryKey(id);
			product.setHasDeleted(1);
			productMapper.updateByPrimaryKeySelective(product);
		}
	}

}
