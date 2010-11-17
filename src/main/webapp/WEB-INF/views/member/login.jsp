<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="home" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body><!--
login.title=Please Sign in
login.message=Sign in first!
login.message.detail=If you see this page, then you must sign in first.
login.noaccount=No account yet?
						--><div class="block">
							<div class="hd">Please Sign in</div>
							<div class="bd">
								<table>
									<col width="100" />
									<tr>
										<td>
										<img src="/images/login.jpg" alt="Please sign in first!" width="100"/>
										</td>
										<td style="vertical-align:top;">
											<h3>Sign in first!</h3>
											<p>
												If you see this page, then you must sign in first.
											</p>
											<h3>No account yet?</h3>
											<p>
												Use <a href="https://twitter.com/signup" title="Sign Up Twitter!">"Sign up Twitter"</a>
											</p>
										</td>
									</tr>
								</table>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						
</body>
</html>