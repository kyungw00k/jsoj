<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="discussion" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="menu.discussion"/></h2></div>
							<div class="bd blog">
								<div class="center">
									<a href="http://lifeboat.com/ex/shouting.at.the.cosmos" target="_new"><img src="http://lifeboat.com/images/couple.shouting.jpg" alt="Arguments and Answers" height="180" border="0" /></a><br /><br />
									<em>Arguments and Answers</em>
								</div><br />
								<c:if test="${member != null}"><p><a class="button" href="/post/add"><img src="/images/add_page.png" alt="" border="0" /> Add Post</a></p></c:if>
								<table class="zebra">
								<thead>
								<tr>
									<th>Topic</th>
									<th>Category</th>
								</tr>
								</thead>	
								<tbody>
								<c:choose><c:when test="${posts != null }"><c:forEach var="post" varStatus="status" items="${posts}">
								<tr>
									<td>
										<h4><a class="no-underline" href="/post/${post.id}">${post.title}</a></h4>
										<p class="author">
											Posted by @${post.member.nickName}, <img src="/images/comment.png" alt="" border="0" />${post.commentSize} comments, <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.created}" /> 
											<c:if test="${member != null && post.member.accountId == member.accountId}">
												<a class="small no-underline" href="/post/${post.id}/edit">(edit this)</a> 
												<a class="small no-underline" href="#" onclick="return deletePost('${post.id}');">(delete this)</a>
											</c:if>
										</p>	
									</td>
									<td>${post.category}</td>
								</tr></c:forEach></c:when><c:otherwise>
								<tr>
									<td colspan="2"><em>No Topic</em></td>
								</tr></c:otherwise></c:choose>
								</tbody>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript">$(document).ready(function() {$('.zebra').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false,"bSort": false});} );</script>
						<c:if test="${member != null }">
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