package com.dyf.creditcard.modules.work.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.dyf.creditcard.common.utils.DateUtils;
import com.dyf.creditcard.modules.work.entity.CardTransaction;
import com.dyf.creditcard.modules.work.service.CardTransactionService;

@Service
@Lazy(false)
public class CardTask {
	
	@Autowired
	private CardTransactionService transactionService;
	
	@Scheduled(cron = "0 00 04 * * *")
	public void toAction() {
		System.out.println("定时任务开始");
		CardTransaction transaction = new CardTransaction();
		transaction.setDealDate(DateUtils.getDate());
		transactionService.pendingToAction(transaction);
	}

}
