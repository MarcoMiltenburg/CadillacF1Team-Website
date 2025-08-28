<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_PicturesDownloadedByUsers
	XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="admin" class="homepage">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%>			<p class="error"><%=XLpics.FatalErrorMessage%></p>
<%

	Else

%>			<div id="contentarea">

<%

		SearchDate = XLpics.DownloadedPicturesDate
		DayLng = DatePart("d", SearchDate)
		MonthLng = DatePart("m", SearchDate)
		YearLng = DatePart("yyyy", SearchDate)
		
		UntilSearchDate = XLpics.DownloadedPicturesUntilDate
		UntilDayLng = DatePart("d", UntilSearchDate)
		UntilMonthLng = DatePart("m", UntilSearchDate)
		UntilYearLng = DatePart("yyyy", UntilSearchDate)

		PreviousDate = DateAdd("d", -1, SearchDate)
		NextDate = DateAdd("d", 1, SearchDate)
		
		PreviousUntilDate = DateAdd("d", -1, UntilSearchDate)
		NextUntilDate = DateAdd("d", 1, UntilSearchDate)

		SearchUserID = ConvertLong(Request.QueryString("suid"), 0)
		UserID = ConvertLong(Request.QueryString("userid"), -1)

		If (SearchUserID > 0) Then UserID = SearchUserID

%>				<div class="contentbottom">
					<div class="contenttop">

						<h2>Picture Downloads</h2>

						<div class="eventlinebottom">
							<div class="eventlinetop">

								<div class="selectionfilter">

									<form action="downloadedpictures.asp" method="get">
										<fieldset>

											<label class="downloadslabel"><span>View downloads from:</span></label>

											<select name="day" class="selectday">
												<option value="0">-Day-</option>
<%

		For i = 1 To 31

