<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta name="menu" content="onlinejudge" />
	<meta name="submenu" content="newproblem" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="/javascripts/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="/javascripts/ckeditor/adapters/jquery.js"></script>
</head>
<body>				
						<div class="block">
							<div class="hd"><h3><c:choose><c:when test="${isNew}"><spring:message code="sidemenu.submitproblem"/></c:when><c:otherwise><spring:message code="sidemenu.editproblem" arguments="${problem.title}"/></c:otherwise></c:choose></h3></div>
							<div class="bd">
								<form:form modelAttribute="problem" commandName="problem" action="/problem/${isNew ? 'save' : problem.id}" method="${isNew ? 'POST' : 'PUT' }">
									<p>
										<button class="button" type="submit">
										  <spring:message code="${isNew ? 'img.add_page' : 'img.edit'}"/> ${isNew ? 'Add' : 'Update'}
										</button>
										<button class="button" type="reset">
										  <img src="/images/refresh.png" alt="" border="0" /> Reset
										</button>
										<button class="button" type="button" onclick="redirectToProfile();">
										  <img src="/images/block.png" alt="" border="0" /> Cancel
										</button>
									</p>
									<hr />
									<c:if test="${isNew == false}"><form:hidden path="id" value="${problem.id}"/></c:if>
									<c:if test="${isNew == false}"><form:hidden path="created" value="${problem.created}"/></c:if>
									
									<div id="page-edit">
										<h3><img src="/images/tag_blue.png" alt="" border="0" /> <a href="#" class="no-underline">1. Problem Outline</a></h3>
										<div>
											<table class="zebra">
											<col width="100"/>
											<col width="250"/>
											<col width="*"/>
											<tr>
												<td rowspan="5"><label>Problem</label></td>
												<td><label>Type</label></td>
												<td>
													<form:select path="type" disabled="${isNew == false}">
														<form:option value="Core" label="Core"/>
														<%--<form:option value="DOM" label="DOM"/> --%>
													</form:select>
												</td>									
											</tr>
											<tr>
												<td><label for="id">Unique Code <span class="validation"><form:errors path="id" /></span></label></td>
												<td><c:choose><c:when test="${isNew}"><form:input path="id" cssClass="text" disabled="${isNew == false}" cssStyle="width:inherit"/></c:when><c:otherwise><input class="text" disabled="${isNew == false}" style="width:inherit" value="${problem.id}"/></c:otherwise></c:choose></td>
											</tr>
											<tr>
												<td><label for="title">Title <span class="validation"><form:errors path="title"/></span></label></td>
												<td><form:input path="title" cssClass="text"  /></td>
											</tr>
											<tr>
												<td><label>Author</label></td>
												<td><form:input path="author" value="${problem.author}" cssClass="text" /></td>
											</tr>
											<tr>
												<td><label>Source</label></td>
												<td><form:input path="source" value="${problem.source}" cssClass="text" /></td>
											</tr>
											<tr>
												<td rowspan="5"><label>Function</label></td>
												<td><label>Name  <span class="validation"><form:errors path="testFuncName"/></span></label></td>
												<td><form:input path="testFuncName" cssClass="text" cssStyle="width:inherit" value="${problem.testFuncName}" maxlength="32" /></td>
											</tr>
											<%--<tr>
												<td><label>Signature <span class="validation"><form:errors path="testFuncArgs"/></span></label></td>
												<td><form:input path="testFuncArgs" cssClass="text"  cssStyle="width:inherit;display:inline" value="${problem.testFuncArgs}" maxlength="32" /> <span class="info">Ex) arg1, arg2</span></td>
											</tr>
											<tr>
												<td><label>Return  <span class="validation"><form:errors path="testFuncReturn"/></span></label></td>
												<td>
													<form:select path="testFuncReturn">
														<form:option value="Number" />
														<form:option value="String" />
														<form:option value="Array" />
														<form:option value="XML" />
														<form:option value="Object" />
													</form:select>
												</td>
											</tr> --%>
											<tr>
												<td><label>Run Time Limit<br /><span class="validation"><form:errors path="timeLimit"/></span></label></td>
												<td><form:input path="timeLimit" value="${problem.timeLimit}" cssClass="text" cssStyle="display:inline;width:30px;text-align:right" />s</td>
											</tr>
											<tr>
												<td><label>Validation</label></td>
												<td>
													<form:select path="validationType">
														<form:option value="strict" label="Strict" />
														<form:option value="ignoreWhiteSpace" label="Ignore White Space" />
														<form:option value="ignoreTrailingSpace" label="Ignore Trailing Space" />
														<form:option value="ignoreTrailingEmptyLine" label="Ignore Trailing Empty Line" />
														<form:option value="relativeFloat" label="Relative Float" />
													</form:select>
												</td>
											</tr>
											</table>
										</div>
										<h3><img src="/images/tag_green.png" alt="" border="0" /> <a href="#" class="no-underline">2. Problem Description</a> <label><span class="validation"><form:errors path="description"/></span></label></h3>
										<div><%--
											<script type="text/javascript">$(function() {$("#desc-tabs").tabs();});</script>
											<div class="tabs" id="desc-tabs"><div class="hd">
												<ul>
													<li><a href="#desc-tabs-1"><label>Description <span class="validation"><form:errors path="description"/></span></label></a></li>
													<li><a href="#desc-tabs-2"><label>Preview</label></a></li>
												</ul>
												<div class="clear"></div></div>
											</div> --%>
											<div id="desc-tabs-1">
												<table>
													<tr><%--
														<td>
															<h5><a href="http://daringfireball.net/projects/markdown/basics" target="_new">Markdown Syntax</a></h5>
															<xmp>### Header 3</xmp>
															<xmp>> This is a blockquote.</xmp>
															<xmp>*em* _em_ **strong** __strong**</xmp>
														</td> --%>
														<td>
															<h5><a href="http://www.mathjax.org/demos/tex-samples/" target="_new">TeX Syntax</a></h5>
															<xmp>$2^{31}$</xmp>
															<xmp>$1 +  \frac{q^2}{(1-q)}+\frac{q^6}{(1-q)(1-q^2)}+\cdots =
		\prod_{j=0}^{\infty}\frac{1}{(1-q^{5j+2})(1-q^{5j+3})},
		\quad\quad \text{for} |q|<1.$</xmp>
														</td>
													</tr>
												</table>
												<textarea id="inputPane" name="description" class="text" style="overflow-y:auto;height:342px"><c:choose><c:when test="${isNew}">
