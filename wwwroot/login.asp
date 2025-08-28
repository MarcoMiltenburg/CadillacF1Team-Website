<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

	NoIndex = True

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_Login
	XLpics.Init

	If XLpics.UserLoggedIn Then 
		Response.Redirect(HomeUrl(XLpics.UserLoggedIn))
		Response.End
	End If

%><!--#include virtual="/includes/page-top.asp"-->


    <div class="logincontainer">
    
        <main id="main" class="login">
        
            <div class="loginlogo">
                <img src="/img/cadillac-f1-team-logo.svg" alt="Cadillac Formula 1&reg; Team" />
            </div>

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%><!--#include virtual="/includes/errormessages.asp"-->
<%

	Else

%>		    <div class="content">

				<h1>Log in</h1>
				<p>This website is intended for the press/media and sponsors only. If you have an account, please login below:</p>

			    <form action="/login" method="post" id="login-form">

                    <fieldset>

<%

		If (Len(XLpics.LoginLogoutMessage) <> 0) Then

%>				        <ol class="notifications">
                            <li class="error"><%=Server.HTMLEncode(XLpics.LoginLogoutMessage)%></li>
                        </ol>
				
<%

		End If

%>                        <ol class="form">
                            <li>
                                <label for="id_username">Username</label>
                                <input id="id_username" type="text" name="username" value="<%=Server.HTMLEncode(XLpics.UserProfile_Username)%>"<% If (Len(XLpics.UserProfile_Username) = 0) Then Response.Write(" autofocus") %> />
                            </li>
                            <li>
                                <label for="id_password">Password</label>
                                <input type="password" name="password" id="id_password" value=""<% If (Len(XLpics.UserProfile_Username) <> 0) Then Response.Write(" autofocus") %> />
                            </li>
                            <li class="buttons">
                                <button type="submit" class="default">Log in</button>
                            </li>
                        </ol>
                    </fieldset>                
                    
                </form>

            </div>

		</main>

    </div>

<%

    End If
    
%><!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>