%>												<option<% If (DayLng = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

		Next

%>											</select>

											<select name="month" class="selectmonth">
												<option value="0">-Month-</option>
												<option value="1"<% If (MonthLng = 1) Then Response.Write (" selected=""selected""") %>>January</option>
												<option value="2"<% If (MonthLng = 2) Then Response.Write (" selected=""selected""") %>>February</option>
												<option value="3"<% If (MonthLng = 3) Then Response.Write (" selected=""selected""") %>>March</option>
												<option value="4"<% If (MonthLng = 4) Then Response.Write (" selected=""selected""") %>>April</option>
												<option value="5"<% If (MonthLng = 5) Then Response.Write (" selected=""selected""") %>>May</option>
												<option value="6"<% If (MonthLng = 6) Then Response.Write (" selected=""selected""") %>>June</option>
												<option value="7"<% If (MonthLng = 7) Then Response.Write (" selected=""selected""") %>>July</option>
												<option value="8"<% If (MonthLng = 8) Then Response.Write (" selected=""selected""") %>>August</option>
												<option value="9"<% If (MonthLng = 9) Then Response.Write (" selected=""selected""") %>>September</option>
												<option value="10"<% If (MonthLng = 10) Then Response.Write (" selected=""selected""") %>>October</option>
												<option value="11"<% If (MonthLng = 11) Then Response.Write (" selected=""selected""") %>>November</option>
												<option value="12"<% If (MonthLng = 12) Then Response.Write (" selected=""selected""") %>>December</option>
											</select>

											<select name="year" class="selectyear">
												<option value="0">-Year-</option>
<%

		For i = DatePart("yyyy", Date) To Application("FirstSeason") Step -1

%>												<option<% If (YearLng = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

		Next

%>											</select>

											<button type="submit" class="search">Search</button>
											<a href="<%=Server.HTMLEncode("downloadedpictures.asp?day=" & Datepart("d", PreviousDate) & "&month=" & DatePart("m", PreviousDate) & "&year=" & DatePart("yyyy", PreviousDate) & "&untilday=" & Datepart("d", PreviousUntilDate) & "&untilmonth=" & DatePart("m", PreviousUntilDate) & "&untilyear=" & DatePart("yyyy", PreviousUntilDate))%><% If (SearchUserID > 0) Then Response.Write ("&suid=" & SearchUserID)%>" class="previousday">Previous Day</a>
											<a href="<%=Server.HTMLEncode("downloadedpictures.asp?day=" & Datepart("d", NextDate) & "&month=" & DatePart("m", NextDate) & "&year=" & DatePart("yyyy", NextDate) & "&untilday=" & Datepart("d", NextUntilDate) & "&untilmonth=" & DatePart("m", NextUntilDate) & "&untilyear=" & DatePart("yyyy", NextUntilDate)) %><% If (SearchUserID > 0) Then Response.Write ("&suid=" & SearchUserID)%>" class="nextday">Next Day</a>
											
										</fieldset>
										<fieldset>

											<label class="downloadslabel"><span>Until:</span></label>

											<select name="untilday" class="selectday">
												<option value="0">-Day-</option>
<%

		For i = 1 To 31

%>												<option<% If (UntilDayLng = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

		Next

%>											</select>

											<select name="untilmonth" class="selectmonth">
												<option value="0">-Month-</option>
												<option value="1"<% If (UntilMonthLng = 1) Then Response.Write (" selected=""selected""") %>>January</option>
												<option value="2"<% If (UntilMonthLng = 2) Then Response.Write (" selected=""selected""") %>>February</option>
												<option value="3"<% If (UntilMonthLng = 3) Then Response.Write (" selected=""selected""") %>>March</option>
												<option value="4"<% If (UntilMonthLng = 4) Then Response.Write (" selected=""selected""") %>>April</option>
												<option value="5"<% If (UntilMonthLng = 5) Then Response.Write (" selected=""selected""") %>>May</option>
												<option value="6"<% If (UntilMonthLng = 6) Then Response.Write (" selected=""selected""") %>>June</option>
												<option value="7"<% If (UntilMonthLng = 7) Then Response.Write (" selected=""selected""") %>>July</option>
												<option value="8"<% If (UntilMonthLng = 8) Then Response.Write (" selected=""selected""") %>>August</option>
												<option value="9"<% If (UntilMonthLng = 9) Then Response.Write (" selected=""selected""") %>>September</option>
												<option value="10"<% If (UntilMonthLng = 10) Then Response.Write (" selected=""selected""") %>>October</option>
												<option value="11"<% If (UntilMonthLng = 11) Then Response.Write (" selected=""selected""") %>>November</option>
												<option value="12"<% If (UntilMonthLng = 12) Then Response.Write (" selected=""selected""") %>>December</option>
											</select>

											<select name="untilyear" class="selectyear">
												<option value="0">-Year-</option>
<%

		For i = DatePart("yyyy", Date) To Application("FirstSeason") Step -1

%>												<option<% If (UntilYearLng = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

		Next

%>											</select>

										</fieldset>
										<fieldset>

											<label class="downloadslabel"><span>User:</span></label>

											<select name="suid" class="selectuser">
												<option value="0">-All users-</option>
<%

		For j = 1 To XLpics.DownloadedPicturesUserList.Count
			
			ThisUser = XLpics.DownloadedPicturesUserList.Item(j)

%>												<option<% If (SearchUserID = ThisUser(0)) Then Response.Write (" selected=""selected""") %> value="<%=ThisUser(0)%>" class="<% If ThisUser(3) Then Response.Write("expired ")%><% If Not ThisUser(4) Then Response.Write("disabled ")%>"><%=ThisUser(2)%></option>
<%

		Next

%>											</select>

											<a href="<%=Server.HTMLEncode("downloadedpictures.asp?day=" & DayLng & "&month=" & MonthLng & "&year=" & YearLng & "&untilday=" & UntilDayLng & "&untilmonth=" & UntilMonthLng & "&untilyear=" & UntilYearLng)%>" class="allusers">All Users</a>
										</fieldset>
									</form>

								</div>

							</div>
						</div>

<%

		If (Len(XLpics.DownloadedPicturesMessage) <> 0) Then

%>						<p class="content"><%=Server.HTMLEncode(XLpics.DownloadedPicturesMessage)%></p>

<%

		Else

%>						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<div class="tabletitle">
									<span class="username">Username</span>
									<span class="companyname">Company Name</span>
									<span class="downloads">Downloads</span>
								</div>

<%

			For i = 1 To XLpics.DownloadedPictures.Count

				If XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_UserID) = UserID Then

%>								<a href="<%=Server.HTMLEncode("downloadedpictures.asp?day=" & DayLng & "&month=" & MonthLng & "&year=" & YearLng & "&untilday=" & UntilDayLng & "&untilmonth=" & UntilMonthLng & "&untilyear=" & UntilYearLng)%><% If (SearchUserID > 0) Then Response.Write ("&suid=" & SearchUserID)%>" onclick="return toggleDownloadedThumbnails()" class="tablerow">
									<span class="username"><%=Server.HTMLEncode(XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_Username))%></span>
									<span class="companyname"><%=Server.HTMLEncode(XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_CompanyName))%></span>
									<span class="downloads"><%=Server.HTMLEncode(XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_PicturesDownloaded))%></span>
								</a>

								<div id="downloadedthumbnails" style="display:block">

