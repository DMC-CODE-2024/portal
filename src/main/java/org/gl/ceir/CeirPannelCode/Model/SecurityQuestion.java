package org.gl.ceir.CeirPannelCode.Model;

public class SecurityQuestion {

	private Integer id;
	private String question;
	private Integer category; 
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "SecurityQuestion [id=" + id + ", question=" + question + ", category=" + category + "]";
	}
	
	
	
}
