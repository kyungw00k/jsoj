package net.jsoj.persistence.dao;

import java.io.Serializable;
import java.util.Date;

import net.jsoj.system.interpreter.InterpreterType;

import com.google.appengine.api.datastore.Text;
import com.google.code.twig.annotation.Index;
import com.google.code.twig.annotation.Key;
import com.google.code.twig.annotation.Type;

@SuppressWarnings({ "serial", "deprecation" })
public class Submission implements Serializable {
	@Key private Long id;
	@Index private Date created;
	private Date lastUpdated;
	private String member;
	private String problemTitle;
	@Index private Long accountId;
	@Index private String problemId;
	@Index
	private String status = SubmissionStatus.Submitted.toString();
	private Double executionTime = 0.0;
	@Type(Text.class)
	private String code;
	private InterpreterType language = InterpreterType.Core;
	private boolean isContest = false;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	public String getProblemId() {
		return problemId;
	}

	public void setProblemId(String problemId) {
		this.problemId = problemId;
	}

	public String getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member.toString();
		this.accountId = member.getAccountId();
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(SubmissionStatus status) {
		this.status = status.toString();
	}

	public Double getExecutionTime() {
		return executionTime;
	}

	public void setExecutionTime(Double executionTime) {
		this.executionTime = executionTime;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public InterpreterType getLanguage() {
		return language;
	}

	public void setLanguage(InterpreterType language) {
		this.language = language;
	}

	public Long getAccountId() {
		return accountId;
	}

	public void setProblemTitle(String problemTitle) {
		this.problemTitle = problemTitle;
	}

	public String getProblemTitle() {
		return problemTitle;
	}

	public void setContest(boolean isContest) {
		this.isContest = isContest;
	}

	public boolean isContest() {
		return isContest;
	}
}
