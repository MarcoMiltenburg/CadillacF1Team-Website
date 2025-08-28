<%

	IsDownloadBasket = False
	
	Function EventURL(TheSeriesID, TheEventID, TheSessionID, TheTopShots, ThePage, ExtraParams)
	
        QueryStringAdded = False
		S = SeriesURL(TheSeriesID) & "event"

		If (Len(TheEventID) <> 0) Then
			S = S  & "/" & TheEventID
		End If

		If (Len(TheSessionID) <> 0) Then
			S = S  & "/" & TheSessionID
		End If

		If (ThePage > 1) Then
			S = S  & "?p=" & CStr(ThePage)
            QueryStringAdded = True
		End If

        If TheTopShots Then
			If Not QueryStringAdded Then 
				S = S & "?"
                QueryStringAdded = True
			Else
				S = S & "&"
			End If
			S = S  & "topshots=1"
        End If

        EventURL = S & AddExtraParams(ExtraParams, QueryStringAdded)
        
	End Function
	
	Function PictureViewURL(TheSeriesID, TheEventID, TheSessionID, ThePictureID, TheTopShots)
	
		S = EventURL(TheSeriesID, TheEventID, TheSessionID, False, 0, Array())      ' --- TopShots must be False here, added below
	
		If (ThePictureID > 0) Then
			S = S & "/view/" & CStr(ThePictureID)
		End If
		
        If TheTopShots Then
            S = S & "?topshots=1"
        End If

		PictureViewURL = S
	
	End Function
	
	Function SearchURL(TheKeywords, ThePage, ExtraParams)
	
		QueryStringAdded = False
		S = "/search"

		If (Len(TheKeywords) <> 0) Then
			If Not QueryStringAdded Then 
				S = S & "?"
				QueryStringAdded = True
			Else
				S = S & "&"
			End If
			S = S  & "q=" & Server.URLEncode(TheKeywords)
		End If

		If (ThePage > 1) Then
			If Not QueryStringAdded Then 
				S = S & "?"
                QueryStringAdded = True
			Else
				S = S & "&"
			End If
			S = S  & "p=" & CStr(ThePage)
		End If

        SearchURL = S & AddExtraParams(ExtraParams, QueryStringAdded)
		
	End Function

	Function SearchViewURL(TheKeywords, PictureID, ThePage, ExtraParams)
	
		QueryStringAdded = False
		S = "/search-view"

		If (Len(TheKeywords) <> 0) Then
			If Not QueryStringAdded Then 
				S = S & "?"
				QueryStringAdded = True
			Else
				S = S & "&"
			End If
			S = S  & "q=" & Server.URLEncode(TheKeywords)
		End If

		If (PictureID <> 0) Then
			If Not QueryStringAdded Then 
				S = S & "?"
				QueryStringAdded = True
			Else
				S = S & "&"
			End If
			S = S  & "id=" & Server.URLEncode(CStr(PictureID))
		End If

		If (ThePage > 1) Then
			If Not QueryStringAdded Then 
				S = S & "?"
                QueryStringAdded = True
			Else
				S = S & "&"
			End If
			S = S  & "p=" & CStr(ThePage)
		End If

        SearchViewURL = S & AddExtraParams(ExtraParams, QueryStringAdded)
		
	End Function

	Function BasketURL(ThePage)
	
		S = "/basket"

		If (ThePage > 1) Then
			S = S  & "?p=" & CStr(ThePage)
		End If
		
		BasketURL = S

	End Function
	
    Function SeriesURL(TheSeriesID)
    
        SeriesURL = "/"
    
    End Function
	
	Function HomeUrl(IsLoggedIn)

		HomeUrl = "/"

	End Function

    Function AddExtraParams(ExtraParams, QueryStringAdded)
    
        Dim ParamNr, S
        
        S = ""
    
        If (IsArray(ExtraParams)) Then
            If (UBound(ExtraParams) >= 0) Then
            
                For ParamNr = 0 To UBound(ExtraParams)
                    If Not QueryStringAdded Then
                        S = S & "?"
                    Else
                        S = S & "&"
                    End If

                    QueryStringAdded = True
                    
                    S = S & ExtraParams(ParamNr)(0) & "=" & Server.UrlEncode(ExtraParams(ParamNr)(1))
                Next
                
            End If
        End If
        
        AddExtraParams = S

    End Function
	
	Function GetInitialSeason(DefaultSeason)

		If Not IsArray(Seasons) Then
			GetInitialSeason = DefaultSeason
			Exit Function
		End If

		If (UBound(Seasons) < 0) Then
			GetInitialSeason = DefaultSeason
			Exit Function
		End If

		MaxSeason = Seasons(UBound(Seasons))
		If (MaxSeason <> 0) And (MaxSeason < DefaultSeason) Then
			GetInitialSeason = MaxSeason
		Else
			GetInitialSeason = DefaultSeason
		End If

	End Function
	
	Function GetSeasonName(SeasonNr, AddSeasonPrefix)
	
		SeasonNrInt = ConvertLong(SeasonNr, 0)
		
		If (SeasonNrInt <= 0) Then
			GetSeasonName = "Invalid season"
			Exit Function
		End If
	
		If (SeasonNrInt >= 2019) Then
			If AddSeasonPrefix Then
				GetSeasonName = "Season " & CStr(SeasonNrInt)
			Else
				GetSeasonName = CStr(SeasonNrInt)
			End If
		ElseIf (SeasonNrInt = 1977) Then
			If AddSeasonPrefix Then
				GetSeasonName = "Season 1977-1979"
			Else
				GetSeasonName = "1977-1979"
			End If
		ElseIf ((SeasonNrInt >= 1980) And (SeasonNrInt <= 2018)) Then
			RoundedSeasonNr = (SeasonNrInt \ 10) * 10
			If (RoundedSeasonNr = 2010) Then
				UpToRoundedSeasonNr = 2018
			Else
				UpToRoundedSeasonNr = RoundedSeasonNr + 9
			End If
			
			If AddSeasonPrefix Then
				GetSeasonName = "Season " & CStr(RoundedSeasonNr) & "-" & CStr(UpToRoundedSeasonNr)
			Else
				GetSeasonName = CStr(RoundedSeasonNr) & "-" & CStr(UpToRoundedSeasonNr)
			End If
		Else
			GetSeasonName = "Unknown season"
		End If

	End Function
	
	Function DateTimeEncodedLink(RegularLink, DateTimeLink)
		If (Application("EnableDateTimeEncodedLinks")) Then
			DateTimeEncodedLink = XLpics.DateTimeEncodedLink(DateTimeLink, RegularLink)
		Else
			DateTimeEncodedLink = RegularLink
		End If
	End Function

    Function RemoveLineBreaks(S)
        TmpS = Replace(S, Chr(13) & Chr(10), " ")
        TmpS = Replace(TmpS, Chr(13), " ")
        RemoveLineBreaks = Replace(TmpS, Chr(10), " ")
    End Function
    
	Function ConvertLong(S, DefaultValue)
		LI = DefaultValue
		If (Len(S) > 0) And IsNumeric(S) Then
			LI = CLng(S)
		End If
		ConvertLong = LI
	End Function

	Function SidebarLink(CurrentEventID, CurrentSessionID, SeriesID, EventID, SessionID, LinkText)

		If (EventID = CurrentEventID AND SessionID = CurrentSessionID) Then

            %><li class="currentevent"><a href="<%=Server.HTMLEncode(EventURL(SeriesID, EventID, SessionID, False, 0, ""))%>"><%=Server.HTMLEncode(LinkText)%></a></li><%

		Else

            %><li><a href="<%=Server.HTMLEncode(EventURL(SeriesID, EventID, SessionID, False, 0, ""))%>"><%=Server.HTMLEncode(LinkText)%></a></li><%

		End If

	End Function

%><!--#include virtual="/includes/const.asp"-->