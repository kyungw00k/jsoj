<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="about" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
						<div class="block tabs">
							<div class="hd">
								<ul>
									<li><a href="/about"><spring:message code="intro.about.tutorials"/></a></li>
									<li class="active"><a href="/sandbox"><spring:message code="intro.about.sandbox"/></a></li>
								</ul>
								<div class="clear"></div>
							</div>
							<div class="bd">
								<h3><img src="/images/process.png" alt="" border="0" /> <spring:message code="console.title"/></h3>
								<table style="margin:0;padding:0">
								<tr>
									<td style="padding:0;vertical-align:bottom"><a href="http://www.downloadsquad.com/2009/03/11/five-sandboxing-apps-to-protect-your-windows-computer/" target="_new"><img src="http://www.blogcdn.com/www.downloadsquad.com/media/2009/03/sandbox-asdf-sad-fa-wer-2q3.jpg" alt="Daddy says..." height="200"/></a></td>
									<td style="padding:0;vertical-align:bottom">
										<h5>Argument Type(<em>arg</em>)</h5>
										<xmp>"hello"                     // Literal</xmp>
										<xmp>[ arg1, arg2, ..., arg(n) ] // Array</xmp>
										<xmp>{ say : 'hello', ... }      // Object</xmp>
										<h5><spring:message code="console.input"/> Format</h5>
										<xmp>arg1, arg2, ... , arg(n) // Test Case 1</xmp>
										<xmp>arg1, arg2, ... , arg(n) // Test Case 2</xmp>
										<xmp>arg1, arg2, ... , arg(n) // Test Case k</xmp>
									</td>
								</tr>
								</table>
								<form action="/sandbox" method="post">
									<table class="sandbox">
										<thead>
										<tr>
											<th><spring:message code="console.input"/></th>
											<th><spring:message code="console.output"/></th>
										</tr>
										</thead>
										<tbody>
										<tr>
											<td class="input">
												<textarea name="argument" rows="10" cols="80" class="line-box">${fn:escapeXml(argument)}</textarea>
												<span class="info"><spring:message code="console.input.desc"/></span>
											</td>
											<td class="output">
												<textarea rows="10" cols="80" class="line-box console" wrap="off" readonly="readonly">${fn:escapeXml(output)}</textarea>
												<span class="info"><spring:message code="console.output.desc"/></span>
											</td>
										</tr>
										</tbody>
									</table>
									<div>
										<h4><img src="/images/edit.png" alt="" border="0" /> <spring:message code="pasteYourCode"/></h4>
										<div class="line-box">
											<textarea id="code" name="code" class="text_area" style="border:0;width:100%" rows="20" cols="50">${fn:escapeXml(code)}</textarea>
										</div>
									</div><br />
									<p>
										<button class="button" type="submit">
										  <img src="/images/process.png" alt="" border="0" /> <spring:message code="run"/>
										</button>
									</p>
								</form>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript" src="/javascripts/edit_area/edit_area_full.js"></script>
						<script type="text/javascript">
						//<![CDATA[
						editAreaLoader.init({
							id: "code"		
							,start_highlight: true
							,allow_resize: "no"
							,allow_toggle: false
							,word_wrap: true
							,language: "en"
							,syntax: "js"
							,toolbar: "search, go_to_line, |, undo, redo, |, highlight, reset_highlight, |, help"
							,min_height: 350
							,font_size: "10"
							,replace_tab_by_spaces: 2
							,font_family: "'Courier New', verdana, monospace"
						});
						//]]>
						</script>
</body>
</html>