<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
	<c:set var="menu"><decorator:getProperty property="meta.menu" /></c:set><c:set var="submenu"><decorator:getProperty property="meta.submenu" /></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="title" content="JavaScript Online Judge" />
	<meta name="keywords" content="javascript,online,judge" />
	<meta name="robots" content="noindex" />
	<meta name="author" content="parksama@gmail.com" />
	<meta name="description" content="Web-based JavaScript Online Judge" />
	<link rel="stylesheet" type="text/css" href="/stylesheets/theme/reset-fonts-grids.css"/>
	<link rel="stylesheet" type="text/css" href="/stylesheets/theme/yuiapp.css"/>
	<link rel="stylesheet" type="text/css" href="/stylesheets/theme/red.css"/>
	<link rel="stylesheet" type="text/css" href="/stylesheets/default.css"/>
	<link rel="stylesheet" type="text/css" href="/stylesheets/jquery.colortip-1.0.css"/>
	<link rel="stylesheet" type="text/css" href="/stylesheets/syntaxhighlighter/shCoreDefault.css"/><!--[if IE]>
	<link rel="stylesheet" type="text/css" href="/stylesheets/ie-patch.css" /><![endif]-->
	<script type="text/javascript" src="/javascripts/jquery.min.js"></script>
	<script type="text/javascript" src="/javascripts/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/javascripts/jquery.pngFix.pack.js"></script>
	<script type="text/javascript" src="/javascripts/jquery.tinycarousel.min.js"></script>
	<script type="text/javascript" src="/javascripts/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="/javascripts/jquery.oauthpopup.js"></script>
	<script type="text/javascript" src="/javascripts/syntaxhighlighter/shCore.js"></script>
	<script type="text/javascript" src="/javascripts/syntaxhighlighter/shBrushJScript.js"></script>
	<script type="text/javascript" src="/javascripts/syntaxhighlighter/shBrushXml.js"></script>

	<decorator:head />
	<title>JavaScript Online Judge</title>
