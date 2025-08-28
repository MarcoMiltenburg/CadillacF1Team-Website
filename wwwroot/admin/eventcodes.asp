<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_EventsList
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

				<div class="contentbottom">
					<div class="contenttop">

						<h2>Event Codes</h2>

						<div class="eventlinebottom">
							<div class="eventlinetop">

								<div class="selectionfilter">

									<form action="eventcodes.asp" method="get">
										<fieldset>

											<label class="searchlabel"><span>View :</span></label>

											<select name="year" class="selectviewevents">
												<option value="0">current events</option>
<%

		YearLng = XLpics.EventCodesYear

		For i = DatePart("yyyy", DateAdd("m", 6, Date)) To Application("FirstSeason") Step -1

%>												<option value="<%=i%>"<% If (YearLng = i) Then Response.Write (" selected=""selected""") %>>year <%=i%></option>
<%

		Next

%>											</select>

											<button type="submit" class="search">Search</button>
											
										</fieldset>
									</form>

								</div>

							</div>
						</div>

<%

		If (Len(XLpics.EventCodesMessage) <> 0) Then

%>						<p class="content"><%=Server.HTMLEncode(XLpics.EventCodesMessage)%></p>

<%

		End If

%>					</div>
				</div>

<%

		If (Len(XLpics.EventCodesMessage) = 0) Then

			EventCodes = XLpics.EventCodes

			For i = 0 To UBound(EventCodes)


%>				<div class="contentbottom">
					<div class="contenttop">

						<div class="line">&nbsp;</div>
						<h3><%=Server.HTMLEncode(XLpics.FormatStartEndDate(EventCodes(i)(XLpicsEventDataField_StartDate), EventCodes(i)(XLpicsEventDataField_EndDate)))%> - <%=Server.HTMLEncode(EventCodes(i)(XLpicsEventDataField_EventName))%></h3>

						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<div class="tabletitle">
									<span class="eventcode">Event code</span>
									<span class="session">Session</span>
									<span class="startdate">Start date</span>
									<span class="enddate">End date</span>
								</div>

<%

				SessionData = EventCodes(i)(XLpicsEventDataField_Sessions)

				For j = 0 To UBound(SessionData)

%>								<div class="tablerow">
									<span class="eventcode"><%=Server.HTMLEncode(EventCodes(i)(XLpicsEventDataField_EventID) & "#" & SessionData(j)(XLpicsEventData_SessionField_SessionID))%></span>
									<span class="session"><%=Server.HTMLEncode(SessionData(j)(XLpicsEventData_SessionField_ShortName))%></span>
									<span class="startdate"><%=Server.HTMLEncode(XLpics.FormatDateTime(SessionData(j)(XLpicsEventData_SessionField_StartDate)))%></span>
									<span class="enddate"><%=Server.HTMLEncode(XLpics.FormatDateTime(SessionData(j)(XLpicsEventData_SessionField_EndDate)))%><br /></span>
								</div>

<%

				Next

%>							</div>
						</div>

					</div>
				</div>

<%

			Next

		End If

%>			</div>

<%

	End If
	
%>		</main>

<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>