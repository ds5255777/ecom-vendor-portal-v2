package com.main.serviceManager;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.repo.EmailConfigurationRepository;
import com.main.db.bpaas.repo.RolesRepository;
import com.main.db.bpaas.repo.UserRepository;

@Service
public class ServiceManager {

	@Autowired
	public UserRepository userRepository;

	@Autowired
	public RolesRepository rolesRepository;

	@Autowired
	public EmailConfigurationRepository emailConfigurationRepository;

	public void insertRecordIntoAuditEntry(HttpServletRequest request, String action, String actionType, String remarks,
			String ticketId, Integer ticketQueueId) {

		String userName = (String) request.getSession().getAttribute("userName");
		Integer userId = (Integer) request.getSession().getAttribute("userId");
		//AuditEntry auditEntry = new AuditEntry();
//		auditEntry.setActionType(actionType);
//		auditEntry.setAction(action);
//		auditEntry.setCreatedOn(new Date());
//		auditEntry.setRemarks(remarks);
//		auditEntry.setUserId(userId);
//		auditEntry.setUserName(userName);
//
//		auditEntryRepository.save(auditEntry);

	}

	public void insertAddUpdateInMaster(HttpServletRequest request, String action, String actionType, String remarks,
			String newValue, String oldValue) {

		String userName = (String) request.getSession().getAttribute("userName");
		Integer userId = (Integer) request.getSession().getAttribute("userId");
//		AuditEntry auditEntry = new AuditEntry();
//		auditEntry.setActionType(actionType);
//		auditEntry.setAction(action);
//		auditEntry.setCreatedOn(new Date());
//		auditEntry.setRemarks(remarks);
//		auditEntry.setNewValue(newValue);
//		auditEntry.setOldValue(oldValue);
//		auditEntry.setUserId(userId);
//		auditEntry.setUserName(userName);
//
//		auditEntryRepository.save(auditEntry);

	}

	/*
	 * public void addNotofication(Integer userId,String userName,String
	 * notificationLink,String notificationType, String ticketId, Integer
	 * ticketQueueId) {
	 * 
	 * NotificationEntity notificationEntity= new NotificationEntity();
	 * 
	 * notificationEntity.setUserId(userId);
	 * notificationEntity.setUserName(userName);
	 * notificationEntity.setIsRead("False");
	 * notificationEntity.setNotificationLink(notificationLink);
	 * notificationEntity.setNoticationDetail(null);
	 * notificationEntity.setNotificationType(notificationType);
	 * notificationEntity.setTicketId(ticketId);
	 * notificationEntity.setTicketQueueId(ticketQueueId);
	 * notificationRepository.save(notificationEntity);
	 * 
	 * }
	 */

}
