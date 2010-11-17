package net.jsoj.persistence.dao;

import java.util.Date;

import net.jsoj.persistence.service.CommentService;

import com.google.appengine.api.datastore.Text;
import com.google.code.twig.annotation.Key;
import com.google.code.twig.annotation.Type;

@SuppressWarnings("deprecation")
public class Post {
	@Key
	private Long id;
	private Member member;
	
	private String title;

	@Type(Text.class)
	private String content;

	private Date created;
	private Date lastUpdated;

	private Category category;
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content
	 *            the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the created
	 */
	public Date getCreated() {
		return created;
	}

	/**
	 * @param created
	 *            the created to set
	 */
	public void setCreated(Date created) {
		this.created = created;
	}

	/**
	 * @return the lastUpdated
	 */
	public Date getLastUpdated() {
		return lastUpdated;
	}

	/**
	 * @param lastUpdated
	 *            the lastUpdated to set
	 */
	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public int getCommentSize() {
		return CommentService.getSizeByOwnerId(this.id.toString());
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Category getCategory() {
		return category;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Member getMember() {
		return member;
	}

}
