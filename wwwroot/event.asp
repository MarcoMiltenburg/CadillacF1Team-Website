<%

	SeriesID = 1

%><!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

	Function GetPageURL(TheSeriesID, TheEventID, TheSessionID, TheTopShots, TheKeywords, ThePage)
		GetPageURL = EventURL(TheSeriesID, TheEventID, TheSessionID, TheTopShots, ThePage, Array())
	End Function

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_BrowseEvent
	XLpics.Init

	If (Len(XLpics.PictureSearchTitle) <> 0) Then
		MetaDescription = XLpics.PictureSearchTitle
	End If

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="main" class="event">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%><!--#include virtual="/includes/errormessages.asp"-->
<%

	Else

%>		    <div class="pictures">
		
<%

		If (Len(XLpics.PictureSearchMessage) <> 0) Or (IsNull(XLpics.PictureSearch)) Then

%>				<ol class="notifications">
<%

            If (XLpics.PictureSearchMessage = "No pictures found.") Then

%>                  <li class="warning">Invalid event and/or session specified!</li>
<%

            Else

%>					<li class="warning"><%=Server.HTMLEncode(XLpics.PictureSearchMessage)%></li>
<%

            End If

%>				</ol>

<%

		Else
			
%>				<h1><%=Server.HTMLEncode(XLpics.PictureSearchTitle)%></h1>

				<p><%=XLpics.TotalPictures%> Picture<% If (XLpics.TotalPictures <> 1) Then Response.Write ("s") %><% If (XLpics.TotalPages > 1) Then %> - Displaying page <%=XLpics.BrowsePage%> of <%=XLpics.TotalPages%><% End If %></p>

<%

			PictureIDs = ""
			PictureSize = -1
			
			If (XLpics.PictureSearch.Count > 0) Then

				For j = 1 To XLpics.PictureSearch.Count
				
					If (PictureSize < 0) Then
						PictureSizes = XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureSizes)
						If IsArray(PictureSizes) Then
							If (UBound(PictureSizes) >= 0) Then
							
								PictureSize = PictureSizes(0)(XLpicsPictureCollection_PictureSizesFields_PictureSizeID)
								
							End If
						End If
					End If
					
					PictureIDs = PictureIDs & XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID) & ","
					
				Next
				
				If (Len(PictureIDs) <> 0) And (PictureSize > 0) Then
			
%>				<div class="actions">
					<a href="/basket/add/<%=Left(PictureIDs, Len(PictureIDs) - 1)%>?size=<%=PictureSize%>" class="basket addall" title="Add all to basket" rel="noindex">Add all to basket</a>
				</div>

<%

				End If

			End If

			'  --- Set series ID, event ID and session ID, used in page navigation links
            SeriesID = XLpics.SeriesID
			EventID = XLpics.EventID
			SessionID = XLpics.SessionID

%><!--#include virtual="/includes/picturesearch-pagenavigation.asp"-->

<!--#include virtual="/includes/picturesearch.asp"-->

<!--#include virtual="/includes/picturesearch-pagenavigation.asp"-->

<%

		End If

	End If

%>			</div>

		</main>

<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>