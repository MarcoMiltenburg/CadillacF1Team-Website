<!--#include virtual="/includes/common.asp"--><%

	isAdmin = True

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

    XLpics.RequiredAdminGroups = Array()
	XLpics.Page = XLpicsAdminPage_TogglePictureStatus
	XLpics.Init

	XLpics.DeInit
	Set XLpics = Nothing

%>