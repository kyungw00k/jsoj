<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="home" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="intro.top.notice"/></h2></div>
							<div class="bd blog">
								<c:if test="${admin != null}"><p><a class="button" href="/post/add"><img src="/images/add_page.png" alt="" border="0" />  Add Post</a></p><hr /></c:if>
								<c:choose><c:when test="${posts != null }"><c:forEach var="post" varStatus="status" items="${posts}">
								<c:if test="${status.count != 1}"><hr /></c:if>
								<div class="entry">
									<div class="title"><h2><a href="/post/${post.id}">${post.title}</a> </h2></div>
									<div class="author">
										Posted by ${post.user.nickname}, 
										<span class=""><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.created}" /></span>
										<c:if test="${admin != null}">
											<a class="small" href="/post/${post.id}/edit">(edit this)</a> 
											<a class="small" href="#" onclick="return deletePost('${post.id}');">(delete this)</a>
										</c:if>
									</div> 
									<div>${post.content}</div>
								</div></c:forEach></c:when><c:otherwise>
								<div class="entry">
									<div class="title">No Posts</div>
								</div></c:otherwise></c:choose><br />
								<c:if test="${admin != null}"><hr /><p><a class="button" href="/post/add"><img src="/images/add_page.png" alt="" border="0" /> Add Post</a></p></c:if>									
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<c:if test="${admin != null }">
						<form:form name="deletePostForm" commandName="post"  action="/post/${post.id}/delete" method="delete" />
						<script type="text/javascript">
						//<![CDATA[
							function deletePost(id) {
								var form = document.deletePostForm;
								if ( confirm('Are Sure?') ) {
									form.action="/post/"+id+"/delete";
									form.submit();
								}
								return false;
							}
						//]]>
						</script></c:if>
</body>
</html>