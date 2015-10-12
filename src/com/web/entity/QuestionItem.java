package com.web.entity;

import java.io.Serializable;

public class QuestionItem implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private long id;
	private long order;
	private String content;
	private String answer;
	
	/**
	 * @return the id
	 */
	public long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(long id) {
		this.id = id;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * @return the answer
	 */
	public String getAnswer() {
		return answer;
	}
	/**
	 * @param answer the answer to set
	 */
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	/**
	 * @return the order
	 */
	public long getOrder() {
		return order;
	}
	/**
	 * @param order the order to set
	 */
	public void setOrder(long order) {
		this.order = order;
	}
	
}
