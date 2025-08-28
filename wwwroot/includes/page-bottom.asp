
	<div id="overlay"></div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="<%=Server.HTMLEncode(DateTimeEncodedLink("/js/main.js", "/js/main.$$datetime$$.js")) %>"></script>
<%

    If XLpics.UserLoggedIn And XLpics.UserProfile_AdminEnabled Then

%>    <script src="<%=Server.HTMLEncode(DateTimeEncodedLink("/js/admin.js", "/js/admin.$$datetime$$.js")) %>"></script>
<%

    End If

	For i = 0 To UBound(Scripts)

%>	<script src="<%=Server.HTMLEncode(DateTimeEncodedLink("/js/" & Scripts(i) & ".js", "/js/" & Scripts(i) & ".$$datetime$$.js")) %>"></script>
<%

	Next

%>
<!--#include virtual="/includes/version.asp"-->
	
</body>

</html>