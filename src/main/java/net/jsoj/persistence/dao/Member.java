package net.jsoj.persistence.dao;

import java.io.Serializable;
import java.net.URL;
import java.util.Date;

import com.google.appengine.api.datastore.Text;
import com.google.code.twig.annotation.Index;
import com.google.code.twig.annotation.Key;
import com.google.code.twig.annotation.Type;

@SuppressWarnings({ "serial", "deprecation" })
public class Member implements Serializable {
 	@Key @Index private Long accountId;
	private MemberType memberType;
	private Date created;
	private Date lastUpdated;
	@Index private String nickName;
	private String fullName;
	private String photoUrl;
	@Type(Text.class)
	private String description;
	private String location;

	public Member() {
	}

	public Member(Long accountId, MemberType memberType, String nickName,
			String fullName, URL url, String description, String location) {
		this.setNickName(nickName);
		this.setFullName(fullName);
		this.setAccountId(accountId);
		this.setMemberType(memberType);
		this.setPhotoUrl(url.toString());
		this.setDescription(description);
		this.setLocation(location);
	}

	/**
	 * @return the accountId
	 */
	public Long getAccountId() {
		return accountId;
	}

	/**
	 * @param i
	 *            the accountId to set
	 */
	public void setAccountId(Long accountId) {
		this.accountId = accountId;
	}

	/**
	 * @return the memberType
	 */
	public MemberType getMemberType() {
		return memberType;
	}

	/**
	 * @param memberType
	 *            the memberType to set
	 */
	public void setMemberType(MemberType memberType) {
		this.memberType = memberType;
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

	/**
	 * @return the nickName
	 */
	public String getNickName() {
		return nickName;
	}

	/**
	 * @param nickName
	 *            the nickName to set
	 */
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	/**
	 * @return the fullName
	 */
	public String getFullName() {
		return fullName;
	}

	/**
	 * @param fullName
	 *            the fullName to set
	 */
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	/**
	 * @return the photoUrl
	 */
	public String getPhotoUrl() {
		return photoUrl;
	}

	/**
	 * @param photoUrl
	 *            the photoUrl to set
	 */
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the location
	 */
	public String getLocation() {
		return location;
	}

	/**
	 * @param location
	 *            the location to set
	 */
	public void setLocation(String location) {
		this.location = location;
	}

	public String toString() {
		return this.nickName;
	}
}
