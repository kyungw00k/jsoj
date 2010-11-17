<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<meta name="menu" content="onlinejudge" />
	<meta name="submenu" content="ranks" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="sidemenu.ranklint"/></h2></div>
							<div class="bd">
								<div class="center">
									<a href="http://www.flickr.com/photos/hikingartist/3000043603/" target="_new"><img src="http://farm4.static.flickr.com/3200/3000043603_a1061664b4_m.jpg" alt="When winning means everything" border="0" /></a><br /><br />
									<em>When winning means everything</em>
								</div><br />
								<table class="zebra" summary="Authors Ranklist">
									<thead>
									<tr>
										<th>Rank</th>
										<th>User</th>
										<th>Solved</th>
										<th>Accepted</th>
										<th>Tried</th>
										<th>Total Submissions</th>
									</tr>
									</thead>
									<tbody>
									<c:choose>
									<c:when test="${ranks != null}">
									<c:forEach var="rank" varStatus="status" items="${ranks}">
									<tr>
										<td><em>${status.count}</em></td>
										<td><a href="/profile/${rank.nickName}">@${rank.nickName}</a></td>
										<td class="Accepted"><strong>${rank.solved}</strong></td>
										<td class="PresentationError">${rank.accepted}</td>
										<td class="Timeout">${rank.tried}</td>
										<td class="RuntimeError">${rank.totalSubmissions}</td>
									</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
									<tr>
										<td class="center" colspan="5"><em>No Ranklist.</em></td>
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