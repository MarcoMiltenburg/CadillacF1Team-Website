<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_EventsEdit
	XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="admin" class="editevents">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%>			<p class="error"><%=XLpics.FatalErrorMessage%></p>
<%

	Else

		If (Len(XLpics.AdminMessage) <> 0) Then

%>				<p class="content"><%=Server.HTMLEncode(XLpics.AdminMessage)%></p>

<%

		Else

%>				<div class="contentbottom">
					<div class="contenttop">

						<h5>Edit Event</h5>
						<div class="line">&nbsp;</div>

						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<fieldset>
									<label class="fullwidth"><span>Event ID</span><input type="text" class="text" name="eventid" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Name</span><input type="text" class="text" name="eventname" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Description</span><textarea class="text" name="description" cols="20" rows="3"><%=Server.HTMLEncode("")%></textarea></label><br class="clearAll">
									<label class="fullwidth"><span>Venue</span><input type="text" class="text" name="circuit" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Location</span><input type="text" class="text" name="location" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Link visible on homepage</span><input type="checkbox" class="checkbox" name="listonhomepage" /></label><br class="clearAll">
									<label class="fullwidth"><span>Link visible on site</span><input type="checkbox" class="checkbox" name="listonserieshomepage" /></label><br class="clearAll">
								</fieldset>

							</div>
						</div>

					</div>
				</div>

				<div class="contentbottom">
					<div class="contenttop">

						<h5>Session 1</h5>
						<div class="line">&nbsp;</div>

						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<fieldset>
									<label class="fullwidth"><span>Session ID</span><input type="text" class="text" name="eventid" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Full name</span><input type="text" class="text" name="name" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Short name</span><input type="text" class="text" name="shortname" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Description</span><textarea class="text" name="description" cols="20" rows="2"><%=Server.HTMLEncode("")%></textarea></label><br class="clearAll">
									<label class="fullwidth"><span>Sports</span>
										<select class="select" name="series">
											<option value="1001">FIS World Cup Cross-Country</option>
											<option value="1002">FIS World Cup Nordic Combined</option>
											<option value="1003">FIS World Cup Ski Jumping</option>
											<option value="1004">IBU World Cup Biathlan</option>
											<option value="1005">FIS World Cup Skimarathon</option>
										</select></label><br class="clearAll">
									<label class="fullwidth"><span>Season</span>
										<select class="select" name="season">
											<option value="2008">2008/09</option>
											<option value="2007">2007/08</option>
											<option value="2006">2007/08</option>
										</select></label><br class="clearAll">
									<label class="fullwidth"><span>Start date/time</span></label><br class="clearAll">
									<label class="fullwidth"><span>Etart date/time</span></label><br class="clearAll">
								</fieldset>

							</div>
						</div>

					</div>
				</div>

				<div class="contentbottom">
					<div class="contenttop">

						<h5>Session 2</h5>
						<div class="line">&nbsp;</div>

						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<fieldset>
									<label class="fullwidth"><span>Session ID</span><input type="text" class="text" name="eventid" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Full name</span><input type="text" class="text" name="name" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Short name</span><input type="text" class="text" name="shortname" value="<%=Server.HTMLEncode("")%>" /></label><br class="clearAll">
									<label class="fullwidth"><span>Description</span><textarea class="text" name="description" cols="20" rows="2"><%=Server.HTMLEncode("")%></textarea></label><br class="clearAll">
									<label class="fullwidth"><span>Sports</span>
										<select class="select" name="series">
											<option value="1001">FIS World Cup Cross-Country</option>
											<option value="1002">FIS World Cup Nordic Combined</option>
											<option value="1003">FIS World Cup Ski Jumping</option>
											<option value="1004">IBU World Cup Biathlan</option>
											<option value="1005">FIS World Cup Skimarathon</option>
										</select></label><br class="clearAll">
									<label class="fullwidth"><span>Season</span>
										<select class="select" name="season">
											<option value="2008">2008/09</option>
											<option value="2007">2007/08</option>
											<option value="2006">2007/08</option>
										</select></label><br class="clearAll">
									<label class="fullwidth"><span>Start date/time</span></label><br class="clearAll">
									<label class="fullwidth"><span>Etart date/time</span></label><br class="clearAll">
								</fieldset>

							</div>
						</div>

					</div>
				</div>

<%

		End If

%>			</div>

<%

	End If
	
%>	</main>

<!--#include virtual="/includes/footer.asp"-->		
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>