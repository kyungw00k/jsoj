<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="home" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Script Online Judge</title>
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="intro.top.title"/></h2></div>
							<div class="bd">
								<table id="tablestats">
									<tbody>
										<tr>
											<td><span>${totalSubmissions}</span><br /><a href="/status">Submissions</a><br /></td>
											<td><span>${totalProblems}</span><br /><a href="/problem">Problems</a><br /></td>
											<td><span>${totalMembers}</span><br /><a href="/ranks">Users</a><br /></td>
											<td><span>${totalDiscussions}</span><br /><a href="/posts">Discussions</a><br /></td>
											<td><span>${totalContests}</span><br /><a href="/contests">Contests</a><br /></td>
										</tr>
									</tbody>
								</table>
								<%-- News --%>
								<h3><img src="/images/full_page.png" alt="" border="0" /> Recent News</h3> 
								<table id="notice" class="blog">
								<tr><td>
								<c:choose><c:when test="${notices != null }"><c:forEach var="post" end="0" items="${notices}">
									<h4><a class="no-underline" href="/post/${post.id}">${post.title}</a></h4>
									<p class="author">
										Posted by @${post.member.nickName}, <img src="/images/comment.png" alt="" border="0" />${post.commentSize} comments, <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.created}" /> 
										<c:if test="${member != null && post.member.accountId != member.accountId}">
											<a class="small" href="/post/${post.id}/edit">(edit this)</a> 
											<a class="small" href="#" onclick="return deletePost('${post.id}');">(delete this)</a>
										</c:if>
									</p>
									<div class="body">${post.content}</div>
								</c:forEach></c:when><c:otherwise>
									Nothing
								</c:otherwise></c:choose>
								</td></tr></table><hr />
								<%-- Discussion --%>
								<h3><img src="/images/full_page.png" alt="" border="0" /> Recent Discussions <span class="small"><a href="/posts" class="small">(more)</a></span></h3>
								<table class="zebra">		
								<tbody>
								<c:choose><c:when test="${posts != null }"><c:forEach var="post" end="9" items="${posts}">
								<c:if test="${post.category != 'Notice'}">
								<tr>
									<td>
										<h4><a class="no-underline" href="/post/${post.id}">${post.title}</a></h4>
										<p class="author">
											Posted by @${post.member.nickName}, <img src="/images/comment.png" alt="" border="0" />${post.commentSize} comments (<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.created}" />)
											<c:if test="${member != null && post.member.accountId != member.accountId}">
												<a class="small" href="/post/${post.id}/edit">(edit this)</a> 
												<a class="small" href="#" onclick="return deletePost('${post.id}');">(delete this)</a>
											</c:if>
										</p>	
									</td>
								</tr></c:if></c:forEach></c:when><c:otherwise>
								<tr>
									<td>No Entry</td>
								</tr></c:otherwise>
								</c:choose></tbody></table>
								<%--<hr />
								<div class="contact">
									<h3 class="img_mail"><spring:message code="intro.top.contact"/></h3>
									<p><spring:message code="intro.top.contact.message" arguments="mailto:parksama@gmail.com"/></p>								
								</div> --%>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div><%--
						<script type="text/javascript">
						function twitterCallback(twitters) {
							var statusHTML = [];
							for (var i=0; i<twitters.length; i++){
								var username = twitters[i].user.screen_name;
								var logo = twitters[i].user_profile_image;
								var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
									return '<a href="'+url+'">'+url+'</a>';
								}).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
						  			return reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
								});
								statusHTML.push('<li>'+status+'<a href="http://twitter.com/'+username+'/statuses/'+twitters[i].id+'">&nbsp;<span class="data">'+relative_time(twitters[i].created_at)+'</span>'+'</a><div class="divisor"></div></li>');
								document.getElementById('twitter_update_list').innerHTML = statusHTML.join(''); 
							}	   
						}
						function relative_time(time_value) {
							var values = time_value.split(" ");
							time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
							var parsed_date = Date.parse(time_value);
							var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
							var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
							delta = delta + (relative_to.getTimezoneOffset() * 60);
							if (delta < 60) {
								return 'less than a minute ago';
							} else if(delta < 120) {
								return 'about a minute ago';
							} else if(delta < (60*60)) {
								return (parseInt(delta / 60)).toString() + ' minutes ago';
							} else if(delta < (120*60)) {
								return 'about an hour ago';
							} else if(delta < (24*60*60)) {
								return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
							} else if(delta < (48*60*60)) {
								return '1 day ago';
							} else {
								return (parseInt(delta / 86400)).toString() + ' days ago';
							}
						}
						</script> 
						<script type="text/javascript" src="https://twitter.com/statuses/user_timeline/jsonlinejudge.json?callback=twitterCallback&amp;count=5" type="text/javascript"></script>
						--%>
</body>
</html>