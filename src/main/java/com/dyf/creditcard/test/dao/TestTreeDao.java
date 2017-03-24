/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.test.dao;

import com.dyf.creditcard.common.persistence.TreeDao;
import com.dyf.creditcard.common.persistence.annotation.MyBatisDao;
import com.dyf.creditcard.test.entity.TestTree;

/**
 * 树结构生成DAO接口
 * @author ThinkGem
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}