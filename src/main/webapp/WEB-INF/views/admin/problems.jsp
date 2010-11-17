<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="admin" />
	<meta name="submenu" content="problems" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block tabs">
							<div class="hd">
								<ul>
									<li><a href="/admin/">Summary</a></li>
									<li class="active"><a href="/admin/problems">Manage Problems</a></li>
									<li><a href="/admin/users">Manage Users</a></li>
									<li><a href="/admin/contests">Manage Contests</a></li>
									<li><a href="/admin/submissions">Manage Submissions</a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								<h3>Pending Problems</h3>
								<table class="zebra" id="pending" summary="Pending Problems">
								<col width="100" />
								<col width="*" />
								<col width="100" />
								<col width="220" />
								<thead>
								<tr>
									<th>PID</th>
									<th>TITLE</th>
									<th>STATUS</th>
									<th>ACTION</th>
								</tr>
								<tbody><c:choose><c:when test="${problems != null}"><c:forEach var="problem" items="${problems}">
									<tr>
										<td>${problem.id}</td>
										<td><a href="/admin/problem/${problem.id}">${problem.title}</a></td>
										<td class="submit-status ${problem.status}">${problem.status}</td>
										<td>
											<c:if test="${problem.status != 'Accepted' }"><button type="button" onclick="changeProblemStatus('${problem.id}','Accepted')"><img src="/images/accept_page.png" alt="" border="0" /> Accept</button></c:if>
											<c:if test="${problem.status != 'Rejected' }"><button type="button" onclick="changeProblemStatus('${problem.id}','Rejected')"><img src="/images/block.png" alt="" border="0" />  Reject</button></c:if>
											<c:if test="${problem.status == 'Rejected' }"><button type="button" onclick="deleteProblem('${problem.id}')"><img src="/images/delete_page.png" alt="" border="0" /> Delete</button></c:if>
										</td>	
									</tr></c:forEach></c:when><c:otherwise><tr><td class="center" colspan="4"><em>No Problems</em></td></tr></c:otherwise></c:choose>
								</tbody>
								</thead>
								</table>
								<hr />
								<h3>Active Problems</h3>
								<table class="zebra" id="active" summary="Active Problems">
								<col width="100" />
								<col width="*" />
								<col width="100" />
								<col width="220" />
								<thead>
								<tr>
									<th>PID</th>
									<th>TITLE</th>
									<th>STATUS</th>
									<th>ACTION</th>
								</tr>
								<tbody><c:choose><c:when test="${allProblems != null}"><c:forEach var="problem" items="${allProblems}">
									<tr>
										<td>${problem.id}</td>
										<td><a href="/admin/problem/${problem.id}">${problem.title}</a></td>
										<td class="submit-status ${problem.status}">${problem.status}</td>
										<td>
											<c:if test="${problem.status != 'Accepted' }"><button type="button" onclick="changeProblemStatus('${problem.id}','Accepted')"><img src="/images/accept_page.png" alt="" border="0" /> Accept</button></c:if>
											<c:if test="${problem.status != 'Rejected' }"><button type="button" onclick="changeProblemStatus('${problem.id}','Rejected')"><img src="/images/block.png" alt="" border="0" /> Reject</button></c:if>
											<button type="button" onclick="deleteProblem('${problem.id}')"><img src="/images/delete.png" alt="" border="0" /> Delete</button>
										</td>	
									</tr></c:forEach></c:when><c:otherwise><tr><td class="center" colspan="4"><em>No Problems</em></td></tr></c:otherwise></c:choose>
								</tbody>
								</thead>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<c:if test="${admin != null}">
						<form:form name="problemStatusForm" action="/admin/problem" method="put"></form:form>
						<form:form name="problemDeleteForm" action="/admin/problem" method="delete"></form:form>
						<script type="text/javascript">
						//<![CDATA[
							$(document).ready(function() {
								<c:if test="${problems != null}">$('#pending').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false});</c:if>
								<c:if test="${allProblems != null}">$('#active').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false});</c:if>
							} );
							function changeProblemStatus(problemId, statusValue) {
								if ( confirm('Are you sure?\n') ) {
									var status = document.createElement("input");
									status.type = "hidden";
									status.name = "status";
									status.value = statusValue;

									document.problemStatusForm.appendChild(status);
									document.problemStatusForm.action="/admin/problem/"+problemId;
									document.problemStatusForm.submit();
								}
								return false;
							}
						
							function deleteProblem(problemId) {
								if ( confirm('Are you sure?\n') ) {
									document.problemDeleteForm.action="/admin/problem/"+problemId;
									document.problemDeleteForm.submit();
								}
								return false;
							}
						//]]>
						</script>
						</c:if>
</body>
</html>