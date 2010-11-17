<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta name="menu" content="onlinejudge" />
	<meta name="submenu" content="submit" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
						<div class="block">
							<div class="hd"><h2><spring:message code="sidemenu.submitcode"/></h2></div>
							<div class="bd">
								<form:form modelAttribute="submission" commandName="submission" action="/submit" method="post" onsubmit="return validateMe(this);">
									<p>
										<label for="text" class="inline-block">Problem Code <span id="pidValidation" class="validation"><form:errors path="problemId"/></span></label>
										<form:input path="problemId" cssClass="inline-block text" cssStyle="display:inilne;width:200px"/>
									</p>
									<p>
										<label for="code">
											<spring:message code="pasteYourCode"/>
											<span id="codeValidation" class="validation"><form:errors path="code"/></span>
										</label>
										<div class="line-box">
											<form:textarea path="code" cssClass="text_area" rows="10" cols="80" cssStyle="border:0;width:100%;height:350px" value="${code}"/>
										</div>
									</p><br />
									<p>
										<button class="button" type="submit">
										  <img src="/images/accept.png" alt="" border="0" /> Submit
										</button>
										<button class="button" type="reset">
										  <img src="/images/refresh.png" alt="" border="0" /> Reset
										</button>
									</p>
								</form:form>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script language="Javascript" type="text/javascript" src="/javascripts/edit_area/edit_area_full.js"></script>
						<script type="text/javascript">
						//<![CDATA[
						// initialisation
						editAreaLoader.init({
							id: "code"		
							,start_highlight: true
							,allow_resize: "no"
							,allow_toggle: false
							,word_wrap: true
							,min_height:350
							,language: "en"
							,syntax: "js"
							,toolbar: "search, go_to_line, |, undo, redo, |, highlight, reset_highlight, |, help"
							,font_size: "10"
							,replace_tab_by_spaces: 2
							,font_family: "'Courier New', verdana, monospace"
						});

				
						function validateMe(oForm) {
							var retVal = !oForm ||
										!oForm.problemId || 
										!oForm.code;
							 
							if ( !retVal && oForm.problemId.value.length < 1 ) {
								document.getElementById('pidValidation').innerHTML = "can't be blank";
								return false;
							}

							if ( !retVal && oForm.code.value.length < 1 ) {
								document.getElementById('codeValidation').innerHTML = "can't be blank";
								return false;
							}
							return true;
						}
						//]]>
						</script>

</body>
</html>