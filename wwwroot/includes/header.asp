	<div class="navigation">
	
		<input type="checkbox" id="navtoggle" aria-label="Open or Close Menu">
		<label for="navtoggle">
			<span class="navtoggle-icon"><span></span><span></span><span></span><span></span></span>
			<i class="navtoggle-open"><span>Menu</span></i>
			<i class="navtoggle-close"><span>Close</span></i>
		</label>
		
		<nav>
			<div class="navtop">
				<a href="<%=HomeUrl(XLpics.UserLoggedIn)%>" class="home" title="Home"><span>Home</span></a>
			</div>
			
			<div class="navitems">
<%

    If (UBound(Seasons) >= 0) Then

%>				<div class="navheader">Seasons</div>
				<ul>
<%

        For i = UBound(Seasons) To 0 Step -1
        
%>						<li<% If (Seasons(i) = XLpics.Season) Then %> class="currentseason"<% End If %>><a href="/?season=<%=Seasons(i)%>"><%=Server.HTMLEncode(GetSeasonName(Seasons(i), True))%></a></li>
<%

        Next

%>				</ul>
<%

    End If

%>				<div class="navheader">Miscellaneous</div>
				<ul>
					<li><a href="/search?q=DriverImagery">Driver imagery</a></li>
					<li><a href="/event/f1-2026-racesuits">Race Suits</a></li>
					<li><a href="/search?q=SilverstoneFactory">Silverstone Factory</a></li>
					<li><a href="/search?q=TeamPersonnel">Team Personnel</a></li>
					<li><a href="/search?q=GraemeLowdon">Graeme Lowdon</a></li>
					<li><a href="/search?q=DanTowriss">Dan Towriss</a></li>
				</ul>

<%

	If XLpics.UserLoggedIn And XLpics.UserProfile_AdminEnabled And XLpics.HasAdminGroup("XPBAdmin") Then
	
%>				<div class="navheader">Admin</div>

				<div class="subtitle">Users</div>
				<ul>
					<li><a href="/admin/onlineusers.asp">View Online Users</a></li>
					<li><a href="/admin/visitorshistory.asp">Visitors History</a></li>
				</ul>
				
				<div class="subtitle">Events</div>
				<ul>
					<li><a href="/admin/eventcodes.asp">Events Overview</a></li>
				</ul>

				<div class="subtitle">Pictures</div>
				<ul>
					<li><a href="/admin/editcaption.asp">Edit Captions</a></li>
					<li><a href="/admin/downloadedpictures.asp">Downloaded pictures</a></li>
				</ul>
<%

	End If

%>            </div>

            <ul class="links">
<%

	If XLpics.UserLoggedIn Then

%>                <li><a class="login" href="/logout">Logout</a></li>
<%

	Else

%>                <li><a class="login" href="/login">Login</a></li>
<%

	End If

%>            </ul>

		</nav>
	
	</div>

	<header>
	
		<div class="logo">
            <a href="<%=HomeUrl(XLpics.UserLoggedIn)%>"><img src="/img/cadillac-f1-team-logo.svg" alt="Cadillac Formula 1&reg; Team"></a>
		</div>
		
		<div class="search">
			<form method="get" action="/search">
				<input name="q" type="search" value="<%=Server.HtmlEncode(XLpics.KeywordSearch)%>" placeholder="Search..." aria-label="Keyword search">
				<button type="submit" aria-label="Search"></button>
			</form>
		</div>

		<div class="shortcuts">
<%

	If XLpics.UserLoggedIn Then
	
		DisplayDownloadBasket = False
		DownloadBasketTotalPictures = 0
		
		DownloadBasket = XLpics.DownloadBasket

		If IsArray(DownloadBasket) Then
			If (UBound(DownloadBasket) >= 0) Then
				DisplayDownloadBasket = ShowDownloadBasket And True
				DownloadBasketTotalPictures = UBound(DownloadBasket) + 1
			End If
		End If

%>			<a href="/logout" class="account" aria-label="Logout"><div><span>Logout</span></div></a>
			<a href="/basket" id="downloadbasket" class="download" data-count="<%=DownloadBasketTotalPictures%>" aria-label="Download basket"><div><span>Download basket</span><em><%=DownloadBasketTotalPictures%> photo<% If (DownloadBasketTotalPictures <> 1) Then Response.Write("s") %></em></div></a>
<%

    Else

%>			<a href="/login" class="account" aria-label="Login"><div><span>Login</span></div></a>
<%

    End If

%>
		</div>
	
	</header>

	<div class="fullheight">
