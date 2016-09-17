package com.ron.mapper;

import com.ron.domain.ReceiveAddress;

public interface ReceiveAddressMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ReceiveAddress record);

    int insertSelective(ReceiveAddress record);

    ReceiveAddress selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ReceiveAddress record);

    int updateByPrimaryKey(ReceiveAddress record);
}