</head>
<body class="rounded">
	<div id="doc3" class="yui-t5">
		<div id="hd">
			<h1 class="logo-text"><a href="/">JavaScript Online Judge</a></h1>
			<p class="logo-desc">Problem Solving on App Engine</p>
			<div id="navigation">
				<ul id="primary-navigation">
					<li <c:if test="${menu == 'home'}">class="active"</c:if>><a href="/"><spring:message code="menu.home"/></a></li>
					<li <c:if test="${menu == 'about'}">class="active"</c:if>><a href="/about"><spring:message code="menu.about"/></a></li>
					<li <c:if test="${menu == 'discussion'}">class="active"</c:if>><a href="/posts"><spring:message code="menu.discussion"/></a></li>
					<li <c:if test="${menu == 'onlinejudge'}">class="active"</c:if>><a href="/onlinejudge"><spring:message code="menu.onlinejudge"/></a></li>
					<%--
					<li <c:if test="${menu == 'contests'}">class="active"</c:if>><a href="/contests"><spring:message code="sidemenu.contests"/></a></li>
					 --%>
					<c:if test="${member != null}">
					<li <c:if test="${menu == 'profile'}">class="active"</c:if>><a href="/profile">@<c:out value="${member.nickName}" /></a></li>
					<li><a class="logout" style="color:white" href="/logout"><spring:message code="menu.logout"/></a></li>
					</c:if>
					<c:if test="${admin != null}">
					<li <c:if test="${menu == 'admin'}">class="active"</c:if>><a href="/admin"><spring:message code="menu.admin"/></a></li>
					</c:if>
				</ul>
				<div class="clear"></div>
			</div>
			<c:if test="${member == null}">
			<div class="signInTwitter"><a href="#" id="connect" target="_self"><img alt="Sign in with Twitter" src="/images/oauth/twitter.png" /></a></div>
			</c:if>
		</div>
		<div id="bd">
			<c:if test="${error != null && fn:length(error) > 0}"><p class="alert error">${error}</p></c:if>
			<c:if test="${warning != null && fn:length(warning) > 0}"><p class="alert warning">${warning}</p></c:if>
			<c:if test="${message != null && fn:length(message) > 0}"><p class="alert notice">${message}</p></c:if>
			<div id="yui-main">
				<div class="yui-b">
					<div class="yui-g">
						<decorator:body />
					</div>
				</div>
			</div>
			<div id="sidebar" class="yui-b">
				<div class="block">
					<div class="hd"><h2><spring:message code="sidemenu.quicklink"/></h2></div>
					<div class="bd"><c:if test="${member != null}">
						<h3 class="img_process"><spring:message code="sidemenu.tools"/></h3>
						<ul class="biglist">
							<li class="first <c:if test="${submenu == 'submit'}">highlight</c:if>"><a href="/submits" title="<spring:message code="sidemenu.submitcode"/>"><spring:message code="sidemenu.submitcode"/></a></li>
							<li class="<c:if test="${submenu == 'newproblem'}">highlight</c:if>"><a href="/problem/add"><spring:message code="sidemenu.submitproblem"/></a></li>
						</ul></c:if>
						<h3 class="img_search"><spring:message code="sidemenu.browseproblem"/></h3>
						<ul class="biglist">
							<li class="<c:if test="${submenu == 'problem'}">highlight</c:if>"><a href="/problem"><spring:message code="sidemenu.problems"/></a></li>
						</ul>
						<h3 class="img_chart"><spring:message code="sidemenu.statistics"/></h3>
						<ul class="biglist">
							<li class="<c:if test="${submenu == 'ranks'}">highlight</c:if>"><a href="/ranks"><spring:message code="sidemenu.ranklint"/></a></li>						
							<li class="<c:if test="${submenu == 'status'}">highlight</c:if>"><a href="/status"><spring:message code="sidemenu.submissions"/></a></li>
						</ul>
					</div>
				</div>
				<div class="block"><%-- Twitter Widget --%>
					<script type="text/javascript" src="http://widgets.twimg.com/j/2/widget.js"></script>
					<script type="text/javascript">
					new TWTR.Widget({
					  version: 2, type: 'list', rpp: 30, interval: 6000, title: '', subject: 'JavaScript News',
					  width: 'auto', height: 200,
					  theme: { shell: { background: '#7a1818', color: '#ffffff' }, tweets: { background: '#ffffff', color: '#444444', links: '#7a1818' } },
					  features: { scrollbar: true, loop: false, live: true, hashtags: true, timestamp: true, avatars: true, behavior: 'all'}
					  }).render().setList('jsonlinejudge', 'javascript').start();
					</script>
				</div>
			</div>
		</div>
		<div id="ft">
			<p class="inner">
				<a href="http://validator.w3.org/check?uri=referer" target="_blank"><img width="88" height="31" border="0" alt="Valid XHTML 1.0 Transitional" src="http://www.w3.org/Icons/valid-xhtml10" /></a>&nbsp;&nbsp;
				<a href="http://www.mathjax.org/" target="_blank"><img title="Powered by MathJax" height="31" src="http://www.mathjax.org/badge.gif" border="0" alt="Powered by MathJax" /></a>&nbsp;&nbsp;  
				<a href="http://twitter4j.org/" target="_blank"><img title="Powered by Twitter4J" height="31" src="/images/powered-by-twitter4j-border-138x30.gif" border="0" alt="Powered by Twitter4J" /></a>&nbsp;&nbsp;				
				<a href="http://code.google.com/appengine/" target="_blank"><img width="120" height="30" border="0" src="http://code.google.com/appengine/images/appengine-silver-120x30.gif" alt="Powered by Google App Engine" /></a>
			</p>
		</div>
		<script type="text/javascript">$(document).ready(function(){$('#connect').click(function(){$.oauthpopup({path: '/login/twitter?host='+window.location.host,callback: function(){window.location.reload();}});});SyntaxHighlighter.all();$(document).pngFix();});</script>
		<script type="text/javascript">var _gaq = _gaq || [];_gaq.push(['_setAccount', 'UA-18133272-1']);_gaq.push(['_trackPageview']);(function() {var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);})();</script>
		<%-- Tweetboard --%><%--<script type="text/javascript">var _tbdef = {user: 'jsonlinejudge'};(function(){var d = document;var tbjs = d.createElement('script'); tbjs.type = 'text/javascript';tbjs.async = true; tbjs.src = 'http://tweetboard.com/tb.js'; var tbel = d.getElementsByTagName('head')[0];if(!tbel) tbel = d.getElementsByTagName('head')[0]; tbel.appendChild(tbjs);})();</script> --%>
		<%--<script type="text/javascript" src="/_ah/channel/jsapi"></script>
		<script type="text/javascript">
			var channelId = '${channel_id}';
			var channel = new goog.appengine.Channel(channelId);
			var socket = channel.open();
			socket.onmessage = function(evt) {
				alert(evt.data);
			};
		</script> --%>
	</div>
</body>
</html>