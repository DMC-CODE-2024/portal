package org.gl.ceir.CeirPannelCode.Model;

public class DbListDataHeaders {

	private String data;
	private String title;
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
	public DbListDataHeaders(String data, String title) {
		super();
		this.data = data;
		this.title = title;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("DbListDataHeaders [data=");
		builder.append(data);
		builder.append(", title=");
		builder.append(title);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
}
