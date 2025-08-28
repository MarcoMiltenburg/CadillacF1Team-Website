<%

	SeriesID = 1

%><!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

	NoIndex = True

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_Logout
	XLpics.Init

	If Not XLpics.UserLoggedIn Then 
		Response.Redirect("/login")
		Response.End
	End If

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="main" class="logout">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%><!--#include virtual="/includes/errormessages.asp"-->
<%

	Else

%>		    <div class="content">

				<h1>Log out</h1>
				<p>Please click 'Log out' to confirm your log out.</p>

			    <form action="/logout" method="post" id="logout-form">

                    <fieldset>

<%

		If (Len(XLpics.LoginLogoutMessage) <> 0) Then

%>				        <ol class="notifications">
                            <li class="warning"><%=Server.HTMLEncode(XLpics.LoginLogoutMessage)%></li>
                        </ol>

<%

		End If

%>
                        <p>You are currently logged in with username: <b><%=XLpics.UserProfile_UserName%></b>.</p>
                        <ol class="form">
                            <li class="buttons">
                                <button type="submit" name="logout" value="logout" class="default">Log out</button>
                            </li>
                        </ol>
                    </fieldset>

                </form>

            </div>

		</main>
        
<%

    End If
    
%>
<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>