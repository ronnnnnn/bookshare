package com.ron.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ron.controller.AdminBookManageController;
import com.ron.domain.BookWithBLOBs;
import com.ron.domain.BookWithBLOBsModel;
import com.ron.mapper.BookMapper;
import com.ron.model.Datagrid;

import com.ron.service.BookDetailService;

@Service
public class BookDetailServiceImpl implements BookDetailService {

	@Resource
	BookMapper bookMapper;
	private static final Logger logger = LoggerFactory.getLogger(BookDetailServiceImpl.class);
	@Override
	public Datagrid getBookDetail(int id) {
		// TODO Auto-generated method stub
		Datagrid mDatagrid = new Datagrid();
		List<BookWithBLOBsModel> mList = new ArrayList<BookWithBLOBsModel>();
        BookWithBLOBs mBookWithBLOBs = bookMapper.selectByPrimaryKey(id);
        BookWithBLOBsModel myBloBs = new BookWithBLOBsModel();
        myBloBs.setAuthor(mBookWithBLOBs.getAuthor());
        myBloBs.setId(mBookWithBLOBs.getId());
        myBloBs.setPublishing(mBookWithBLOBs.getPublishing());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date1 = sdf.format(new Date(mBookWithBLOBs.getPublishTime()));
        myBloBs.setPublishTime(date1);
        myBloBs.setWordNumber(mBookWithBLOBs.getWordNumber());
        myBloBs.setWhichEdtion(mBookWithBLOBs.getWhichEdtion());
        myBloBs.setTotalPage(mBookWithBLOBs.getTotalPage());
        String date2 = sdf.format(new Date(mBookWithBLOBs.getPrintTime()));
        myBloBs.setPrintTime(date2);
        myBloBs.setIsbn(mBookWithBLOBs.getIsbn());
        myBloBs.setAuthorSummary(mBookWithBLOBs.getAuthorSummary());
        myBloBs.setCatalogue(mBookWithBLOBs.getCatalogue());
        myBloBs.setPrintNumber(mBookWithBLOBs.getPrintNumber());
		mList.add(myBloBs);
		mDatagrid.setRows(mList);
		mDatagrid.setTotal(1L);
		return mDatagrid;
	}

	@Override
	public BookWithBLOBs getBookWithBLOBsById(int id) {
		// TODO Auto-generated method stub
		return bookMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updataBookWithBLOBsById(BookWithBLOBsModel bloBsModel) {
		// TODO Auto-generated method stub
	    BookWithBLOBs bookWithBLOBs = bookMapper.selectByPrimaryKey(bloBsModel.getId());
	    bookWithBLOBs.setAuthor(bloBsModel.getAuthor());
        bookWithBLOBs.setPublishing(bloBsModel.getPublishing());
        SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
		try {
			date = simpleDateFormat.parse(bloBsModel.getPrintTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        long timeStemp = date.getTime();
        bookWithBLOBs.setPublishTime(timeStemp);
        bookWithBLOBs.setWordNumber(bloBsModel.getWordNumber());
        bookWithBLOBs.setWhichEdtion(bloBsModel.getWhichEdtion());
        bookWithBLOBs.setTotalPage(bloBsModel.getTotalPage());
        Date date2 = null;
		try {
			date2 = simpleDateFormat.parse(bloBsModel.getPrintTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        long timeStemp2 = date2.getTime();
        bookWithBLOBs.setPrintTime(timeStemp2);
        bookWithBLOBs.setIsbn(bloBsModel.getIsbn());
        bookWithBLOBs.setAuthorSummary(bloBsModel.getAuthorSummary());
        bookWithBLOBs.setCatalogue(bloBsModel.getCatalogue());
        bookWithBLOBs.setPrintNumber(bloBsModel.getPrintNumber());
        
        bookMapper.updateByPrimaryKeyWithBLOBs(bookWithBLOBs);
	}
	

}
