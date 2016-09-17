package com.ron.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ron.domain.User;
import com.ron.mapper.UserMapper;
import com.ron.service.TestService;

@Service
public class TestServiceImpl implements TestService {

	@Resource
	private UserMapper userMapper;
	
	@Override
	public User getUserById() {
		// TODO Auto-generated method stub
		return userMapper.selectByPrimaryKey(1);
	}

}