<%

					PicturesArray = XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_Pictures)

					For j = 0 To UBound(PicturesArray)

%>									<div class="downloadthumbnailbottom">
										<div class="downloadthumbnailtop">

											<div class="thumbnailholder">
												<div class="thumbnail">
													<table border="0" cellpadding="0" cellspacing="0"><tr><td valign="middle" align="center"><a href="<%=Server.HTMLEncode(PictureViewURL(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_SeriesID), PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_EventID), "", PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_PictureID), False))%>"><%

						If (Len(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_ThumbnailURL)) <> 0) Then

													%><img src="/thumbnails<%=PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_ThumbnailURL)%>" alt="" /><%

						Else

													%><img src="/images/no-preview-available.jpg" alt="" /><%

						End If

													%></a></td></tr></table>
												</div>
											</div>

											<div class="downloadthumbnailinfo">
												<p><span class="title">Filename</span><span class="value"><%=Server.HTMLEncode(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_PictureURL))%></span></p>
												<p><span class="title">Picture ID</span><span class="value"><a href="<%=Server.HTMLEncode(PictureViewURL(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_SeriesID), PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_EventID), "", PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_PictureID), False))%>"><%=Server.HTMLEncode(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_PictureID))%></a></span></p>
												<p><span class="title">Event ID</span><span class="value"><%=Server.HTMLEncode(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_EventID))%></span></p>
												<p><span class="title">Event name</span><span class="value"><%=Server.HTMLEncode(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_EventName))%>, <%=Server.HTMLEncode(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_SessionName))%></span></p>
												<p><span class="title">Downloads</span><span class="value"><%=Server.HTMLEncode(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_TimesDownloaded))%></span></p>
<%
						If (PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_TimesDownloaded) = 1) Then

%>												<p><span class="title">Downloaded at</span><span class="value"><%=Server.HTMLEncode(XLpics.FormatDateTime(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_FirstDownloadDateTime)))%></span></p>
<%

						Else

%>												<p><span class="title">First download</span><span class="value"><%=Server.HTMLEncode(XLpics.FormatDateTime(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_FirstDownloadDateTime)))%></span></p>
												<p><span class="title">Last download</span><span class="value"><%=Server.HTMLEncode(XLpics.FormatDateTime(PicturesArray(j)(XLpicsDownloadedPicturesCollection_PicturesField_LastDownloadDateTime)))%></span></p>
<%

						End If

%>											</div>

										</div>
									</div>

<%

					Next

%>								</div>

<%

				Else
%>								<a href="<%=Server.HTMLEncode("downloadedpictures.asp?day=" & DayLng & "&month=" & MonthLng & "&year=" & YearLng & "&untilday=" & UntilDayLng & "&untilmonth=" & UntilMonthLng & "&untilyear=" & UntilYearLng & "&userid=" & XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_UserID))%><% If (SearchUserID > 0) Then Response.Write ("&suid=" & SearchUserID)%>" class="tablerow">
									<span class="username"><%=Server.HTMLEncode(XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_Username))%></span>
									<span class="companyname"><%=Server.HTMLEncode(XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_CompanyName))%></span>
									<span class="downloads"><%=Server.HTMLEncode(XLpics.DownloadedPictures.Item(i)(XLpicsDownloadedPicturesCollectionField_PicturesDownloaded))%></span>
								</a>

<%

				End If

			Next

%>							</div>
						</div>

<%

		End If

%>					</div>
				</div>

			</div>

<%

	End If
	
%>	</main>

<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>