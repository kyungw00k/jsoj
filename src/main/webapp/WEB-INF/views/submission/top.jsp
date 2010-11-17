<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<meta name="menu" content="onlinejudge" />
	<meta name="submenu" content="status" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="sidemenu.submissions"/></h2></div>
							<div class="bd">
								<div class="center">
									<a href="http://www.localcomputermart.com/cl-ad.html" target="_new"><img src="/images/problems.jpg" alt="Problems...Problems.." height="150" border="0" /></a><br /><br />
									<em>Don't be nervous</em>
								</div><br />
								<table class="zebra" summary="<spring:message code="sidemenu.submissions"/>">
									<thead>
									<tr>
										<th class="first">Code</th>
										<th>Problem</th>
										<th class="center">Result</th>
										<th class="center">Type</th>
										<th class="center">Run Time</th>
										<th class="center">User</th>
										<th class="center">Date(UTC)</th>
										<%--<th class="last" style="text-align:right">Action</th> --%>
									</tr>
									</thead>
									<tbody>
									<c:choose>
									<c:when test="${submissions != null}">
									<c:forEach var="current" end="24" items="${submissions}">
									<tr>
										<td><fmt:formatNumber value="${current.id}" pattern="0000000" /></td>
										<td><a href="/problem/${current.problemId}">${current.problemTitle}</a></td>
										<td class="center submit-status  ${current.status}">${current.status}</td>
										<td class="center">${current.language }</td>
										<td class="center"><fmt:formatNumber value="${current.executionTime}" pattern="0.000s" /></td>
										<td class="center"><a href="/profile/${current.member}">@${current.member}</a></td>
										<td class="center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${current.created}" /></td>
										<%--<td class="last"><a href="#">show</a> | <a href="#">destroy</a></td> --%>
									</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
									<tr>
										<td class="center" colspan="7"><em>There is no submission here. Submit your code!</em></td>
									</tr>
									</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
</body>
</html>