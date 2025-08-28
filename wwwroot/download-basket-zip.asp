<!--#include virtual="/includes/const.asp"--><%

 	On Error Resume Next

	Response.Expires = -1

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_DownloadBasketAsZip
	XLpics.Init

	XLpics.DeInit
	Set XLpics = Nothing

%>