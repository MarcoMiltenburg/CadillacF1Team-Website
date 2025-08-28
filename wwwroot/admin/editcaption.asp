<!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics-admin.asp"--><%

	XLpics.Page = XLpicsAdminPage_PicturesEditCaption
	XLpics.Init

	RememberBack = CBool(UCase(Request.QueryString("back")) = "YES")
	If RememberBack Then BackURL = Request.ServerVariables("HTTP_REFERER")
	If (Len(BackURL) = 0) Then
		BackURL = Request.Form("backurl")
	End If

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

						<h2>Edit Captions</h2>

						<div class="eventlinebottom">
							<div class="eventlinetop">

								<div class="selectionfilter">

									<form action="editcaption.asp" method="get">
										<fieldset>

											<label class="searchlabel"><span>Edit Picture ID:</span></label>

											<input type="text" class="text pictureid" name="pictureid" value="<% If (XLpics.Picture_PictureID > 0) Then Response.Write(XLpics.Picture_PictureID) %>" />

											<button type="submit" class="edit">Edit</button>
<%

			If (XLpics.Picture_PictureID <> 0) Then

				If (XLpics.Picture_PictureID > 1) Then

%>											<a href="editcaption.asp?pictureid=<%=XLpics.Picture_PictureID - 1%>" class="previous">Previous</a>
<%

				End If

%>											<a href="editcaption.asp?pictureid=<%=XLpics.Picture_PictureID + 1%>" class="next">Next</a>
<%

			End If

%>										</fieldset>
									</form>

								</div>

							</div>
						</div>

<%

		If (Len(XLpics.AdminMessage) <> 0) Then

%>						<p class="error"><%=Server.HTMLEncode(XLpics.AdminMessage)%></p>

<%

		Else

			If Not XLpics.MissingFields Is Nothing Then
				If (XLpics.MissingFields.Count > 0) Then

%>						<p class="error"><%

					If (XLpics.MissingFields.Count = 1) Then
						Response.Write("Only one field is not filled in correct. Please check the marked field.")
					Else
						Response.Write("There are " & Server.HTMLEncode(XLpics.MissingFields.Count) & " fields which are not filled in correctly. Please check the marked fields.")
					End If

						%></p>

<%

				End If
			End If

			If (XLpics.Picture_PictureID <> 0) Then

%>						<div class="tablecontentbottom">
							<div class="tablecontenttop">

								<label class="titleonly"><span>&nbsp;</span></label>

								<div class="largethumbnailwithborder">
									<table border="0" cellpadding="0" cellspacing="0"><tr><td valign="middle" align="center"><img src="/thumbnails<%=XLpics.Picture_Thumbnail%>" alt="" /></td></tr></table>
								</div>

							</div>
						</div>
                        
                        </div>
                    </div>
                    
                    <br>
                    <div class="contentbottom">
                        <div class="contenttop">
                    
						<form action="editcaption.asp?pictureid=<%=Server.URLEncode(XLpics.Picture_PictureID)%>" method="post">

                            <div class="buttons">
                                <div>
<%

				If (Len(BackURL) <> 0) Then

%>  								<a href="<%=BackURL%>" class="button">Back</a>
<%

				End If

%>	    							</div>
                                <div>
                                    <button type="submit" class="saveprevious" name="saveprevious" value="saveprevious">Save &amp; Previous</button>
                                    <button type="submit" class="savenext" name="savenext" value="savenext">Save &amp; Next</button>
                                    <button type="submit" class="save" name="save" value="save">Save &amp; Continue</button>
                                </div>
                            </div>

							<div class="thumbnailsbottom">
								<div class="thumbnailstop">

									<fieldset>
										<label class="fullwidth<% If XLpics.IsMissingField("online") Then Response.Write(" error") %>"><span>Online</span><input type="checkbox" class="checkbox" name="online"<% If XLpics.Picture_Online Then Response.Write (" checked=""checked""") %> /></label><br class="clearAll">
                                        <input type="hidden" name="topshot" value="<% If XLpics.Picture_TopShot Then Response.Write ("on") %>" />
