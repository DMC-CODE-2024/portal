package org.gl.ceir.CeirPannelCode.Model;
public class Password  extends UserHeader {
	private String password;
	private String confirmPassword;
	private String username;
	private Integer userid;
	private String oldPassword;
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	@Override
	public String toString() {
		return "Password [password=" + password + ", confirmPassword=" + confirmPassword + ", username=" + username
				+ ", userid=" + userid + ", oldPassword=" + oldPassword + "]";
	}
	     
}
