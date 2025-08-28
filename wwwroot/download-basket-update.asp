<!--#include virtual="/includes/common.asp"--><%

	SeriesID = 1

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	If (UCase(Request.QueryString("xml")) = "YES") Then
		XLpics.Page = XLpicsPage_UpdateDownloadBasketXML
	Else
		XLpics.Page = XLpicsPage_UpdateDownloadBasketRedirect
	End If
	XLpics.Init

	XLpics.DeInit
	Set XLpics = Nothing

%>