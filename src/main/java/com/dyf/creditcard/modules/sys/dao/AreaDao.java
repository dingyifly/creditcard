/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.sys.dao;

import com.dyf.creditcard.common.persistence.TreeDao;
import com.dyf.creditcard.common.persistence.annotation.MyBatisDao;
import com.dyf.creditcard.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
