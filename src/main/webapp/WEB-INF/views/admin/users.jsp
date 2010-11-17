<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="admin" />
	<meta name="submenu" content="users" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block tabs">
							<div class="hd">
								<ul>
									<li><a href="/admin/">Summary</a></li>
									<li><a href="/admin/problems">Manage Problems</a></li>
									<li class="active"><a href="/admin/users">Manage Users</a></li>
									<li><a href="/admin/contests">Manage Contests</a></li>
									<li><a href="/admin/submissions">Manage Submissions</a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								<h3>User Lists</h3>
								<table class="zebra" id="users" summary="Pending Problems">
								<thead>
								<tr>
									<th>#</th>
									<th>User</th>
									<th>Nick Name</th>
									<th>Bio</th>
									<th>Created At</th>
									<th>Action</th>
								</tr>
								</thead>
								<tbody><c:choose><c:when test="${users != null }"><c:forEach var="user" items="${users}">
								<tr>
									<td><img src="${user.photoUrl}" width="41" height="41" alt=""/></td>
									<td>${user.fullName}</td>
									<td><a href="/profile/${user.nickName}">@${user.nickName}</a></td>
									<td>${user.description}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${user.created}" /></td>
									<td><button type="button" onclick="deleteAccount('${user.accountId}');"><img src="/images/delete.png" alt="" border="0" /> Delete</button></td>
								</tr></c:forEach></c:when><c:otherwise><tr><td colspan="6">No users!</td></tr></c:otherwise></c:choose>
								</tbody>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<c:if test="${users != null}">
						<form:form name="deleteAccountForm" action="/admin/users" method="delete"></form:form>
						<script type="text/javascript">
						//<![CDATA[
							$(document).ready(function() {$('#users').dataTable({"sPaginationType": "full_numbers"});} );
							function deleteAccount(accountId) {
								if ( confirm('Are you sure?\nAll records except submission will be removed.') ) {
									document.deleteAccountForm.action="/admin/users/"+accountId+"/delete";
									document.deleteAccountForm.submit();
								}
								return false;
							}
						//]]>
						</script>
						</c:if>
</body>
</html>