package net.jsoj.persistence.dao;

public class Rank implements Comparable<Rank> {
	private String nickName;
	private Integer solved;
	private Integer accepted;
	private Integer tried;
	private Integer totalSubmissions;
	
	public Rank( String nickName, Integer solved, Integer accepted, Integer totalSubmissions) {
		setNickName(nickName);
		setSolved(solved);
		setAccepted(accepted);
		setTotalSubmissions(totalSubmissions);
		setTried(getTotalSubmissions() - getAccepted());
	}
	public int compareTo(Rank o) {
		return this.getSolved() < o.getSolved()
		? 1
		: this.getAccepted() < o.getAccepted() 
			? 1
			: this.getTried() < o.getTried()
				? 1
				: 0;
	}
	public void setTotalSubmissions(Integer totalSubmissions) {
		this.totalSubmissions = totalSubmissions;
	}
	public Integer getTotalSubmissions() {
		return totalSubmissions;
	}
	public void setAccepted(Integer accepted) {
		this.accepted = accepted;
	}
	public Integer getAccepted() {
		return accepted;
	}
	public void setTried(Integer tried) {
		this.tried = tried;
	}
	public Integer getTried() {
		return tried;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setSolved(Integer solved) {
		this.solved = solved;
	}
	public Integer getSolved() {
		return solved;
	}
}
