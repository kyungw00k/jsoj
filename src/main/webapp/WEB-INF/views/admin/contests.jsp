<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="admin" />
	<meta name="submenu" content="contests" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block tabs">
							<div class="hd">
								<ul>
									<li><a href="/admin/">Summary</a></li>
									<li><a href="/admin/problems">Manage Problems</a></li>
									<li><a href="/admin/users">Manage Users</a></li>
									<li class="active"><a href="/admin/contests">Manage Contests</a></li>
									<li><a href="/admin/submissions">Manage Submissions</a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								<h3>Running Contests</h3>
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
								<h3>Past Contests</h3>
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
							</div>
							<%@ include file="/common/ads.jsp"%>
						</div>
</body>
</html>