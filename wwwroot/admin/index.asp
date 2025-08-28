<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_Homepage
	XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="admin" class="homepage">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%>			<p class="error"><%=XLpics.FatalErrorMessage%></p>
<%

	Else

%>			<div id="contentarea">
<%

		If (Len(XLpics.AdminMessage) <> 0) Then

%>				<p class="content"><%=Server.HTMLEncode(XLpics.AdminMessage)%></p>

<%

		End If

%>				<p>Choose your desired admin section in the menu.</p>

			</div>
<%

	End If

%>
	</main>

<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>