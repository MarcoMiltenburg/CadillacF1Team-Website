				<div class="thumbnails">

					<ul>
<%

			Dim ExtraParams
			ExtraParams = Array()
			
			SearchPortrait = CBool(UCase(Request.QueryString("portrait")) = "ON")
			SearchLandscape = CBool(UCase(Request.QueryString("landscape")) = "ON")
			
			If SearchPortrait And SearchLandscape Then
				SearchPortrait = False
				SearchLandscape = False
			End If
			
			If SearchPortrait Then
				ReDim Preserve ExtraParams(UBound(ExtraParams) + 1)
				ExtraParams(UBound(ExtraParams)) = Array("portrait", "on")
			End If
			
			If SearchLandscape Then
				ReDim Preserve ExtraParams(UBound(ExtraParams) + 1)
				ExtraParams(UBound(ExtraParams)) = Array("landscape", "on")
			End If

			' --- Get maximum rows and columns
			XLpics.GetThumbnailsRowsColumns XLpics.UserProfile_ThumbnailSizeID, PictureSearch_MaximumRows, PictureSearch_MaximumColumns

			For j = 1 To XLpics.PictureSearch.Count

%>						<li>
							<div class="cont"><div id="slide-<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" class="slide<% If (XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ExceedDownloadLimit)) Then Response.Write(" exceedlimit") %>" data-pictureid="<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>"><%
							
								If IsKeywordSearch Then
								
							%><a href="<%=Server.HTMLEncode(SearchViewURL(XLpics.KeywordSearch, XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID), XLpics.BrowsePage, ExtraParams))%>" data-caption="<%=Server.HtmlEncode(RemoveLineBreaks(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ShortCaption)))%>"><%
							
								Else

							%><a href="<%=Server.HTMLEncode(PictureViewURL(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_SeriesID), XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_EventID), XLpics.SessionID, XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID), XLpics.TopShots))%>" data-caption="<%=Server.HtmlEncode(RemoveLineBreaks(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ShortCaption)))%>"><%
							
								End If
							
							%><img id="picture-id-<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" src="/thumbnails<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ThumbnailURL)%>" alt="<%=Server.HtmlEncode(RemoveLineBreaks(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ShortCaption)))%>" loading="lazy"></a></div></div>
<%
					
				PictureSizes = XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureSizes)

				If IsArray(PictureSizes) Then
					If (UBound(PictureSizes) >= 0) Then

%>							<ol class="icons<% If XLpics.UserLoggedIn And XLpics.UserProfile_AdminEnabled And XLpics.Page <> XLpicsPage_BrowseDownloadBasket Then Response.Write (" withextrarow") %>">
<%

						If IsDownloadBasket Then
						
%>								<li><a href="/basket/remove/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>?size=<%=PictureSizes(0)(XLpicsPictureCollection_PictureSizesFields_PictureSizeID)%>" class="delete" title="Remove from basket" rel="noindex"><span>Remove from basket</span></a></li>
<%

						Else

%>								<li><a href="/basket/add/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>?size=<%=PictureSizes(0)(XLpicsPictureCollection_PictureSizesFields_PictureSizeID)%>" class="basket addbasket" title="Add to basket" rel="noindex"><span>Add to basket</span></a></li>
								<li><a href="/pictures/<%=PictureSizes(0)(XLpicsPictureCollection_PictureSizesFields_PictureURL)%>" class="download" title="Download" rel="noindex"><span>Download</span></a></li>
<%

							If XLpics.UserLoggedIn And XLpics.UserProfile_AdminEnabled Then

                                If XLpics.HasAdminGroup("XPBAdmin") Then

%>								<li><a href="/admin/editcaption.asp?pictureid=<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>&back=yes" class="edit" title="Edit caption" rel="noindex"><span>Edit caption</span></a></li>
<%

                                End If

%>								<li id="delete-picture-id-<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" class="delete"><a href="#" data-href="/admin/toggle-picture-status/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" data-pictureid="<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" class="togglepicturestatus delete" title="Delete Picture" rel="noindex"><span>Delete Picture</span></a></li>
								<li id="undelete-picture-id-<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" class="undelete hidden"><a href="#" data-href="/admin/toggle-picture-status/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" data-pictureid="<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" class="togglepicturestatus undelete" title="Undelete Picture" rel="noindex"><span>Undelete Picture</span></a></li>
<%
							End If
							
						End If

%>							</ol>
<%

                        If XLpics.UserLoggedIn And XLpics.UserProfile_AdminEnabled And XLpics.Page <> XLpicsPage_BrowseDownloadBasket Then
						
							HasPartners = CBool(Len(XLpics.GetFilteredArray(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ExclusiveGroups), Application("ListOfPartners"))) > 0)

%>							<ol class="icons extrarow">
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>?group=Media" class="exclusivegroup media<% If (XLPics.IsInArray(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ExclusiveGroups), "Media")) Then Response.Write(" enabled") %>" title="Toggle Media availability"><span>Toggle Media availability</span></a></li>
								<li><a href="#" data-basehref="/admin/toggle-exclusive-group/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" data-statushref="/admin/get-exclusive-groups/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" data-setbasehref="/admin/set-exclusive-groups/" data-pictureid="<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" id="partnersselector-<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>" class="partnersselector partners<% If HasPartners Then Response.Write(" enabled") %>" title="Toggle Partners availability"><span>Toggle Partners availability</span></a></li>
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>?group=Internal" class="exclusivegroup internal<% If (XLPics.IsInArray(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ExclusiveGroups), "Internal")) Then Response.Write(" enabled") %>" title="Toggle Internal availability"><span>Toggle Internal availability</span></a></li>
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_PictureID)%>?group=Drivers" class="exclusivegroup drivers<% If (XLPics.IsInArray(XLpics.PictureSearch.Item(j)(XLpicsPictureCollectionField_ExclusiveGroups), "Drivers")) Then Response.Write(" enabled") %>" title="Toggle Drivers availability"><span>Toggle Drivers availability</span></a></li>
                            </ol>
<%
                        End If

					End If
				End If
				
%>						</li>
<%


			Next

%>					</ul>

				</div>
				
				<div id="partnersselector">
					<div class="multiple-text">Warning: You are overwriting the partner selection for multiple images at the same time.</div>
					<div class="partnerslist">
						<ol>
<%

			For i = 0 To UBound(Application("ListOfPartners"))
			
%>							<li><a href="#" data-group="<%=Server.HTMLEncode(Application("ListOfPartners")(i)(1))%>" class="partnerstoggle"><%=Server.HTMLEncode(Application("ListOfPartners")(i)(0))%></a></li>
<%		

			Next

%>						</ol>
					</div>
					<ol class="form">
						<li class="buttons center">
							<button class="selectall" type="button">Select All</button>
							<button class="unselectall" type="button">Unselect All</button>
						</li>
					</ol>
					<ol class="form">
						<li class="buttons center">
							<button class="close" type="button">Close</button>
						</li>
					</ol>
					<input id="partnerselector-basehref" type="hidden" name="partnerselector-basehref" value="">
					<input id="partnerselector-setbasehref" type="hidden" name="partnerselector-setbasehref" value="">
					<input id="partnerselector-pictureid" type="hidden" name="partnerselector-pictureid" value="0">
				</div>

