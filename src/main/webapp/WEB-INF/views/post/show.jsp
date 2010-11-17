<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="discussion" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="/javascripts/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="/javascripts/ckeditor/adapters/jquery.js"></script>
</head>
<body>
						<div class="block">
							<div class="hd">
								<h3>
									<strong>${post.category}</strong> &gt; ${post.title} 
									<span class="author small">Posted by ${post.member.nickName}, <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.created}" /></span>
									<c:if test="${member != null && member.accountId == post.member.accountId}"> <a class="small" style="color:red" href="/post/${post.id}/edit">(edit this)</a> <a class="small" style="color:red" href="#" onclick="return deletePost('${post.id}');">(delete this)</a></c:if>
									<div style="position:absolute;right:6px;top:10px;"><a href="http://twitter.com/share" class="twitter-share-button" data-text="JavaScript Online Judge - Post '${post.title}'" rel="canonical" data-via="${member.nickName}" data-count="horizontal">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></div>
								</h3>
							</div>
							<div class="bd">
								<div class="body">${post.content}</div>
								<c:if test="${comments != null }">
								<h5 id="comments">${post.commentSize} Responses to "${post.title}"</h5>
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
								<form:form modelAttribute="comment" commandName="comment" action="/post/${post.id}/comment" method="POST">
									<form:hidden path="pid" value="${post.id}" />
									<table>
									<tr>
										<td><h4>Leave a Comment <label><span class="small validation"><form:errors path="content"/></span></label></h4></td>
										<td class="right"><button type="submit" class="button"><img src="/images/add.png" alt="" border="0" /> Add Comment</button></td>
									</tr>
									<tr><td colspan="2"><form:textarea path="content" cssClass="text"/></td></tr>
									</table>
                                </form:form>
                                </c:if>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript" src="/javascripts/MathJax/MathJax.js">MathJax.Hub.Config({config: ["MMLorHTML.js"],extensions: ["tex2jax.js"],jax: ["input/TeX"],tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]}});</script>
						<script type="text/javascript" src="/javascripts/edit_area/edit_area_full.js"></script>
						<c:if test="${member != null }">
						<form:form name="deleteCommentForm" commandName="post"  action="/post/${post.id}/comment/delete" method="delete" />
						<script type="text/javascript">
						//<![CDATA[
						function redirectToPosts(){window.location='/posts';};
						$(document).ready(function() {$('#content').ckeditor();});
						function deleteComment(id) {
							var form = document.deleteCommentForm;
							if ( confirm('Are Sure?') ) {
								form.action="/post/${post.id}/comment/"+id+"/delete";
								form.submit();
							}
							return false;
						}
						//]]>
						</script>
						</c:if>
						<c:if test="${admin != null }">
						<form:form name="deletePostForm" commandName="post"  action="/post/${post.id}/delete" method="delete" />
						<script type="text/javascript">
						//<![CDATA[
							function deletePost() {
								if ( confirm('Are Sure?') ) {
									document.deletePostForm.submit();
								}
								return false;
							}
						//]]>
						</script></c:if>
</body>
</html>