<%

                EnableEditingSortOrder = False
                If (Application("DefaultSortOrder") = 2) OR (Application("DefaultSortOrder") = 3) Then EnableEditingSortOrder = True

                If EnableEditingSortOrder Then

%>										<label class="fullwidth<% If XLpics.IsMissingField("sortorder") Then Response.Write(" error") %>"><span>Sort order</span><input type="text" class="text" name="sortorder" value="<%=Server.HTMLEncode(XLpics.Picture_SortOrder)%>" /></label><br class="clearAll">
<%

                Else

%>                                      <input type="hidden" name="sortorder" value="<%=Server.HTMLEncode(XLpics.Picture_SortOrder)%>" />
<%

                End If

%>										<label class="fullwidth<% If XLpics.IsMissingField("picturedatetime") Then Response.Write(" error") %>"><span>Picture date</span>
											<div class="fullwidthfields datetimefields">
												<select name="picturedatetime_day" class="selectday<% If XLpics.IsMissingField("picturedatetime") Then Response.Write(" error") %>">
													<option value="0">-Day-</option>
<%



				For i = 1 To 31

%>													<option<% If (XLpics.Picture_PictureDateTime_Day = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

				Next

%>												</select>

												<select name="picturedatetime_month" class="selectmonth<% If XLpics.IsMissingField("picturedatetime") Then Response.Write(" error") %>">
													<option value="0">-Month-</option>
													<option value="1"<% If (XLpics.Picture_PictureDateTime_Month = 1) Then Response.Write (" selected=""selected""") %>>January</option>
													<option value="2"<% If (XLpics.Picture_PictureDateTime_Month = 2) Then Response.Write (" selected=""selected""") %>>February</option>
													<option value="3"<% If (XLpics.Picture_PictureDateTime_Month = 3) Then Response.Write (" selected=""selected""") %>>March</option>
													<option value="4"<% If (XLpics.Picture_PictureDateTime_Month = 4) Then Response.Write (" selected=""selected""") %>>April</option>
													<option value="5"<% If (XLpics.Picture_PictureDateTime_Month = 5) Then Response.Write (" selected=""selected""") %>>May</option>
													<option value="6"<% If (XLpics.Picture_PictureDateTime_Month = 6) Then Response.Write (" selected=""selected""") %>>June</option>
													<option value="7"<% If (XLpics.Picture_PictureDateTime_Month = 7) Then Response.Write (" selected=""selected""") %>>July</option>
													<option value="8"<% If (XLpics.Picture_PictureDateTime_Month = 8) Then Response.Write (" selected=""selected""") %>>August</option>
													<option value="9"<% If (XLpics.Picture_PictureDateTime_Month = 9) Then Response.Write (" selected=""selected""") %>>September</option>
													<option value="10"<% If (XLpics.Picture_PictureDateTime_Month = 10) Then Response.Write (" selected=""selected""") %>>October</option>
													<option value="11"<% If (XLpics.Picture_PictureDateTime_Month = 11) Then Response.Write (" selected=""selected""") %>>November</option>
													<option value="12"<% If (XLpics.Picture_PictureDateTime_Month = 12) Then Response.Write (" selected=""selected""") %>>December</option>
												</select>

												<select name="picturedatetime_year" class="selectyear<% If XLpics.IsMissingField("picturedatetime") Then Response.Write(" error") %>">
													<option value="0">-Year-</option>
<%

				For i = DatePart("yyyy", Date) To 1950 Step -1

%>													<option<% If (XLpics.Picture_PictureDateTime_Year = i) Then Response.Write (" selected=""selected""") %>><%=i%></option>
<%

				Next

%>												</select><br class="clearAll" />
											</div><br class="clearAll" />
										</label>
									</fieldset>

									<br class="clearAll" />

									<fieldset>
										<label class="fullwidth<% If XLpics.IsMissingField("caption") Then Response.Write(" error") %>"><span>Caption</span><textarea class="text" name="caption" cols="20" rows="8"><%=Server.HTMLEncode(XLpics.Picture_FullCaption)%></textarea></label><br class="clearAll">
										<label class="fullwidth<% If XLpics.IsMissingField("headline") Then Response.Write(" error") %>"><span>Headline</span><textarea class="text" name="headline" cols="20" rows="3"><%=Server.HTMLEncode(XLpics.Picture_Headline)%></textarea></label><br class="clearAll">
										<label class="fullwidth<% If XLpics.IsMissingField("copyright") Then Response.Write(" error") %>"><span>Copyright</span><input type="text" class="text" name="copyright" value="<%=Server.HTMLEncode(XLpics.Picture_Copyright)%>" /></label><br class="clearAll">
										<label class="fullwidth<% If XLpics.IsMissingField("city") Then Response.Write(" error") %>"><span>City</span><input type="text" class="text" name="city" value="<%=Server.HTMLEncode(XLpics.Picture_City)%>" /></label><br class="clearAll">
										<label class="fullwidth<% If XLpics.IsMissingField("provincestate") Then Response.Write(" error") %>"><span>Province / State</span><input type="text" class="text" name="provincestate" value="<%=Server.HTMLEncode(XLpics.Picture_ProvinceState)%>" /></label><br class="clearAll">
										<label class="fullwidth<% If XLpics.IsMissingField("country") Then Response.Write(" error") %>"><span>Country</span><input type="text" class="text" name="country" value="<%=Server.HTMLEncode(XLpics.Picture_Country)%>" /></label><br class="clearAll">
									</fieldset>

								</div>
							</div>

							<div class="thumbnailsbottom">
								<div class="thumbnailstop">

									<label class="titleonly<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>"><span>Keywords</span></label>
										<div class="fullwidthfields">
											<fieldset>
<%

				Set Keywords = XLpics.Picture_Keywords

				For i = 1 To (Keywords.Count + 2) / 3

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>" name="keyword" value="<% If (((i - 1) * 3 + 1) <= Keywords.Count) Then Response.Write(Server.HTMLEncode(Keywords.Item((i - 1) * 3 + 1))) %>" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>" name="keyword" value="<% If (((i - 1) * 3 + 2) <= Keywords.Count) Then Response.Write(Server.HTMLEncode(Keywords.Item((i - 1) * 3 + 2))) %>" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>" name="keyword" value="<% If (((i - 1) * 3 + 3) <= Keywords.Count) Then Response.Write(Server.HTMLEncode(Keywords.Item((i - 1) * 3 + 3))) %>" />
<%

				Next

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>" name="keyword" value="" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>" name="keyword" value="" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("keywords") Then Response.Write(" error") %>" name="keyword" value="" />
											</fieldset>
										</div>

								</div>
							</div>

							<div class="thumbnailsbottom">
								<div class="thumbnailstop">

									<label class="titleonly<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>"><span>Only allow countries</span></label>
										<div class="fullwidthfields">
											<fieldset>
<%

				Set AllowCountries = XLpics.Picture_AllowCountries

				For i = 1 To (AllowCountries.Count + 4) / 5

%>												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="<% If (((i - 1) * 5 + 1) <= AllowCountries.Count) Then Response.Write(Server.HTMLEncode(AllowCountries.Item((i - 1) * 5 + 1))) %>" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="<% If (((i - 1) * 5 + 2) <= AllowCountries.Count) Then Response.Write(Server.HTMLEncode(AllowCountries.Item((i - 1) * 5 + 2))) %>" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="<% If (((i - 1) * 5 + 3) <= AllowCountries.Count) Then Response.Write(Server.HTMLEncode(AllowCountries.Item((i - 1) * 5 + 3))) %>" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="<% If (((i - 1) * 5 + 4) <= AllowCountries.Count) Then Response.Write(Server.HTMLEncode(AllowCountries.Item((i - 1) * 5 + 4))) %>" />
												<input type="text" class="text text5wide norightmargin<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="<% If (((i - 1) * 5 + 5) <= AllowCountries.Count) Then Response.Write(Server.HTMLEncode(AllowCountries.Item((i - 1) * 5 + 5))) %>" /><br class="clearAll">
<%

				Next

				If ((AllowCountries.Count Mod 5) = 0) Then

%>												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="" />
												<input type="text" class="text text5wide norightmargin<% If XLpics.IsMissingField("allowcountries") Then Response.Write(" error") %>" name="allowcountry" value="" /><br class="clearAll">
<%

				End If

%>											</fieldset>
										</div><br class="clearAll" />

									<label class="titleonly"><span>Disallow countries</span></label>
										<div class="fullwidthfields">
											<fieldset>
<%

				Set DisallowCountries = XLpics.Picture_DisallowCountries

				For i = 1 To (DisallowCountries.Count + 4) / 5

%>												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="<% If (((i - 1) * 5 + 1) <= DisallowCountries.Count) Then Response.Write(Server.HTMLEncode(DisallowCountries.Item((i - 1) * 5 + 1))) %>" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="<% If (((i - 1) * 5 + 2) <= DisallowCountries.Count) Then Response.Write(Server.HTMLEncode(DisallowCountries.Item((i - 1) * 5 + 2))) %>" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="<% If (((i - 1) * 5 + 3) <= DisallowCountries.Count) Then Response.Write(Server.HTMLEncode(DisallowCountries.Item((i - 1) * 5 + 3))) %>" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="<% If (((i - 1) * 5 + 4) <= DisallowCountries.Count) Then Response.Write(Server.HTMLEncode(DisallowCountries.Item((i - 1) * 5 + 4))) %>" />
												<input type="text" class="text text5wide norightmargin<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="<% If (((i - 1) * 5 + 5) <= DisallowCountries.Count) Then Response.Write(Server.HTMLEncode(DisallowCountries.Item((i - 1) * 5 + 5))) %>" /><br class="clearAll">
<%

				Next

				If ((DisallowCountries.Count Mod 5) = 0) Then

%>												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="" />
												<input type="text" class="text text5wide<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="" />
												<input type="text" class="text text5wide norightmargin<% If XLpics.IsMissingField("disallowcountries") Then Response.Write(" error") %>" name="disallowcountry" value="" /><br class="clearAll">
<%

				End If

%>											</fieldset>
										</div><br class="clearAll" />

								</div>
							</div>

							<div class="thumbnailsbottom">
								<div class="thumbnailstop">

									<label class="titleonly"><span>Only allow groups</span></label>
										<div class="fullwidthfields">
											<fieldset>
<%

				Set AllowGroups = XLpics.Picture_AllowGroups

				For i = 1 To (AllowGroups.Count + 2) / 3

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("allowgroups") Then Response.Write(" error") %>" name="allowgroup" value="<% If (((i - 1) * 3 + 1) <= AllowGroups.Count) Then Response.Write(Server.HTMLEncode(AllowGroups.Item((i - 1) * 3 + 1))) %>" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("allowgroups") Then Response.Write(" error") %>" name="allowgroup" value="<% If (((i - 1) * 3 + 2) <= AllowGroups.Count) Then Response.Write(Server.HTMLEncode(AllowGroups.Item((i - 1) * 3 + 2))) %>" />
												<input type="text" class="text text3wide norightmargin<% If XLpics.IsMissingField("allowgroups") Then Response.Write(" error") %>" name="allowgroup" value="<% If (((i - 1) * 3 + 3) <= AllowGroups.Count) Then Response.Write(Server.HTMLEncode(AllowGroups.Item((i - 1) * 3 + 3))) %>" /><br class="clearAll">
<%

				Next

				If ((AllowGroups.Count Mod 3) = 0) Then

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("allowgroups") Then Response.Write(" error") %>" name="allowgroup" value="" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("allowgroups") Then Response.Write(" error") %>" name="allowgroup" value="" />
												<input type="text" class="text text3wide norightmargin<% If XLpics.IsMissingField("allowgroups") Then Response.Write(" error") %>" name="allowgroup" value="" /><br class="clearAll">
<%

				End If

%>											</fieldset>
										</div>

									<label class="titleonly"><span>Disallow groups</span></label>
										<div class="fullwidthfields">
											<fieldset>
<%

				Set DisallowGroups = XLpics.Picture_DisallowGroups

				For i = 1 To (DisallowGroups.Count + 2) / 3

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("disallowgroups") Then Response.Write(" error") %>" name="disallowgroup" value="<% If (((i - 1) * 3 + 1) <= DisallowGroups.Count) Then Response.Write(Server.HTMLEncode(DisallowGroups.Item((i - 1) * 3 + 1))) %>" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("disallowgroups") Then Response.Write(" error") %>" name="disallowgroup" value="<% If (((i - 1) * 3 + 2) <= DisallowGroups.Count) Then Response.Write(Server.HTMLEncode(DisallowGroups.Item((i - 1) * 3 + 2))) %>" />
												<input type="text" class="text text3wide norightmargin<% If XLpics.IsMissingField("disallowgroups") Then Response.Write(" error") %>" name="disallowgroup" value="<% If (((i - 1) * 3 + 3) <= DisallowGroups.Count) Then Response.Write(Server.HTMLEncode(DisallowGroups.Item((i - 1) * 3 + 3))) %>" /><br class="clearAll">
<%

				Next

				If ((DisallowGroups.Count Mod 3) = 0) Then

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("disallowgroups") Then Response.Write(" error") %>" name="disallowgroup" value="" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("disallowgroups") Then Response.Write(" error") %>" name="disallowgroup" value="" />
												<input type="text" class="text text3wide norightmargin<% If XLpics.IsMissingField("disallowgroups") Then Response.Write(" error") %>" name="disallowgroup" value="" /><br class="clearAll">
<%

				End If

%>											</fieldset>
										</div>

									<label class="titleonly"><span>Exclusive for groups</span></label>
										<div class="fullwidthfields">
											<fieldset>
<%

				Set ExclusiveGroups = XLpics.Picture_ExclusiveGroups

				For i = 1 To (ExclusiveGroups.Count + 2) / 3

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("exclusivegroups") Then Response.Write(" error") %>" name="exclusivegroup" value="<% If (((i - 1) * 3 + 1) <= ExclusiveGroups.Count) Then Response.Write(Server.HTMLEncode(ExclusiveGroups.Item((i - 1) * 3 + 1))) %>" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("exclusivegroups") Then Response.Write(" error") %>" name="exclusivegroup" value="<% If (((i - 1) * 3 + 2) <= ExclusiveGroups.Count) Then Response.Write(Server.HTMLEncode(ExclusiveGroups.Item((i - 1) * 3 + 2))) %>" />
												<input type="text" class="text text3wide norightmargin<% If XLpics.IsMissingField("exclusivegroups") Then Response.Write(" error") %>" name="exclusivegroup" value="<% If (((i - 1) * 3 + 3) <= ExclusiveGroups.Count) Then Response.Write(Server.HTMLEncode(ExclusiveGroups.Item((i - 1) * 3 + 3))) %>" /><br class="clearAll">
<%

				Next

				If ((ExclusiveGroups.Count Mod 3) = 0) Then

%>												<input type="text" class="text text3wide<% If XLpics.IsMissingField("exclusivegroups") Then Response.Write(" error") %>" name="exclusivegroup" value="" />
												<input type="text" class="text text3wide<% If XLpics.IsMissingField("exclusivegroups") Then Response.Write(" error") %>" name="exclusivegroup" value="" />
												<input type="text" class="text text3wide norightmargin<% If XLpics.IsMissingField("exclusivegroups") Then Response.Write(" error") %>" name="exclusivegroup" value="" /><br class="clearAll">
<%

				End If

%>											</fieldset>
										</div>

								</div>
							</div>

							<div class="buttons">
								<div>
<%

				If (Len(BackURL) <> 0) Then

%>									<a href="<%=BackURL%>" class="button">Back</a>
<%

				End If

%>								</div>
								<div>
									<button type="submit" class="saveprevious" name="saveprevious" value="saveprevious">Save &amp; Previous</button>
									<button type="submit" class="savenext" name="savenext" value="savenext">Save &amp; Next</button>
									<button type="submit" class="save" name="save" value="save">Save &amp; Continue</button>
								</div>
							</div>

							<input type="hidden" name="pictureid" value="<%=XLpics.Picture_PictureID%>" />
<%

				If (Len(BackURL) <> 0) Then

%>							<input type="hidden" name="backurl" value="<%=Server.HTMLEncode(BackURL)%>" />
<%

				End If

%>
						</form>

<%

			End If

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