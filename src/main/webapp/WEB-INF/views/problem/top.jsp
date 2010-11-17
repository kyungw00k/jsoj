<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="onlinejudge" />
	<meta name="submenu" content="problem" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="sidemenu.problems"/></h2></div>
							<div class="bd">
								<div class="center">
									<a href="http://www.flickr.com/photos/thetruthabout/2788140407/" target="_new"><img src="http://farm4.static.flickr.com/3129/2788140407_c5e3023a6c_m.jpg" alt="Problem And Solution" height="180" border="0" /></a><br /><br />
									<em>Problem And Solution</em>
								</div><br />
								<table class="zebra" id="problems">
									<col width="150" />
									<col width="*" />
									<col width="100" />
									<col width="120" />
									<col width="120" />
									<col width="200" />
									<thead>
									<tr>
										<th>Code</th>
										<th><spring:message code="title"/></th>
										<th><spring:message code="type"/></th>
										<th><spring:message code="accepted"/>/<spring:message code="submitted"/></th>
										<th><spring:message code="added_by"/></th>
										<th><spring:message code="source"/></th>
									</tr>
									</thead>
									<tbody><c:choose><c:when test="${status != null}"><c:forEach var="problem" items="${status}">
									<tr>
										<td><a href="/problem/${problem.key.id}">${problem.key.id}</a></td>
										<td><a href="/problem/${problem.key.id}">${problem.key.title}</a></td>
										<td>${problem.key.type}</td>
										<td><c:if test="${problem.key.status != 'Pending'}"><a href="<%--/stat/${problem.key.id}/--%>"><fmt:formatNumber type="percent" maxFractionDigits="2" groupingUsed="false" value="${problem.value.total == 0 ? 0.00 : problem.value.Accepted / problem.value.total}" /> (${problem.value.Accepted}/${problem.value.total})</a></c:if></td>
										<td><a href="/profile/${problem.key.createdBy}">@${problem.key.createdBy}</a></td>
										<td>${problem.key.source}</td>
									</tr></c:forEach></c:when><c:otherwise>
									<tr><td class="center" colspan="6"><em><spring:message code="member.view.user.makeproblem.none"/></em></td></tr>
									</c:otherwise></c:choose></tbody>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript">$(document).ready(function() {$('#problems').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false,"bSort": false} );} );</script>
</body>
</html>