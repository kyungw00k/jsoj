package net.jsoj.persistence.dao;

import java.io.Serializable;
import java.util.Date;

import net.jsoj.persistence.service.CommentService;
import net.jsoj.system.interpreter.InterpreterType;
import net.jsoj.system.judge.ValidationType;

import com.google.appengine.api.datastore.Text;
import com.google.code.twig.annotation.Index;
import com.google.code.twig.annotation.Key;
import com.google.code.twig.annotation.Type;

/**
 * @author kyungwook
 * 
 */
@SuppressWarnings({ "serial", "deprecation" })
public class Problem implements Serializable {
	@Key
	private String id;
	private Date created;
	private Date lastUpdated;
	@Index
	private String createdBy;
	@Index
	private Long accountId;
	private String title;
	@Type(Text.class)
	private String description;
	private String author;
	private String source;
	@Type(Text.class)
	private String scriptGlobal;
	@Type(Text.class)
	private String testInput;
	@Type(Text.class)
	private String testOutput;
	private Long timeLimit = 3L;
	private InterpreterType type = InterpreterType.Core;
	private ValidationType validationType = ValidationType.ignoreWhiteSpace;
	@Index
	private String status = ProblemStatus.Pending.toString();
	private boolean isContest = false;
	private String testFuncName = "main";

	/*
	@Type(Text.class) private String markupDocument = "";
	@Type(Text.class) private String scriptDocumentTest = "";
	 */
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Long getAccountId() {
		return accountId;
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

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Member createdBy) {
		this.createdBy = createdBy.toString();
		this.accountId = createdBy.getAccountId();
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getTestInput() {
		return testInput;
	}

	public void setTestInput(String testInput) {
		this.testInput = testInput;
	}

	public String getTestOutput() {
		return testOutput;
	}

	public void setTestOutput(String testOutput) {
		this.testOutput = testOutput;
	}

	public Long getTimeLimit() {
		return timeLimit;
	}

	public void setTimeLimit(Long timeLimit) {
		this.timeLimit = timeLimit;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(ProblemStatus status) {
		this.status = status.toString();
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setValidationType(ValidationType validationType) {
		this.validationType = validationType;
	}

	public ValidationType getValidationType() {
		return validationType;
	}

	public String toString() {
		return this.id.toString();
	}

	public void setContest(boolean isContest) {
		this.isContest = isContest;
	}

	public boolean isContest() {
		return isContest;
	}

	public void setTestFuncName(String testFuncName) {
		this.testFuncName = testFuncName;
	}

	public String getTestFuncName() {
		return testFuncName;
	}

	public void setType(InterpreterType type) {
		this.type = type;
	}

	public InterpreterType getType() {
		return type;
	}

	public void setScriptGlobal(String scriptGlobal) {
		this.scriptGlobal = scriptGlobal;
	}

	public String getScriptGlobal() {
		return scriptGlobal;
	}

	public int getCommentSize() {
		return CommentService.getSizeByOwnerId(this.id.toString());
	}

	/*
	public void setMarkupDocument(String markupDocument) {
		this.markupDocument = markupDocument;
	}

	public String getMarkupDocument() {
		return markupDocument;
	}

	public void setScriptDocumentTest(String scriptDocumentTest) {
		this.scriptDocumentTest = scriptDocumentTest;
	}

	public String getScriptDocumentTest() {
		return scriptDocumentTest;
	}
	*/
}
