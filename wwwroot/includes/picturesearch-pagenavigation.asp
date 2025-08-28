<%

	PictureSearch_Page = XLpics.BrowsePage
	PictureSearch_TotalPages = XLpics.TotalPages

	If (PictureSearch_TotalPages > 1) Or ShowTotalPictures Then

		If (PictureSearch_TotalPages > 1) Then

			PictureSearch_StartPage = (((PictureSearch_Page - 1) \ 10) * 10) + 1
			PictureSearch_EndPage = PictureSearch_StartPage + 9
			If PictureSearch_EndPage > PictureSearch_TotalPages Then PictureSearch_EndPage = PictureSearch_TotalPages

			FastBackwardsPage = PictureSearch_StartPage - 10
			If FastBackwardsPage < 0 Then FastBackwardsPage = 1

			FastForwardPage = PictureSearch_StartPage + 10
			If FastForwardPage > PictureSearch_TotalPages Then FastForwardPage = PictureSearch_TotalPages

%>				<ol class="pagenavigation">
					<li class="previous">
						<ol><li><a href="<%=Server.HTMLEncode(GetPageURL(SeriesID, EventID, SessionID, XLpics.TopShots, Keywords, PictureSearch_Page - 1))%>" class="previouspage<%	If (PictureSearch_Page = 1) Then Response.Write(" disabled") %>" aria-label="Go to previous page"></a></li><%

			If (PictureSearch_TotalPages > 10) Then

						%><li><a href="<%=Server.HTMLEncode(GetPageURL(SeriesID, EventID, SessionID, XLpics.TopShots, Keywords, FastBackwardsPage))%>" class="fast previousfast<% If (PictureSearch_Page = 1) Then Response.Write (" disabled") %>" aria-label="Fast backwards to previous pages"></a></li><%

			End If

					%></ol></li>
					<li class="pages">
						<ol>
<%

				For PictureSearch_Counter = PictureSearch_StartPage To PictureSearch_EndPage


%>							<li><a href="<%=Server.HTMLEncode(GetPageURL(SeriesID, EventID, SessionID, XLpics.TopShots, Keywords, PictureSearch_Counter))%>"<% If PictureSearch_Counter = PictureSearch_Page Then Response.Write(" class=""current""") %> aria-label="Go to page <%=PictureSearch_Counter%>"><%=PictureSearch_Counter%></a></li>
<%

				Next
					
%>						</ol>
					</li>
					<li class="next">
						<ol><%

			If (PictureSearch_TotalPages > 10) Then
			
							%><li><a href="<%=Server.HTMLEncode(GetPageURL(SeriesID, EventID, SessionID, XLpics.TopShots, Keywords, FastForwardPage))%>" class="fast nextfast<% If (PictureSearch_Page >= PictureSearch_TotalPages) Then Response.Write (" disabled") %>" aria-label="Fast forward to next pages"></a></li><%

			End If

							%><li><a href="<%=Server.HTMLEncode(GetPageURL(SeriesID, EventID, SessionID, XLpics.TopShots, Keywords, PictureSearch_Page + 1))%>" class="nextpage<% If (PictureSearch_Page >= PictureSearch_TotalPages) Then Response.Write (" disabled") %>" aria-label="Go to next page"></a></li><%

						%></ol>
					</li>
				</ol>

<%
			
		End If
		
	End If

%>