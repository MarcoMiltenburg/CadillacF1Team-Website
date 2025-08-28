<%

	Set XLpics = Server.CreateObject("XPBImages.XLpicsAdmin_1")
	XLpics.DatabaseConnectString = Application("DatabaseConnectString")
    XLpics.PicturesDirectory = Application("PicturesDirectory")
	XLpics.PictureFilenamePrefix = Application("PictureFilenamePrefix")
	XLpics.RequiredAdminGroups = Array("XPBAdmin")

    XLpics.SessionCookieName = Application("SessionCookieName")
    XLpics.SessionCookieDomain = Application("SessionCookieDomain")
    XLpics.SessionExpireHours = Application("SessionExpireHours")
    XLpics.PermanentCookieName = Application("PermanentCookieName")
    XLpics.PermanentCookieDomain = Application("PermanentCookieDomain")

%>