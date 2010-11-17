<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="onlinejudge" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Script Online Judge</title>
</head>
<body>
						<div class="block">
							<div class="hd"><h2>Online Judge</h2></div>
							<div class="bd">
								<table>
								<tr>
									<td class="center">
										<a href="http://www.localcomputermart.com/cl-ad.html" target="_new"><img src="/images/problems.jpg" alt="Problems...Problems.." height="150" border="0" /></a><br /><br />
										<em>Step 1. Make your code</em>
									</td>
									<td class="center">
										<img src="/images/judge.gif" alt="Judging" height="150" border="0" /><br /><br />
										<em>Step 2. We judge</em>
									</td>
								</tr>
								</table>
								<div class="section">
									<h3><img src="/images/add_page.png" alt="" border="0" /> New Problems</h3>
									<table class="zebra" id="problems">
										<col width="120"></col>
										<col width="*"></col>
										<col width="120"></col>
										<col width="200"></col>
										<thead>
										<tr>
											<th>Code</th>
											<th>Title</th>
											<th>Added By</th>
											<th>Source</th>
										</tr>
										</thead>
										<tbody>
										<c:choose>
										<c:when test="${newProblems != null}">
										<c:forEach var="problem" items="${newProblems}">
										<tr>
											<td>${problem.id}</td>
											<td><a href="/problem/${problem.id}">${problem.title}</a></td>
											<td><a href="/profile/${problem.createdBy}">@${problem.createdBy}</a></td>
											<td>${problem.source}</td>
										</tr>								
										</c:forEach>
										</c:when>
										<c:otherwise>
										<tr><td class="center" colspan="4"><em>There is no problem here. Make a problem for others!</em></td></tr>
										</c:otherwise>
										</c:choose>
										</tbody>
									</table>
								</div>
								<hr />
								<div>
									<div class="section float-left" style="width:48%;margin-right:2%">
										<h3><img src="/images/users.png" alt="" border="0" /> Top Users <c:if test="${fn:length(ranks) > 10}"><a href="/ranks" class="small"><spring:message code="more"/></a></c:if></h3>
										<table class="zebra" summary="Authors Ranklist">
										<thead>
										<tr>
											<th>Rank</th>
											<th>User</th>
											<th>Solved</th>
											<th>Total</th>
										</tr>
										</thead>
										<tbody>
										<c:choose>
										<c:when test="${ranks != null}">
										<c:forEach var="rank" varStatus="status" items="${ranks}">
										<tr>
											<td><em>${status.count}</em></td>
											<td><a href="/profile/${rank.nickName}">@${rank.nickName}</a></td>
											<td>${rank.solved}</td>
											<td>${rank.totalSubmissions}</td>
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
									</div>
									<div class="section float-left" style="width:50%">
										<h3><img src="/images/process.png" alt="" border="0" /> Recent Submissions <a href="/status" class="small"><spring:message code="more"/></a></h3>
										<table class="zebra">
											<thead>
											<tr>
												<th>Code</th>
												<th>User</th>
												<th>Result</th>											
											</tr>
											</thead>
											<tbody>
											<c:choose><c:when test="${submissions != null}">
											<c:forEach var="current" end="9" items="${submissions}">
											<tr>
												<td><a href="/problem/${current.problemId}">${current.problemId}</a></td>
												<td><a href="/profile/${current.member}">@${current.member}</a></td>
												<td class="submit-status  ${current.status}">${current.status}</td>
											</tr>
											</c:forEach></c:when><c:otherwise>
											<tr><td class="center" colspan="3"><em><img src="/images/warning.png" alt="" border="0" />There is no submission here. Submit your code!</em></td></tr>
											</c:otherwise>
											</c:choose>
											</tbody>
										</table>
									</div>
									<div class="clear"></div>							
								</div>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
</body>
</html>