## Description
blah

***
## The Argument(s)
blah blah

## The Return
blah blah
    
***
## Example
    a,b,c,d
    -> returns e
</c:when><c:otherwise>${fn:escapeXml(problem.description)}</c:otherwise></c:choose></textarea></div><%--
											<div id="desc-tabs-2" style="overflow-y:auto;vertical-align:top"><noscript><h2>You'll need to enable Javascript to use this tool.</h2></noscript></div>--%>
										</div>
										<h3><img src="/images/tag_blue.png" alt="" border="0" /> <a href="#" class="no-underline">3. Problem Test Case</a></h3>
										<div>
											<script type="text/javascript">$(function() {$("#input-tabs").tabs();});</script>
											<div class="tabs" id="input-tabs"><div class="hd">
												<ul>
													<li><a href="#input-tabs-1"><label>Test Input</label></a></li>
													<li><a href="#input-tabs-2"><label>Test Output <span class="validation"><form:errors path="testOutput"/></span></label></a></li>
												</ul>
												<div class="clear"></div></div>
											</div>
											<div id="input-tabs-1">
												<table>
													<tr>
														<td>
															<h5>Test Input Format</h5>
															<xmp>arg1, arg2, ... , arg(n) // Test Case 1</xmp>
															<xmp>arg1, arg2, ... , arg(n) // Test Case 2</xmp>
															<xmp>arg1, arg2, ... , arg(n) // Test Case k</xmp>
														</td>
														<td>
															<h5>Argument Type(<em>arg</em>)</h5>
															<xmp>"hello"                     // Literal</xmp>
															<xmp>[ arg1, arg2, ..., arg(n) ] // Array</xmp>
															<xmp>{ say : 'hello', ... }      // Object</xmp>
														</td>
													</tr>
												</table>
												<form:textarea path="testInput" value="${problem.testInput}" cssClass="text" cssStyle="height:150px" />
											</div>
											<div id="input-tabs-2">
												<table>
													<tr>
														<td>
															<h5>Test Output Format</h5>
															<xmp>hello                // String</xmp>
															<xmp>1981.11              // Number</xmp>
															<xmp>Hey,My,Name is,Array // Array Object</xmp>
														</td>
													</tr>
												</table>
												<form:textarea path="testOutput" value="${problem.testOutput}" cssClass="text" wrap="off" cssStyle="height:150px" />
											</div>
										</div>
										<h3><img src="/images/tag_green.png" alt="" border="0" /> <a href="#" id="globalScriptArea" class="no-underline">4. Global Scripts(Optional)</a></h3>
										<div>
											<form:textarea path="scriptGlobal" value="${problem.scriptGlobal}" cssClass="text" cssStyle="height:250px;margin-bottom:15px" />									
										</div>
									</div><hr />
									<p>
										<button class="button" type="submit">
										  <spring:message code="${isNew ? 'img.add_page' : 'img.edit'}"/> ${isNew ? 'Add' : 'Update'}
										</button>
										<button class="button" type="reset">
										  <img src="/images/refresh.png" alt="" border="0" /> Reset
										</button>
										<button class="button" type="button" onclick="redirectToProfile();">
										  <img src="/images/block.png" alt="" border="0" /> Cancel
										</button>
									</p>
								</form:form>
								<%@ include file="/common/ads.jsp"%>
							</div>
						</div>
						<script type="text/javascript" src="/javascripts/showdown.min.js"></script>
						<script type="text/javascript" src="/javascripts/MathJax/MathJax.js">MathJax.Hub.Config({config: ["MMLorHTML.js"],extensions: ["tex2jax.js"],jax: ["input/TeX"],tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]}});</script>
						<script type="text/javascript" src="/javascripts/edit_area/edit_area_full.js"></script>
						<script type="text/javascript">
						//<![CDATA[
						function redirectToProfile(){window.location='/profile';};
						$(document).ready(function() {
							var converter = new Showdown.converter();
							$('#inputPane').val(converter.makeHtml($('#inputPane').val()));
							$('#inputPane').ckeditor();<%--
							$('#inputPane').keyup(function(evt){
									 // MathJax.Hub.Queue(["Typeset",MathJax.Hub,MathJax.Hub.getAllJax( $('#inputPane').ckeditorGet() )]);
									SyntaxHighlighter.all();
								}
							);--%><%--
							$("#page-edit").accordion({autoHeight: false,navigation: true});
							--%><%--
							$('#globalScriptArea').click(function(evt){
								editAreaLoader.init({
									id: "scriptGlobal"
									,start_highlight: true
									,allow_resize: "no"
									,allow_toggle: false
									,word_wrap: true
									,language: "en"
									,syntax: "js"
									,min_height: 250
									,font_size: "10"
									,replace_tab_by_spaces: 2
									,font_family: "'Courier New', verdana, monospace"
								});
							});--%>
							editAreaLoader.init({
								id: "scriptGlobal"
								,start_highlight: true
								,allow_resize: "no"
								,allow_toggle: false
								,word_wrap: true
								,language: "en"
								,syntax: "js"
								,min_height: 250
								,font_size: "10"
								,replace_tab_by_spaces: 2
								,font_family: "'Courier New', verdana, monospace"
							});
							$('#id').keyup(function(evt){
								$('#id').val($('#id').val().toUpperCase());
								$('#testFuncName').val($('#id').val().toLowerCase());	
							});
						});
						//]]>
						</script>
						
						
</body>
</html>