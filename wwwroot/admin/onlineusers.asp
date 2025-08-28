<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_ActivityCurrentUsers
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

				<div class="contentbottom">
					<div class="contenttop">

<%

		If (Len(XLpics.CurrentUsersMessage) <> 0) Then

%>						<p class="content"><%=Server.HTMLEncode(XLpics.CurrentUsersMessage)%></p>

<%

		Else

%>						<h2>Online Users</h2>

						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<div class="tabletitle">
									<span class="sessionid">Session ID</span>
									<span class="username">Username</span>
									<span class="ipaddress">IP address</span>
									<span class="lastactivity">Last activity</span>
								</div>

<%

			For i = 1 To XLpics.CurrentUsers.Count

%>								<div class="tablerow">
									<span class="sessionid"><%=Server.HTMLEncode(XLPics.CurrentUsers.Item(i)(0))%></span>
									<span class="username"><% If (Len(XLPics.CurrentUsers.Item(i)(2)) <> 0) Then Response.Write(Server.HTMLEncode(XLPics.CurrentUsers.Item(i)(2))) Else Response.Write("&nbsp;") %></span>
									<span class="ipaddress"><% If (Len(XLPics.CurrentUsers.Item(i)(3)) <> 0) Then Response.Write(Server.HTMLEncode(XLPics.CurrentUsers.Item(i)(3))) Else Response.Write("&nbsp;") %></span>
									<span class="lastactivity"><% If (Len(XLPics.CurrentUsers.Item(i)(4)) <> 0) Then Response.Write(Server.HTMLEncode(XLPics.CurrentUsers.Item(i)(4))) Else Response.Write("&nbsp;") %></span>
								</div>

<%

			Next

%>							</div>
						</div>

<%

		End If

%>					</div>
				</div>

			</div>

<%

	End If
	
%>	</main>

<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>