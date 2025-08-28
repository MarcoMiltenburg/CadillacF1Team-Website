<!DOCTYPE html>
<html lang="en">

<head>
<%

	Stylesheets = Array()
	Scripts = Array()

	Select Case XLpics.Page
	
		Case XLpicsPage_Homepage:
            Stylesheets = Array("main", "homepage")
            MetaDescription = "Photos Archive"
			Title = Metadescription

        Case XLpicsPage_Login, XLpicsPage_Logout:
            Stylesheets = Array("main", "login")
            MetaDescription = "Use the credentials provided to you to log in."
			Title = "Account"

        Case XLpicsPage_BrowseEvent:
            Stylesheets = Array("main", "thumbnailsgrid")
			Title = MetaDescription

        Case XLpicsPage_BrowseEventWithViewPicture, XLpicsPage_KeywordSearchWithViewPicture:
            Stylesheets = Array("main", "view")
            CurrentPicture = XLpics.PictureSearchCurrentPicture
			If IsArray(CurrentPicture) Then
				If (UBound(CurrentPicture) >= 0) Then
                    MetaDescription = RemoveLineBreaks(CurrentPicture(XLpicsPictureCollectionField_ShortCaption))
					Title = MetaDescription
                End If
            End If

        Case XLpicsPage_BrowseDownloadBasket:
            Stylesheets = Array("main", "thumbnailsgrid", "download")
            MetaDescription = "Download the pictures in your download basket."
			Title = "Download"
            
        Case XLpicsPage_KeywordSearch:
            Stylesheets = Array("main", "thumbnailsgrid")
            MetaDescription = "Search our archive with one or more keywords."
			Title = "Search"
            
		Case XLpicsAdminPage_Homepage, XLpicsAdminPage_ActivityCurrentUsers, XLpicsAdminPage_ActivitySessionHistory, XLpicsAdminPage_PicturesDownloadedByUsers, XLpicsAdminPage_PicturesFindWithCode, XLpicsAdminPage_PicturesEditCaption, XLpicsAdminPage_EventsList, XLpicsAdminPage_EventsSearch, XLpicsAdminPage_EventsEdit, XLpicsAdminPage_Help, XLpicsAdminPage_ToggleExclusiveGroup, XLpicsAdminPage_TogglePictureStatus, XLpicsAdminPage_TogglePictureTopShot:
			Stylesheets = Array("main", "admin-old")
			MetaDescription = "Administration"
			Title = MetaDescription

        Case Else
            Stylesheets = Array("main")
	
	End Select

%>	<title><%

	If (Len(Title) <> 0) Then
		If (Right(Title, 1) = ".") Then Title = Left(Title, Len(Title) - 1)
		Response.Write(Title & " - ")
	End If

	%>Cadillac Formula 1&reg; Team Photos</title>
	<meta charset="UTF-8">
<%

    If NoIndex Then

%>	<meta name="robots" content="noindex">
<%

    End If

	If IsDownloadBasket And (XLpics.TotalPictures > 0) Then
		If (UCase(Request.QueryString("download")) = "ZIP") Then

%>	<meta http-equiv="refresh" content="2; url=/basket/download/zip<% If (XLpics.AutoClearBasketAfterDownload) Then %>?autoclearbasket=on<% End If %>">
<%

		End If
	End If

%>	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%

    If (Len(MetaDescription) <> 0) Then
    
%>	<meta name="description" content="<%=Server.HtmlEncode(MetaDescription) %>">
<%

    End If

	For i = 0 To UBound(Stylesheets)

%>	<link rel="stylesheet" href="<%=Server.HTMLEncode(DateTimeEncodedLink("/css/" & Stylesheets(i) & ".css", "/css/" & Stylesheets(i) & ".$$datetime$$.css")) %>" type="text/css" media="screen">
<%

	Next

%>	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">	
	<link rel="icon" type="image/png" href="/img/favicons/favicon-96x96.png" sizes="96x96">
	<link rel="icon" type="image/svg+xml" href="/img/favicons/favicon.svg">
	<link rel="shortcut icon" href="/favicon.ico">
	<link rel="apple-touch-icon" sizes="180x180" href="/img/favicons/apple-touch-icon.png">
	<meta name="apple-mobile-web-app-title" content="Cadillac Formula 1 Team Media">
	<link rel="manifest" href="/site.webmanifest">
</head>

<body>

