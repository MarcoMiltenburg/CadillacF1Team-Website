<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_ActivitySessionHistory
	XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="admin" class="homepage">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%>			<p class="error"><%=XLpics.FatalErrorMessage%></p>
<%

	Else

		SearchDate = XLpics.SessionHistoryDate
		DayLng = DatePart("d", SearchDate)
		MonthLng = DatePart("m", SearchDate)
		YearLng = DatePart("yyyy", SearchDate)
		UserID = ConvertLong(Request.QueryString("userid"), -1)

%>				<div class="contentbottom">
					<div class="contenttop">

						<h2>Visitors History</h2>

						<div class="eventlinebottom">
							<div class="eventlinetop">

								<div class="selectionfilter">

									<form action="sessionhistory.asp" method="get">
										<fieldset>

											<label class="searchlabel"><span>View visitors on:</span></label>

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

        CurrentYear = DatePart("yyyy", Date)

		For i = CurrentYear To CurrentYear - 1 Step -1

%>												<option<% If (YearLng = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

		Next

		PreviousDate = DateAdd("d", -1, SearchDate)
		NextDate = DateAdd("d", 1, SearchDate)

%>											</select>

											<button type="submit" class="search">Search</button>
											<a href="visitorshistory.asp?day=<%=Datepart("d", PreviousDate)%>&month=<%=DatePart("m", PreviousDate)%>&year=<%=DatePart("yyyy", PreviousDate)%>" class="previousday">Previous Day</a>
											<a href="visitorshistory.asp?day=<%=Datepart("d", NextDate)%>&month=<%=DatePart("m", NextDate)%>&year=<%=DatePart("yyyy", NextDate)%>" class="nextday">Next Day</a>

										</fieldset>
									</form>

								</div>

							</div>
						</div>

<%

		If (Len(XLpics.SessionHistoryMessage) <> 0) Then

%>						<p class="content"><%=Server.HTMLEncode(XLpics.SessionHistoryMessage)%></p>

<%

		Else

%>						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<div class="tabletitle">
									<span class="sessionid">Session ID</span>
									<span class="username">Username</span>
									<span class="pageviews">Page views</span>
									<span class="firstpageview">First page view</span>
									<span class="lastpageview">Last page view</span>
								</div>

<%

			For i = 1 To XLpics.SessionHistory.Count

%>								<div class="tablerow">
									<span class="sessionid"><%=Server.HTMLEncode(XLPics.SessionHistory.Item(i)(0))%></span>
									<span class="username"><% If (Len(XLPics.SessionHistory.Item(i)(2)) <> 0) Then Response.Write(Server.HTMLEncode(XLPics.SessionHistory.Item(i)(2))) Else Response.Write("&nbsp;") %></span>
									<span class="pageviews"><%=Server.HTMLEncode(XLPics.SessionHistory.Item(i)(3))%></span>
									<span class="firstpageview"><%=Server.HTMLEncode(XLpics.FormatDateTime(XLPics.SessionHistory.Item(i)(4)))%></span>
									<span class="lastpageview"><%=Server.HTMLEncode(XLpics.FormatDateTime(XLPics.SessionHistory.Item(i)(5)))%></span>
								</div>

<%

			Next

%>							</div>
						</div>

<%

		End If

%>					</div>
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