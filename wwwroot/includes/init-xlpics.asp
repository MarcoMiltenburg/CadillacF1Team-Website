<%

    Set XLpics = Server.CreateObject("XPBImages.XLpics_1")
    XLpics.DatabaseConnectString = Application("DatabaseConnectString")
    XLpics.PicturesDirectory = Application("PicturesDirectory")
	XLpics.TemporaryStorageDirectory = Application("TemporaryStorageDirectory")
	XLpics.PictureFilenamePrefix = Application("PictureFilenamePrefix")
    XLpics.FullCaptionRemoval = Application("FullCaptionRemoval")
    XLpics.MailPickupDirectory = Application("MailPickupDirectory")

    XLpics.UseStrictGroupsAccess = Application("UseStrictGroupsAccess")
    XLpics.UseStrictSeriesAccess = Application("UseStrictSeriesAccess")
	XLpics.UseOriginalFilenameForDownloads = Application("UseOriginalFilenameForDownloads")
    
    XLpics.SessionCookieName = Application("SessionCookieName")
    XLpics.SessionCookieDomain = Application("SessionCookieDomain")
    XLpics.SessionExpireHours = Application("SessionExpireHours")
    XLpics.PermanentCookieName = Application("PermanentCookieName")
    XLpics.PermanentCookieDomain = Application("PermanentCookieDomain")

    XLpics.SeriesID = SeriesID
    XLpics.Seasons = Seasons
    XLpics.InitialSeason = Application("DefaultSeason")

    XLpics.NrOfWeekToShowEventsOf = Application("NrOfWeekToShowEventsOf")
	XLpics.ForceUserToBeLoggedIn = Application("ForceUserToBeLoggedIn")
	XLpics.UsePasswordSaltAndHash = Application("UsePasswordSaltAndHash")
	XLpics.SystemWidePasswordSalt = Application("SystemWidePasswordSalt")
	XLpics.DefaultSortOrder = Application("DefaultSortOrder")

    XLpics.GridThumbnailSizeID = Application("GridThumbnailSizeID")
    XLpics.ViewThumbnailSizeID = Application("ViewThumbnailSizeID")

	If (Season <> 0) Then
		XLpics.Season = Season
	End If
	XLpics.InitialSeason = GetInitialSeason(Application("DefaultSeason"))

%>