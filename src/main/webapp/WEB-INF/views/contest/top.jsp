<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<meta name="menu" content="contests" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Contests</title>
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="sidemenu.contests"/></h2></div>
							<div class="bd">
								<div class="center">
									<img src="/images/contest.jpg" alt="Contest!" height="180" border="0" /><br /><br />
									<em>Seize the day!</em>
								</div><br />
								
								<h3><img src="/images/clock.png" alt="" border="0" /> Running Contests</h3>
								<table class="zebra" id="running">
									<col width="150"></col>
									<col width="*"></col>
									<col width="120"></col>
									<col width="120"></col>
									<thead>
									<tr>
										<th>CID</th>
										<th>Title</th>
										<th>Start</th>
										<th>End</th>
									</tr>
									</thead>
									<tbody>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									</tbody>
								</table>
								<hr />
								<h3><img src="/images/clock.png" alt="" border="0" /> Past Contests</h3>
								<table class="zebra" id="past">
									<col width="150"></col>
									<col width="*"></col>
									<col width="120"></col>
									<col width="120"></col>
									<thead>
									<tr>
										<th>CID</th>
										<th>Title</th>
										<th>Start</th>
										<th>End</th>
									</tr>
									</thead>
									<tbody>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									</tbody>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript">
						//<![CDATA[
							$(document).ready(function() {
								$('#running').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false});
								$('#past').dataTable({"sPaginationType": "full_numbers", "bInfo": false, "bAutoWidth": false});
							} );
						//]]>
						</script>
</body>
</html>