<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="admin" />
	<meta name="submenu" content="submissions" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block tabs">
							<div class="hd">
								<ul>
									<li><a href="/admin/">Summary</a></li>
									<li><a href="/admin/problems">Manage Problems</a></li>
									<li><a href="/admin/users">Manage Users</a></li>
									<li><a href="/admin/contests">Manage Contests</a></li>
									<li class="active"><a href="/admin/submissions">Manage Submissions</a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								Requeueing StandBy Submissions...
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
</body>
</html>