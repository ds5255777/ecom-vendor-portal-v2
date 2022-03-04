package com.main.bean;

public class DataContainer {

	private Object data;
	private String status;
	private Object errorObject;
	private String msg;
	private Object forward;
	private Object backward;
	
//	private Object RequestID;
	
	
	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getErrorObject() {
		return errorObject;
	}

	public void setErrorObject(Object errorObject) {
		this.errorObject = errorObject;
	}

	public Object getForward() {
		return forward;
	}

	public void setForward(Object forward) {
		this.forward = forward;
	}

	public Object getBackward() {
		return backward;
	}

	public void setBackward(Object backward) {
		this.backward = backward;
	}

	
	/*public Object getRequestID() {
		return RequestID;
	}

	public void setRequestID(Object requestID) {
		RequestID = requestID;
	}*/

	
	
	
	
	
	
	
	
	
	
}
