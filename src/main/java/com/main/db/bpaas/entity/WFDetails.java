/*
 * package com.main.db.bpaas.entity;
 * 
 * import java.util.Date; import javax.persistence.Entity; import
 * javax.persistence.GeneratedValue; import javax.persistence.GenerationType;
 * import javax.persistence.Id; import javax.persistence.NamedQueries; import
 * javax.persistence.NamedQuery; import javax.persistence.Table;
 * 
 * @NamedQueries({
 * 
 * @NamedQuery(name = "WFDetails.findUserPending", query =
 * "select w from WFDetails w where w.status = 'RUNNING' and w.assignedTo=:userName"
 * ), // @NamedQuery(name = "SupDetails.findApprovedSupp", query =
 * "select t from SupDetails t where t.supStatus = 'Approved'")
 * // @NamedQuery(name = "TicketDetails.findByUserIdFive", query =
 * "select t from TicketDetails t where t.raisedBy = :raisedBy ORDER BY t.raisedOn DESC"
 * ) })
 * 
 * @Entity
 * 
 * @Table(name = "WFDetails") public class WFDetails {
 * 
 * @Id
 * 
 * @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
 * 
 * String refId; int type; String assignedTo; Long extID; String email; String
 * contactNum; String typeDesc; Date introducedOn = new Date();
 * 
 * String status; String supName;
 * 
 * public String getSupName() { return supName; }
 * 
 * public void setSupName(String supName) { this.supName = supName; }
 * 
 * public String getStatus() { return status; }
 * 
 * public void setStatus(String status) { this.status = status; }
 * 
 * public String getTypeDesc() { return typeDesc; }
 * 
 * public void setTypeDesc(String TypeDesc) { this.typeDesc = TypeDesc; }
 * 
 * public Long getId() { return id; }
 * 
 * public void setId(Long id) { this.id = id; }
 * 
 * public String getRefId() { return refId; }
 * 
 * public void setRefId(String refId) { this.refId = refId; }
 * 
 * public int getType() { return type; }
 * 
 * public void setType(int type) { this.type = type; }
 * 
 * public String getAssignedTo() { return assignedTo; }
 * 
 * public void setAssignedTo(String assignedTo) { this.assignedTo = assignedTo;
 * }
 * 
 * public Long getExtID() { return extID; }
 * 
 * public void setExtID(Long extID) { this.extID = extID; }
 * 
 * public String getEmail() { return email; }
 * 
 * public void setEmail(String email) { this.email = email; }
 * 
 * public String getContactNum() { return contactNum; }
 * 
 * public void setContactNum(String contactNum) { this.contactNum = contactNum;
 * }
 * 
 * public Date getIntroducedOn() { return introducedOn; }
 * 
 * public void setIntroducedOn(Date introducedOn) { this.introducedOn =
 * introducedOn; }
 * 
 * }
 */