<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="about" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
						<div class="block tabs">
							<div class="hd">
								<ul>
									<li class="active"><a href="#"><spring:message code="intro.about.tutorials"/></a></li>
									<li><a href="/sandbox"><spring:message code="intro.about.sandbox"/></a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								<h2 class="book-cover-wrap">
									<a href="http://www.jellymuffin.com/generators/fordummies/" target="_new">
										<img  vspace="0" hspace="10" align="right" src="/images/dummies.jpg" alt="For Dummies" width="278" height="348" border="0" />
									</a>
								</h2>
								<div class="toc">
									<h3><spring:message code="intro.about.tutorials.toc"/></h3>
									<ol class="list">
										<li>
											<a href="#whatisit"><spring:message code="intro.about.tutorials.introduction"/></a>
										</li>
										<li>
											<a href="#forUsers"><spring:message code="intro.about.tutorials.forUsers"/></a>
											<ol class="list">
												<li><a href="#howtobegin"><spring:message code="intro.about.tutorials.forUsers.howtobegin"/></a></li>
												<li><a href="#howtowrite"><spring:message code="intro.about.tutorials.forUsers.howtowrite"/></a></li>
												<li><a href="#howtomake"><spring:message code="intro.about.tutorials.forUsers.howtomake"/></a></li>
											</ol>
										</li><%--
										<li><a href="#reference"><spring:message code="intro.about.tutorials.reference"/></a></li>--%>
									</ol>
								</div>

								<div id="whatisit">
									<h3><spring:message code="intro.about.tutorials.introduction"/></h3>
									<spring:message code="intro.about.tutorials.introduction.message"/>
								</div>
								
								<div id="forUsers">
									<h3><spring:message code="intro.about.tutorials.forUsers"/></h3>
									<ol class="list">
									<li id="howtobegin">
										<h4><spring:message code="intro.about.tutorials.forUsers.howtobegin"/></h4>
										<ol class="list">
											<li><spring:message code="intro.about.tutorials.forUsers.howtobegin.step1"/></li>
											<li><spring:message code="intro.about.tutorials.forUsers.howtobegin.step2" arguments="/problem"/></li>
											<li><spring:message code="intro.about.tutorials.forUsers.howtobegin.step3" arguments="/submit"/></li>
										</ol>
									</li>
									<li id="howtowrite">
										<h4><spring:message code="intro.about.tutorials.forUsers.howtowrite"/></h4>
										<p><spring:message code="intro.about.tutorials.forUsers.howtowrite.message" arguments="/sandbox"/></p>
									</li>
									<li id="howtomake">
										<h4><spring:message code="intro.about.tutorials.forUsers.howtomake"/></h4>
										<p><spring:message code="intro.about.tutorials.forUsers.howtomake.message"/></p>
									</li>
									</ol>
								</div>
								<%--
								<hr />
								<div id="forGeeks">
									<h3>For Geeks</h3>
									<ol class="list">
										<li id="systemEnv">
											<h4>Environment? Libraries?</h4>
											<table>
											<thead>
												<th>Category</th>
												<th>Description</th>
											</thead>
											<tbody>
												<tr>
													<th>Hosting</th>
													<td>Google App Engine</td>
												</tr>
												<tr>
													<th>Language</th>
													<td>Java</td>
												</tr>
												<tr>
													<th>
														Framework?<br />
														Libraries?
													</th>
													<td>
														<img src="/images/other/lib.jpg" alt="Libraries/Resources" width="374" height="818" border="0" />
													</td>
												</tr>
											</tbody>
											</table>
										</li>
										<li id="systemWorks">
											<h4>How this system works?</h4>
											<p>Comming Soon</p>
										</li>
									</ol>
								</div>
								<div id="reference">
									<h3>Reference Sites</h3>			
									<ul class="list">
										<li>
											<h5>Java</h5>
											<ul class="list">
												<li>http://calumleslie.blogspot.com/2008/06/simple-jvm-sandboxing.html</li>
												<li>http://worldwizards.blogspot.com/2009/08/java-scripting-api-sandbox.html</li>
												<li>http://codeutopia.net/blog/2009/01/02/sandboxing-rhino-in-java/</li>
												<li>http://today.java.net/pub/a/today/2006/09/21/making-scripting-languages-jsr-223-aware.html</li>
											</ul>			
										</li>
										<li>
											<h5>Google App Engine for Java</h5>
											<ul class="list">
												<li>http://code.google.com/p/twig-persist/</li>
												<li>http://gaejexperiments.wordpress.com/</li>
												<li>http://www.digitalsanctum.com/2009/07/02/google-app-engine-for-java-crud-with-jdo-spring-mvc/</li>
												<li>http://gae-java-persistence.blogspot.com/</li>
												<li>http://code.google.com/p/lotrepls/</li>
											</ul>
										</li>
									</ul>
								</div>--%>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
</body>
</html>