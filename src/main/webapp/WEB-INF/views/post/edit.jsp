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
							<div class="hd"><h3><c:choose><c:when test="${isNew}">New Post</c:when><c:otherwise>Modify Post</c:otherwise></c:choose></h3></div>
							<div class="bd">
								<form:form modelAttribute="post" commandName="post" action="/post/${isNew ? 'save' : post.id}" method="${isNew ? 'POST' : 'PUT' }">
									<c:if test="${isNew == false}"><form:hidden path="created" value="${post.created}"/></c:if>
									<p>
										<label for="title">Category</label>
										<form:select path="category">
											<c:if test="${admin != null }"><form:option value="Notice" label="Notice" /></c:if>
											<form:option value="General" label="General" />
											<form:option value="Discussion" label="Discussion" />
											<form:option value="Editorial" label="Editorial" />
											<form:option value="Stuff" label="Stuff" />
										</form:select>
									</p>
									<p>
										<label for="title">Title <span class="validation"><form:errors path="title"/></span></label>
										<form:input path="title" cssClass="text" value="${post.title}" />
									</p>
									<p>
										<label for="content">Content <span class="validation"><form:errors path="content"/></span></label>
										<form:textarea path="content" cssClass="text" value="${fn:escapeXml(post.content)}" />
									</p>
									<p>
										<button class="button" type="submit">
										  <spring:message code="${isNew ? 'img.add_page' : 'img.edit'}"/> ${isNew ? 'Add' : 'Update'}
										</button>
										<button class="button" type="button" onclick="redirectToPosts();">
										  <img src="/images/block.png" alt="" border="0" /> Cancel
										</button>
									</p>
								</form:form>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript" src="/javascripts/showdown.min.js"></script>
						<script type="text/javascript" src="/javascripts/MathJax/MathJax.js">MathJax.Hub.Config({config: ["MMLorHTML.js"],extensions: ["tex2jax.js"],jax: ["input/TeX"],tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]}});</script>
						<script type="text/javascript" src="/javascripts/edit_area/edit_area_full.js"></script>
						<script type="text/javascript">
						//<![CDATA[
						function redirectToPosts(){window.location='/posts';};
						$(document).ready(function() {
							$('#content').ckeditor();
						});
						//]]>
						</script>
						
						
</body>
</html>