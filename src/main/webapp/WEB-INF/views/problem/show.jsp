<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="onlinejudge" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="/javascripts/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="/javascripts/ckeditor/adapters/jquery.js"></script>
</head>
<body>
						<div class="block">
							<div class="hd">
								<h2>Problem : ${problem != null ? problem.title : 'Not Found'}<c:if test="${problem != null}"><div style="position:absolute;right:6px;top:10px;"><a href="http://twitter.com/share" class="twitter-share-button" data-text="JavaScript Online Judge - Problem '${problem.title}'" rel="canonical" data-count="horizontal" data-via="${problem.createdBy}">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></div></c:if></h2>
							</div>
							<div class="bd">
							<c:choose>
								<c:when test="${problem != null}">
								<div class="clear right button-wrap">
									<c:if test="${(member != null && member.accountId == problem.accountId)}"><a class="inline-block button" href="/problem/${problem.id}/edit"><img src="/images/edit.png" alt="" border="0" /> Edit</a> </c:if>
									<c:if test="${member != null && problem.status == 'Accepted' }"><a class="inline-block button"  title="Submit ${problem.id}" href="/submit/${problem.id}"><img src="/images/mail_send" /> <spring:message code="sidemenu.submitcode.png" alt="" border="0" /></a></c:if>
								</div>
								<h2 class="center"><strong>${problem.title}</strong> (Time Limit : ${problem.timeLimit}s) </h2>
								${html}
								<hr />
								<table class="zebra">
									<col width="100" />
									<c:if test="${problem.author != '' && problem.author != problem.createdBy}">
									<tr>
										<th scope="row"><strong>Author</strong></th>
										<td>${problem.author}</td>
									</tr>
									</c:if>
									<c:if test="${problem.source != ''}">
									<tr>
										<th scope="row"><strong>Soruce</strong></th>
										<td>${problem.source}</td>
									</tr>
									</c:if>
									<tr>
										<th scope="row"><strong>Added by</strong></th>
										<td><a href="/profile/${problem.createdBy}">@${problem.createdBy}</a></td>
									</tr>
									<tr>
										<th scope="row"><strong>Created At</strong></th>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${problem.created}" /></td>
									</tr>
								</table>
								<hr />
								<c:if test="${comments != null }">
								<h5 id="comments">${problem.commentSize} Responses to "${problem.title}"</h5>
								<ol class="commentlist"><c:forEach var="comment" items="${comments}">
									<li id="comment-${comment.id}" class="comment">
										<div class="avatar-frame"><img src="${comment.member.photoUrl}" alt="${comment.member.nickName}" width="48" height="48" /></div>
										<div class="comment-content">
											<div class="comment-author">
												<a href="/profile/${comment.member.nickName}">@${comment.member.nickName}</a> <span class="says">says:</span>
												<span class="small author">(<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${comment.created}" />)</span> 
												<c:if test="${member != null && member.accountId == comment.member.accountId }">
												<a class="small" href="#" onclick="return deleteComment('${comment.id}');">(delete this)</a>
												</c:if>
												
											</div>
											<div class="body">${comment.content}</div>
											<div class="clear"></div>
										</div>
										<div class="clear"></div>
									</li></c:forEach>
								</ol>
								</c:if>
								<c:if test="${member != null }">
								<form:form modelAttribute="comment" commandName="comment" action="/problem/${problem.id}/comment" method="POST">
									<form:hidden path="pid" value="${problem.id}" />
									<table>
									<tr>
										<td><h4>Leave a Comment <label><span class="small validation"><form:errors path="content"/></span></label></h4></td>
										<td class="right"><button type="submit" class="button"><img src="/images/add.png" alt="" border="0" /> Add Comment</button></td>
									</tr>
									<tr><td colspan="2"><form:textarea path="content" cssClass="text"/></td></tr>
									</table>
                                </form:form>
                                </c:if>
                                </c:when>
								<c:otherwise>
								<em>Can't found problem. Use correct problem id!</em>
								</c:otherwise>
							</c:choose>
							<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<c:if test="${problem != null}"><script type="text/javascript" src="/javascripts/MathJax/MathJax.js">
						//<![CDATA[
						MathJax.Hub.Config({config: ["MMLorHTML.js"],extensions: ["tex2jax.js"],jax: ["input/TeX"],tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]}});
						//]]>
						</script></c:if>
						<c:if test="${member != null && problem != null }">
						
						<form:form name="deleteCommentForm" commandName="post"  action="/problem/${post.id}/comment/delete" method="delete" />
						<script type="text/javascript">
						//<![CDATA[
						function redirectToPosts(){window.location='/problem/${post.id}/';};
						$(document).ready(function() {$('#content').ckeditor();});
						function deleteComment(id) {
							var form = document.deleteCommentForm;
							if ( confirm('Are Sure?') ) {
								form.action="/problem/${post.id}/comment/"+id+"/delete";
								form.submit();
							}
							return false;
						}
						//]]>
						</script>
						</c:if>
</body>
</html>