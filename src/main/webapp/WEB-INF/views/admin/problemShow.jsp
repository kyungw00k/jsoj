<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<meta name="menu" content="onlinejudge" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
						<div class="block">
							<div class="hd"><h2>Problem : ${problem != null ? problem.title : 'Not Found'}</h2></div>
							<div class="bd">
							<c:choose>
								<c:when test="${problem != null}">
								<div class="right">
									<c:if test="${admin != null || (member != null && member.accountId == problem.accountId && problem.status == 'Pending')}"><button type="button" onclick="confirmDelete();"><img src="/images/icons/cross.png" alt="Delete"/> Delete</button></c:if>
									<c:if test="${(member != null && member.accountId == problem.accountId)}"><a class="inline-block button" href="/problem/${problem.id}/edit"><img src="/images/icons/edit.png" alt="Edit"/> Edit</a> </c:if>
									<c:if test="${member != null && problem.status == 'Accepted' }"><a class="inline-block button"  href="/submit?pid=${problem.id}"><img src="/images/icons/edit.png" alt="Submit Code"/>  Submit code</a></c:if>
								</div>
								<h2 class="center"><strong>${problem.title}</strong> (Time Limit : ${problem.timeLimit}s)</h2>
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
										<td><a href="/profile/${problem.createdBy}" title="Added by ${problem.createdBy}">@${problem.createdBy}</a></td>
									</tr>
									<tr>
										<th scope="row"><strong>Created At</strong></th>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${problem.created}" /></td>
									</tr>
									<c:if test="${admin != null}">
									<tr>
										<th scope="row"><strong>Validation</strong></th>
										<td>${problem.validationType}</td>
									</tr>
									<tr>
										<th scope="row"><strong>Test Input</strong></th>
										<td><textarea class="text" cssClass="text_area" style="width:100%;height:100px;" readonly="readonly">${problem.testInput}</textarea></td>
									</tr>
									<tr>
										<th scope="row"><strong>Test Output</strong></th>
										<td><textarea class="text" cssClass="text_area" style="width:100%;height:100px;" readonly="readonly">${problem.testOutput}</textarea></td>
									</tr>
									</c:if>
								</table>
								<c:if test="${member != null}">
								<%--
									Comment 추가 Form
								 --%>								
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
						</script><c:if test="${admin != null || (member != null && member.accountId == problem.accountId && problem.status != 'Accepted')}">
						<form:form commandName="problem" action="${admin != null && member == null ? '/admin' : ''}/problem/${problem.id}" method="delete"></form:form>
						<script type="text/javascript">
						//<![CDATA[
						function confirmDelete() {
							if ( confirm('Are you sure? It cannot be undone!') ) {
								$('#problem').submit();
							}
						}
						//]]>
						</script></c:if></c:if>
</body>
</html>