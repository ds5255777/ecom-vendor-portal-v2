package com.main.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PoAndLineItem {

	private long id;
	private String invoiceno;
	private String remaningQuatity;
	private Integer flag;
	private String lineNumberpo;
	private String poNumber;

	private Double poLineId;

}
