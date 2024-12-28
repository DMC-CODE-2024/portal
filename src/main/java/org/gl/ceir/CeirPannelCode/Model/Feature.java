package org.gl.ceir.CeirPannelCode.Model;

import java.util.List;

public class Feature {
	private Integer id;
	private String category;
	private String name;
	private String logo;
	private String link;
	private List<String> iconState;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}

	public List<String> getIconState() {
		return iconState;
	}

	public void setIconState(List<String> iconState) {
		this.iconState = iconState;
	}

	@Override
	public String toString() {
		return "Feature{" +
				"id=" + id +
				", category='" + category + '\'' +
				", name='" + name + '\'' +
				", logo='" + logo + '\'' +
				", link='" + link + '\'' +
				", iconState=" + iconState +
				'}';
	}
}
