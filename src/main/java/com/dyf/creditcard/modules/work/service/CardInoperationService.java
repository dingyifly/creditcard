/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.service.CrudService;
import com.dyf.creditcard.modules.work.entity.CardInoperation;
import com.dyf.creditcard.modules.work.dao.CardInoperationDao;

/**
 * 不操作日管理Service
 * @author dyf
 * @version 2017-08-28
 */
@Service
@Transactional(readOnly = true)
public class CardInoperationService extends CrudService<CardInoperationDao, CardInoperation> {

	public CardInoperation get(String id) {
		return super.get(id);
	}
	
	public List<CardInoperation> findList(CardInoperation cardInoperation) {
		return super.findList(cardInoperation);
	}
	
	public Page<CardInoperation> findPage(Page<CardInoperation> page, CardInoperation cardInoperation) {
		return super.findPage(page, cardInoperation);
	}
	
	@Transactional(readOnly = false)
	public void save(CardInoperation cardInoperation) {
		super.save(cardInoperation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CardInoperation cardInoperation) {
		super.delete(cardInoperation);
	}
	
}