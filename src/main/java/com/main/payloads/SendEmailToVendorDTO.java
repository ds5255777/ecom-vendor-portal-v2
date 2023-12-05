package com.main.payloads;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;

import com.main.db.bpaas.entity.CommentHistory;

import lombok.Data;

@Data
public class SendEmailToVendorDTO {
	
	private Integer id;
	private String vendorEmail;
	private String vendorType;
	private String region;
	private String creditTerms;
	private Date processOn;
	private String processBy;
	private String thirdPartyVerification;
	private String ehsVerification;
	private String comments;
	private Integer flag;
	private String vendorKey;
	private String vendorPid;
	private String commentsHead;
	private String verifierName;
	private Date linkExpirationDate;
	private CommentHistory commentHistory;
	private String status;
	private String fileUpload;
	private List<SupplierFileUploadDTO> uploadFile;
	
	private String commercialHead;
	
	private String assignAt;
	private String comm_his_id;
}
