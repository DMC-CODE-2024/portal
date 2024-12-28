package org.gl.ceir.CeirPannelCode.Model;

public class Tag {
private String tag;

public String getTag() {
	return tag;
}

public void setTag(String tag) {
	this.tag = tag;
}

@Override
public String toString() {
	return "Tag [tag=" + tag + "]";
}

public Tag(String tag) {
	super();
	this.tag = tag;
}

public Tag() {
	super();
}


}
