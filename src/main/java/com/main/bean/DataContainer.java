package com.main.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DataContainer {

	private Object data;
	private String status;
	private Object errorObject;
	private String msg;
	private Object forward;
	private Object backward;
	
	private Long totalRecord;

}
