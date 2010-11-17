<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>

<c:choose><c:when test="${realYou}"><c:set var="userType" value="member.view.profile.my" /></c:when><c:otherwise><c:set var="userType" value="member.view.profile.other"/></c:otherwise></c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<c:choose><c:when test="${realYou}"><meta name="menu" content="profile" /></c:when><c:otherwise><meta name="menu" content="onlinejudge" /></c:otherwise></c:choose>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
						<div class="block">
							<div class="hd">
							<c:choose>
								<c:when test="${entry != null}">
									<spring:message code="${userType}" arguments="${entry.nickName}"/> <spring:message code="member.view.profile"/>
								</c:when>
								<c:otherwise>
									<spring:message code="member.view.nouser" arguments="${screenName}"/>
								</c:otherwise>
							</c:choose>								
							</div>
							<div class="bd">
							<c:choose>
								<c:when test="${entry != null}">
								<h3><img src="/images/info.png" alt="" border="0" /> <spring:message code="member.view.brief"/> <spring:message code="member.view.profile"/></h3>
								<table style="width:inherit" summary="${entry.nickName} <spring:message code="member.view.profile"/>">
									<tr>
										<th scope="row"><strong><spring:message code="member.view.user.name"/></strong></th>
										<td>${entry.fullName} ( <a href="http://twitter.com/${entry.nickName}" target="_new">@${entry.nickName}</a> )</td>
									</tr>
									<tr>
										<th scope="row"><strong><spring:message code="member.view.user.location"/></strong></th>
										<td>${entry.location}</td>
									</tr>
									<tr>
										<th scope="row"><strong><spring:message code="member.view.user.bio"/></strong></th>
										<td>${entry.description}</td>
									</tr>
								</table>
								<hr />
								<h3><img src="/images/chart_pie.png" alt="" border="0" /> <spring:message code="sidemenu.statistics"/></h3>
								<c:if test="${status.Accepted+status.PresentationError+status.WrongAnswer+status.RuntimeError+status.Timeout > 0}">
								<div id="pieChart">
									<img src="http://chart.apis.google.com/chart?cht=pc&chco=7A1818&chtt=@${entry.nickName}'s+Submissions&chd=t:${status.Accepted},${status.PresentationError},${status.WrongAnswer},${status.RuntimeError},${status.Timeout}&chs=500x300&chl=AC(${status.Accepted})|PE(${status.PresentationError})|WA(${status.WrongAnswer})|RTE(${status.RuntimeError})|TLE(${status.Timeout})&chdl=Accepted|Presentation+Error|Wrong+Answer|Runtime+Error|Time+Limit+Exceeded" alt="" border="0" />
								</div><br />
								</c:if>
								<h4><img src="/images/folder_accept.png" alt="" border="0" /> <spring:message code="member.view.user.solved"/></h4>
								<table class="zebra" id="submissions" summary="User Submission Status">
									<col width="120" />
									<col width="*" />
									<col width="120" />
									<col width="80" />
									<thead>
									<tr>
										<th>CODE</th>
										<th>Title</th>
										<th>Type</th>
										<th>Run time</th>
									</tr>
									</thead>
									<tbody>
									<c:choose>
									<c:when test="${submissions != null}">
									<c:forEach var="current" end="24" items="${submissions}">
									<tr>
										<td><a href="/problem/${current.key.id}">${current.key.id}</a></td>
										<td><a href="/problem/${current.key.id}">${current.key.title}</a></td>
										<td>${current.key.type}</td>
										<td><fmt:formatNumber value="${current.value.runtime}" pattern="0.000s" /></td>
									</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
									<tr><td class="center" colspan="5"><em><spring:message code="member.view.user.solved.none"/></em></td></tr>
									</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								<hr />
								<h3><img src="/images/folder.png" alt="" border="0" /> <spring:message code="member.view.user.makeproblem"/></h3>
								<table class="zebra" id="submitter">
									<col width="120" />
									<col width="*" />
									<col width="120" />
									<col width="80" />
									<col width="140" />
									<c:if test="${realYou}"><col width="140" /></c:if>
									<thead>
									<tr>
										<th>CODE</th>
										<th>Title</th>
										<th>Time Limit</th>
										<th>Accepted/Submitted</th>
										<th>Status</th>
										<c:if test="${realYou}"><th>Action</th></c:if>
									</tr>
									</thead>
									<tbody>
									<c:choose>
									<c:when test="${problems != null}">
									<c:forEach var="problem" end="24" items="${problems}">
									<tr>
										<td><a href="/problem/${problem.key.id}">${problem.key.id}</a></td>
										<td><a href="/problem/${problem.key.id}">${problem.key.title}</a></td>
										<td>
										<fmt:formatNumber value="${problem.key.timeLimit}" pattern="0.000s" /></td></td>
										<td><a href="<%--/stat/${problem.key.id}/--%>"><fmt:formatNumber type="percent" maxFractionDigits="2" groupingUsed="false" value="${problem.value.total == 0 ? 0.00 : problem.value.Accepted / problem.value.total}" /> (${problem.value.Accepted}/${problem.value.total})</a></td>
										<td><span class="submit-status ${problem.key.status}">${problem.key.status}</span></td>
										<c:if test="${realYou}"><td>
											<a class="inline-block button" href="/problem/${problem.key.id}/edit"><img src="/images/edit.png" alt="" border="0" /> Edit</a> 
											<c:if test="${problem.key.status != 'Accepted'}"><button type="button" onclick="confirmDelete('${problem.key.id}');"><img src="/images/delete.png" alt="" border="0" /> Delete</button></c:if>
										</td></c:if>
									</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
									<tr>
										<td class="center" colspan="${realYou ? '6' : '5'}"><em><spring:message code="member.view.user.makeproblem.none"/></em></td>
									</tr>
									</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								<c:if test="${realYou}">
								<button type="button" onclick="deleteMe();">
									<img src="/images/delete.png" alt="" border="0" /> <spring:message code="member.view.user.delete"/>
								</button>
								</c:if>
								</c:when>
								<c:otherwise>
									<spring:message code="member.view.nouser.detail" arguments="${screenName}"/>
								</c:otherwise>
							</c:choose>	
							<%@ include file="/common/ads.jsp"%>		
							</div>
						</div>
						<script type="text/javascript">
						//<![CDATA[
							<c:if test="${submissions != null}">$('#submissions').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false});</c:if>
							<c:if test="${problems != null}">$('#submitter').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false});</c:if>
						//]]>
						</script>
						<c:if test="${realYou}">
						<form name="deleteAccountForm" action="/deleteme" method="post"></form>
						<form:form name="deleteProblemForm" commandName="problem" method="delete"></form:form>
						<script type="text/javascript">
						//<![CDATA[
							function deleteMe() {
								if ( confirm('<spring:message code="member.view.user.delete.confirm"/>') ) {
									document.deleteAccountForm.submit();
								}
								return false;
							}
							
							function confirmDelete(problemId) {
								if ( confirm('<spring:message code="member.view.delete.problem.confirm"/>') ) {
									if ( !problemId.length ) {
										alert('<spring:message code="member.view.delete.problem.invalid"/>');
										return false;
									}
									document.deleteProblemForm.action="/problem/"+problemId;
									document.deleteProblemForm.submit();
								}
								return false;								
							}
						//]]>
						</script>
						</c:if>
</body>
</html>