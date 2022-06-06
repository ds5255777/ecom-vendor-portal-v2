package com.main.bean;

import javax.persistence.Column;

public class PoAndLineItem {

	private long id;
	private String invoiceno;
	private String remaningQuatity;
	private Integer flag;
	private String lineNumberpo;
	private String poNumber;
	
	private Double poLineId;

	public String getInvoiceno() {
		return invoiceno;
	}

	public void setInvoiceno(String invoiceno) {
		this.invoiceno = invoiceno;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getRemaningQuatity() {
		return remaningQuatity;
	}

	public void setRemaningQuatity(String remaningQuatity) {
		this.remaningQuatity = remaningQuatity;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getLineNumberpo() {
		return lineNumberpo;
	}

	public void setLineNumberpo(String lineNumberpo) {
		this.lineNumberpo = lineNumberpo;
	}

	public String getPoNumber() {
		return poNumber;
	}

	public void setPoNumber(String poNumber) {
		this.poNumber = poNumber;
	}

	public Double getPoLineId() {
		return poLineId;
	}

	public void setPoLineId(Double poLineId) {
		this.poLineId = poLineId;
	}

}
