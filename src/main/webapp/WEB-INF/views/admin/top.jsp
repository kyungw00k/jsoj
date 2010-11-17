<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="admin" />
	<meta name="submenu" content="home" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>

						<div class="block tabs">
							<div class="hd">
								<ul>
									<li class="active"><a href="/admin/">Summary</a></li>
									<li><a href="/admin/problems">Manage Problems</a></li>
									<li><a href="/admin/users">Manage Users</a></li>
									<li><a href="/admin/contests">Manage Contests</a></li>
									<li><a href="/admin/submissions">Manage Submissions</a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								<div class="section">
									<div class="articles left">
										<h3>Recent Pending Problems</h3>
										<table class="zebra" summary="Recent Pending Problems">
										<col width="80"/>
										<col width="*"/>
										<thead>
										<tr>
											<th>PID</th>
											<th>TITLE</th>
										</tr>
										<tbody><c:choose><c:when test="${problems != null}"><c:forEach var="problem" end="19" items="${problems}">
											<tr>
												<td>${problem.id}</td>
												<td><a href="/problem/${problem.id}">${problem.title}</a></td>
											</tr></c:forEach></c:when><c:otherwise><tr><td class="center" colspan="4"><em>No Problems</em></td></tr></c:otherwise></c:choose>
										</tbody>
										</thead>
										</table>
									</div>
									<div class="articles left">
										<h3>Recent Joined Users</h3>
										<table class="zebra" summary="User Lists">
										<thead>
										<tr>
											<th>#</th>
											<th>User</th>
											<th>Nick Name</th>
											<th>Bio</th>
											<th>Created At</th>
										</tr>
										</thead>
										<tbody><c:choose><c:when test="${users != null }"><c:forEach var="user" end="19" items="${users}">
										<tr>
											<td><img src="${user.photoUrl}" width="41" height="41" alt=""/></td>
											<td>${user.fullName}</td>
											<td><a href="/profile/${user.nickName}">@${user.nickName}</a></td>
											<td>${user.description}</td>
											<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${user.created}" /></td>
										</tr></c:forEach></c:when><c:otherwise><tr><td class="center" colspan="5"><em>No users!</em></td></tr></c:otherwise></c:choose>
										</tbody>
										</table>
									</div>
								</div>
								<hr />								
								<h3>App Engine Status</h3>
								<table style="width:inherit" summary="System Resource Status">
								<col width="100" />
								<col width="150" />
								<tr>
									<th scope="row"><abbr title="the overall amount spent in CPU cycles">CPU_TIME_IN_MEGACYCLES</abbr></th>
									<td>
										<div class="barWrap">
											<span class="fill" style="width:<fmt:formatNumber value="${quota.cpuTimeInMegaCycles == 0 ? 100 : (quota.cpuTimeInMegaCycles/200000000.0)*100}" pattern="#"/>%">${quota.cpuTimeInMegaCycles == 0 ? "Not Available" : quota.cpuTimeInMegaCycles}</span>
										</div>										
									</td>
								</tr>
								<%--
								<tr>
									<th scope="row"><abbr title="the overall amount spent in API cycles">API_TIME_IN_MEGACYCLES</abbr></th>
									<td>
										<div style="width:100%;background-color:green;border:1px solid black">
											<span style="display:block;width:${quota.apiTimeInMegaCycles == 0 ? 100 : quota.apiTimeInMegaCycles/200000000*100}%;background-color:red">${quota.apiTimeInMegaCycles == 0 ? "Not supported" : quota.apiTimeInMegaCycles}</span>
										</div>
									</td>
								</tr>
								 --%>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
</body>
</html>