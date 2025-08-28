<%

	SeriesID = 1

%><!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

	Function GetPageURL(TheSeriesID, TheEventID, TheSessionID, TheTopShots, TheKeywords, ThePage)
        
        Dim ExtraParams
        ExtraParams = Array()
        
        SearchPortrait = CBool(UCase(Request.QueryString("portrait")) = "ON")
        SearchLandscape = CBool(UCase(Request.QueryString("landscape")) = "ON")
        
        If SearchPortrait And SearchLandscape Then
            SearchPortrait = False
            SearchLandscape = False
        End If
        
        If SearchPortrait Then
            ReDim Preserve ExtraParams(UBound(ExtraParams) + 1)
            ExtraParams(UBound(ExtraParams)) = Array("portrait", "on")
        End If
        
        If SearchLandscape Then
            ReDim Preserve ExtraParams(UBound(ExtraParams) + 1)
            ExtraParams(UBound(ExtraParams)) = Array("landscape", "on")
        End If

		GetPageURL = SearchURL(TheKeywords, ThePage, ExtraParams)
        
	End Function

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_KeywordSearch
	XLpics.Init

	IsKeywordSearch = True
	
%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="main" class="search">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%><!--#include virtual="/includes/errormessages.asp"-->
<%

	Else

%>            <div class="pictures">
		
<%

		If (Len(XLpics.PictureSearchMessage) <> 0) Or (IsNull(XLpics.PictureSearch)) Then

%>				<ol class="notifications">
					<li class="warning"><%=Server.HTMLEncode(XLpics.PictureSearchMessage)%></li>
				</ol>

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
					<a href="/basket/add/<%=Left(PictureIDs, Len(PictureIDs) - 1)%>?size=<%=PictureSize%>" class="basket addall" title="Add all to basket">Add all to basket</a>
				</div>

<%

				End If

			End If

			'  --- Set keywords. used in page navigation links
			Keywords = XLpics.KeywordSearch
			
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