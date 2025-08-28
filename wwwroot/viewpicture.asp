<%

	SeriesID = 1

%><!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_BrowseEventWithViewPicture
	XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

        <main class="main">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%><!--#include virtual="/includes/errormessages.asp"-->
<%

	Else

%>		    <div class="viewpicture">
		
				<h2><%=Server.HTMLEncode(XLpics.PictureSearchTitle)%></h2>

<%

		If (Len(XLpics.PictureSearchMessage) <> 0) Or (IsNull(XLpics.PictureSearch)) Then

%>				<ol class="notifications">
					<li class="warning"><%=Server.HTMLEncode(XLpics.PictureSearchMessage)%></li>
				</ol>

<%

		Else

			CurrentPicture = XLpics.PictureSearchCurrentPicture

			If IsArray(CurrentPicture) Then
				If (UBound(CurrentPicture) >= 0) Then
			
%>				<p><%=XLpics.TotalPictures%> Picture<% If (XLpics.TotalPictures <> 1) Then Response.Write ("s") %></p>

				<div class="actions">
					<a href="<%=Server.HTMLEncode(EventURL(XLpics.SeriesID, XLpics.EventID, "", XLpics.TopShots, XLpics.BrowsePage, Array()))%>" class="link right" title="View all pictures from this event"><span>View all</span></a>
				</div>

<%

                    PreviousPictureID = 0
                    NextPictureID = 0
                                            
                    PreviousPicture = XLpics.PictureSearchPreviousPicture
                    If IsArray(PreviousPicture) Then
                        If (UBound(PreviousPicture) >= 0) Then
                            PreviousPictureID = PreviousPicture(XLpicsPictureCollectionField_PictureID)
                        End If
                    End If
                    
                    NextPicture = XLpics.PictureSearchNextPicture
                    If IsArray(NextPicture) Then
                        If (UBound(NextPicture) >= 0) Then
                            NextPictureID = NextPicture(XLpicsPictureCollectionField_PictureID)
                        End If
                    End If

                    If ((PreviousPictureID <> 0) Or (NextPictureID <> 0)) Then

%>				<ol class="pagenavigation">
					<li class="previous">
						<ol>
							<li><%

                        If (PreviousPictureID <> 0) Then

							%><a href="<%=PictureViewURL(XLpics.SeriesID, XLpics.EventID, XLpics.SessionID, PreviousPictureID, XLpics.TopShots)%>" class="previouspage" aria-label="Go to previous page"></a><%

                        End If

							%></li>
						</ol>
					</li>
					<li class="next">
						<ol>
							<li><%

                        If (NextPictureID <> 0) Then

							%><a href="<%=PictureViewURL(XLpics.SeriesID, XLpics.EventID, XLpics.SessionID, NextPictureID, XLpics.TopShots)%>" class="nextpage" aria-label="Go to next page"></a><%

                        End If

							%></li>
						</ol>
					</li>
				</ol>
<%

                    End If

%>				<div class="viewphoto">

                    <div class="photo">
                        <div class="slide"><img id="picture-id-<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" src="/thumbnails<%=CurrentPicture(XLpicsPictureCollectionField_ThumbnailURL)%>" alt="<%=Server.HTMLEncode(RemoveLineBreaks(CurrentPicture(XLpicsPictureCollectionField_FullCaption)))%>"></div>
                    </div>

				    <div class="photoinfo">

<%

					PictureSizes = CurrentPicture(XLpicsPictureCollectionField_PictureSizes)

					If IsArray(PictureSizes) Then
					
						For i = 0 To UBound(PictureSizes)
						
%>				        <div class="details downloads<%

							If (((UBound(PictureSizes) + 1) Mod 2) <> 0) Then

								Response.Write(" oddnumber") 
								
							Else
							
								Response.Write(" evennumber")
								
								If (i = 0) Then
									Response.Write(" first")
								Else
									Response.Write(" second")
								End If
								
							End If

				%>">
<%

							If ((UBound(PictureSizes) + 1) > 1) Then
							
