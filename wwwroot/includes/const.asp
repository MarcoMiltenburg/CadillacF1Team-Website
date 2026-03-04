<%

	IsDownloadBasket = False

    Const CadillacF1TeamSeriesID_F1 = 1

    AllSeries = Array(CadillacF1TeamSeriesID_F1)

	Seasons = Array()

	Select Case SeriesID

		Case CadillacF1TeamSeriesID_F1:		Seasons = Array(2025, 2026)

	End Select

    Const XLpicsPage_Homepage = 1
    Const XLpicsPage_Login = 2
    Const XLpicsPage_Logout = 3
    Const XLpicsPage_AccountExpired = 4
    Const XLpicsPage_AccountDisabled = 5
    Const XLpicsPage_BrowseEvent = 6
    Const XLpicsPage_BrowseEventWithViewPicture = 7
    Const XLpicsPage_ViewPicture = 8
    Const XLpicsPage_DownloadPicture = 9
    Const XLpicsPage_DownloadLimit = 10
    Const XLpicsPage_BrowseDownloadBasket = 11
    Const XLpicsPage_DownloadBasketAsZip = 12
    Const XLpicsPage_UpdateDownloadBasketXML = 13
    Const XLpicsPage_UpdateDownloadBasketRedirect = 14
    Const XLpicsPage_KeywordSearch = 15
    Const XLpicsPage_KeywordSearchWithViewPicture = 16
	Const XLpicsPage_LoginPopup = 17
    Const XLpicsPage_GeneralPage = 100
    Const XLpicsPage_AboutUs = 101
    Const XLpicsPage_Contact = 102
    Const XLpicsPage_TermsOfUsage = 103
    Const XLpicsPage_Register = 104
    Const XLpicsPage_Offline = 105
    Const XLpicsPage_Partners = 106
	Const XLpicsPage_PublicHomepage = 107
	Const XLpicsPage_WinterOlympicsDownloadAgreement = 501

	' --- Admin pages
    Const XLpicsAdminPage_Homepage = 1001
    Const XLpicsAdminPage_ActivityCurrentUsers = 1002
    Const XLpicsAdminPage_ActivitySessionHistory = 1003
    Const XLpicsAdminPage_PicturesDownloadedByUsers = 1004
    Const XLpicsAdminPage_PicturesFindWithCode = 1005
    Const XLpicsAdminPage_PicturesEditCaption = 1006
    Const XLpicsAdminPage_EventsList = 1007
    Const XLpicsAdminPage_EventsSearch = 1008
    Const XLpicsAdminPage_EventsEdit = 1009
    Const XLpicsAdminPage_Help = 1010
    Const XLpicsAdminPage_ToggleExclusiveGroup = 1011
	Const XLpicsAdminPage_TogglePictureStatus = 1012
	Const XLpicsAdminPage_TogglePictureTopShot = 1013
	Const XLpicsAdminPage_GetExclusiveGroups = 1014
	
    Const XLpicsPictureCollectionField_PictureID = 0
    Const XLpicsPictureCollectionField_Width = 1
    Const XLpicsPictureCollectionField_Height = 2
    Const XLpicsPictureCollectionField_Headline = 3
    Const XLpicsPictureCollectionField_ShortCaption = 4
    Const XLpicsPictureCollectionField_FullCaption = 5
    Const XLpicsPictureCollectionField_Copyright = 6
    Const XLpicsPictureCollectionField_City = 7
    Const XLpicsPictureCollectionField_ProvinceState = 8
    Const XLpicsPictureCollectionField_Country = 9
    Const XLpicsPictureCollectionField_StorageYear = 10
    Const XLpicsPictureCollectionField_EventID = 11
    Const XLpicsPictureCollectionField_SessionID = 12
    Const XLpicsPictureCollectionField_SeriesID = 13
    Const XLpicsPictureCollectionField_PictureDateTime = 14
    Const XLpicsPictureCollectionField_Posterlink = 15
    Const XLpicsPictureCollectionField_UploadDateTime = 16
    Const XLpicsPictureCollectionField_ThumbnailURL = 17
    Const XLpicsPictureCollectionField_PictureSizes = 18
    Const XLpicsPictureCollectionField_ExceedDownloadLimit = 19	
	Const XLpicsPictureCollectionField_AllowCountries = 20
	Const XLpicsPictureCollectionField_DisallowCountries = 21
	Const XLpicsPictureCollectionField_AllowGroups = 22
	Const XLpicsPictureCollectionField_DisallowGroups = 23
	Const XLpicsPictureCollectionField_ExclusiveGroups = 24
	Const XLpicsPictureCollectionField_TopShot = 25

    Const XLpicsPictureCollection_PictureSizesFields_PictureSizeID = 0
    Const XLpicsPictureCollection_PictureSizesFields_PictureSizeTag = 1
    Const XLpicsPictureCollection_PictureSizesFields_PictureSizeName = 2
    Const XLpicsPictureCollection_PictureSizesFields_PictureURL = 3
    Const XLpicsPictureCollection_PictureSizesFields_Filesize = 4

    Const XLpicsEventDataField_EventID = 0
    Const XLpicsEventDataField_EventName = 1
    Const XLpicsEventDataField_StartDate = 2
    Const XLpicsEventDataField_EndDate = 3
    Const XLpicsEventDataField_PhotoStatus = 4
    Const XLpicsEventDataField_Sessions = 5
	Const XLpicsEventDataField_HasTopShots = 6
    Const XLpicsEventDataField_EventDescription = 7
    Const XLpicsEventDataField_EventCircuit = 8
    Const XLpicsEventDataField_EventLocation = 9
    Const XLpicsEventDataField_SeriesID = 10

    Const XLpicsEventData_SessionField_SessionID = 0
    Const XLpicsEventData_SessionField_ShortName = 1
    Const XLpicsEventData_SessionField_StartDate = 2
    Const XLpicsEventData_SessionField_EndDate = 3
    Const XLpicsEventData_SessionField_PhotoStatus = 4

    Const XLpicsPageState_FillingInForm = 1
    Const XLpicsPageState_FormCompleted = 2

	' --- Admin constants
    Const XLpicsDownloadedPicturesCollectionField_UserID = 0
    Const XLpicsDownloadedPicturesCollectionField_Username = 1
    Const XLpicsDownloadedPicturesCollectionField_CompanyName = 2
    Const XLpicsDownloadedPicturesCollectionField_PicturesDownloaded = 3
    Const XLpicsDownloadedPicturesCollectionField_Pictures = 4

    Const XLpicsDownloadedPicturesCollection_PicturesField_DownloadID = 0
    Const XLpicsDownloadedPicturesCollection_PicturesField_PictureID = 1
    Const XLpicsDownloadedPicturesCollection_PicturesField_PictureSizeID = 2
    Const XLpicsDownloadedPicturesCollection_PicturesField_PictureTag = 3
    Const XLpicsDownloadedPicturesCollection_PicturesField_PictureURL = 4
	Const XLpicsDownloadedPicturesCollection_PicturesField_ThumbnailURL = 5
    Const XLpicsDownloadedPicturesCollection_PicturesField_EventID = 6
    Const XLpicsDownloadedPicturesCollection_PicturesField_EventName = 7
    Const XLpicsDownloadedPicturesCollection_PicturesField_SessionID = 8
    Const XLpicsDownloadedPicturesCollection_PicturesField_SessionName = 9
    Const XLpicsDownloadedPicturesCollection_PicturesField_SeriesID = 10
    Const XLpicsDownloadedPicturesCollection_PicturesField_TimesDownloaded = 11
    Const XLpicsDownloadedPicturesCollection_PicturesField_FirstDownloadDateTime = 12
    Const XLpicsDownloadedPicturesCollection_PicturesField_LastDownloadDateTime = 13

	Const XLpicsSeries_SeriesID = 0
	Const XLpicsSeries_SeriesName = 1
	Const XLpicsSeries_ThumbnailPictureID = 2

%>