%>					        <h3><% If (PictureSizes(i)(XLpicsPictureCollection_PictureSizesFields_PictureSizeID) = 1) Then Response.Write ("High resolution") Else Response.Write ("Low resolution") %></h3>
<%

							End If

%>      					<ol class="actions">
                                <li><a href="<%=Server.HTMLEncode("/pictures/" & PictureSizes(i)(XLpicsPictureCollection_PictureSizesFields_PictureURL))%>" class="download" title="Download">Download</a></li>
                                <li><a href="<%=Server.HTMLEncode("/basket/add/" & CurrentPicture(XLpicsPictureCollectionField_PictureID) & "?size=" & PictureSizes(i)(XLpicsPictureCollection_PictureSizesFields_PictureSizeID))%>" class="basket addbasket" title="Add to basket">Add to basket</a></li>
                            </ol>
                            <dl>
                                <dt>Filename</dt><dd><%=Server.HTMLEncode(PictureSizes(i)(XLpicsPictureCollection_PictureSizesFields_PictureURL))%></dd>
                                <dt>File size</dt><dd><%=XLpics.FormatFileSize(PictureSizes(i)(XLpicsPictureCollection_PictureSizesFields_Filesize))%></dd>
                            </dl>
                        </div>

<%

						Next
                        
                        If XLpics.UserLoggedIn And XLpics.UserProfile_AdminEnabled Then

%>                      <div class="details downloads admin">
<%

                            If XLpics.HasAdminGroup("XPBAdmin") Then

%>                            <ol class="actions">
								<li id="delete-picture-id-<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" class="delete"><a href="#" data-href="/admin/toggle-picture-status/<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" data-pictureid="<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" class="togglepicturestatus delete" title="Delete Picture" rel="noindex"><span>Delete Picture</span></a></li>
								<li id="undelete-picture-id-<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" class="undelete hidden"><a href="#" data-href="/admin/toggle-picture-status/<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" data-pictureid="<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>" class="togglepicturestatus undelete" title="Undelete Picture" rel="noindex"><span>Undelete Picture</span></a></li>
								<li><a href="/admin/editcaption.asp?pictureid=<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>&back=yes" class="edit" title="Edit caption" rel="noindex"><span>Edit caption</span></a></li>
                            </ol>
<%

                            End If

%>                            <ol class="icons">
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>?group=Media" class="exclusivegroup media<% If (XLPics.IsInArray(CurrentPicture(XLpicsPictureCollectionField_ExclusiveGroups), "Media")) Then Response.Write(" enabled") %>" title="Toggle Media availability"><span>Toggle Media availability</span></a></li>
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>?group=Partners" class="exclusivegroup partners<% If (XLPics.IsInArray(CurrentPicture(XLpicsPictureCollectionField_ExclusiveGroups), "Partners")) Then Response.Write(" enabled") %>" title="Toggle Partners availability"><span>Toggle Partners availability</span></a></li>
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>?group=Internal" class="exclusivegroup internal<% If (XLPics.IsInArray(CurrentPicture(XLpicsPictureCollectionField_ExclusiveGroups), "Internal")) Then Response.Write(" enabled") %>" title="Toggle Internal availability"><span>Toggle Internal availability</span></a></li>
								<li><a href="#" data-href="/admin/toggle-exclusive-group/<%=CurrentPicture(XLpicsPictureCollectionField_PictureID)%>?group=Drivers" class="exclusivegroup drivers<% If (XLPics.IsInArray(CurrentPicture(XLpicsPictureCollectionField_ExclusiveGroups), "Drivers")) Then Response.Write(" enabled") %>" title="Toggle Drivers availability"><span>Toggle Drivers availability</span></a></li>
                            </ol>
                       </div>

<%

                        End If

					End If
                    
%>				        <div class="details">
                            <dl class="photocaption">
                                <dt>Caption</dt><dd><%=Server.HTMLEncode(CurrentPicture(XLpicsPictureCollectionField_FullCaption))%></dd>
                            </dl>
                        </div>

<%

				End If
			End If

%>  			    </div>

<%

		End If

	End If

%>              </div>
            </div>
		
        </main>

<!--#include virtual="/includes/footer.asp"-->
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>