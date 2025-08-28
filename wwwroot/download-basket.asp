<%

	SeriesID = 1

%><!--#include virtual="/includes/common.asp"--><%

	' This comment is here to force UTF-8 when loading this file into an editor (©) Do not remove!

	NoIndex = True
	IsDownloadBasket = True

	Function GetPageURL(TheSeriesID, TheEventID, TheSessionID, TheTopShots, TheKeywords, ThePage)
		GetPageURL = BasketURL(ThePage)
	End Function

 	On Error Resume Next

	Response.Expires = -1
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

	XLpics.Page = XLpicsPage_BrowseDownloadBasket
	XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

		<main id="main" class="basket">

<%

	If (Len(XLpics.FatalErrorMessage) <> 0) Then

%><!--#include virtual="/includes/errormessages.asp"-->
<%

	Else

%>  		<div class="pictures">
		
				<h1>Download basket</h1>

<%

		If (Len(XLpics.PictureSearchMessage) <> 0) Or (IsNull(XLpics.PictureSearch)) Then

%>				<ol class="notifications">
					<li class="warning"><%=Server.HTMLEncode(XLpics.PictureSearchMessage)%></li>
				</ol>

<%

		Else

			If (UCase(Request.QueryString("download")) = "ZIP") Then

%>				<div class="startdownload">
                    <p>Your download should start in a few seconds...</p>
                </div>
                
                <div class="retrydownload">
                    <p>If your download succeeded you can clear the basket. Otherwise retry to download the basket.</p>
                    <form action="/basket/clear" method="post" id="basketclear" autocomplete="off"></form>
                    <form action="/basket/download" method="post" id="basketdownload" autocomplete="off">
                        <fieldset>
                            <ol class="form">
                                <li>
                                    <label for="id_autoclearbasket"><input id="id_autoclearbasket" type="checkbox" name="autoclearbasket" <% If (XLpics.AutoClearBasketAfterDownload) Then %>checked="checked" <% End If %>/> Automatically clear basket after download</label>
                                </li>
                                <li class="buttons opposite">
                                    <button type="submit" form="basketclear">Clear</button>
                                    <button type="submit" class="default">Retry Download</button>
                                </li>
                            </ol>
                        </fieldset>
                        <input type="hidden" name="dummy" value="" />
                    </form>
                </div>
<%

			Else

				If XLpics.DownloadBasketWillExceedDownloadLimit Then

%>				<ol class="notifications">
					<li class="warning">The red marked pictures can't be downloaded as they would exceed your download limit. Click 'download' to download the basket without these pictures or manually remove (other) pictures from the download basket to stay within your download limits.</li>
				</ol>

<%

				End If

%>				<form action="/basket/clear" method="post" id="basketclear" autocomplete="off"></form>
				<form action="/basket/download" method="post" id="basketdownload" autocomplete="off">
                    <fieldset>
                        <ol class="form">
                            <li>
                                <label for="id_autoclearbasket"><input id="id_autoclearbasket" type="checkbox" name="autoclearbasket" <% If (XLpics.AutoClearBasketAfterDownload) Then %>checked="checked" <% End If %>/> Automatically clear basket after download</label>
                            </li>
                            <li class="buttons opposite">
                                <button type="submit" form="basketclear">Clear</button>
                                <button type="submit" class="default">Download</button>
                            </li>
                        </ol>
                    </fieldset>
                    <input type="hidden" name="dummy" value="" />
                </form>

				<p><%=XLpics.TotalPictures%> Picture<% If (XLpics.TotalPictures <> 1) Then Response.Write ("s") %><% If (XLpics.TotalPages > 1) Then %> - Displaying page <%=XLpics.BrowsePage%> of <%=XLpics.TotalPages%><% End If %></p>

<!--#include virtual="/includes/picturesearch-pagenavigation.asp"-->

<!--#include virtual="/includes/picturesearch.asp"-->

<!--#include virtual="/includes/picturesearch-pagenavigation.asp"-->

<%

			End If

		End If

	End If
		
%>			</div>

		</main>
<%

    If (Not XLpics.AutoClearBasketAfterDownload) Then

%>
        <script>
        
            setTimeout(function() {
                $('.startdownload').hide();
                $('.retrydownload').show();
            }, 4000);
        
        </script>

<%

    End If

%>
<!--#include virtual="/includes/footer.asp"-->
<!--#include virtual="/includes/page-bottom.asp"-->
<%

	XLpics.DeInit
	Set XLpics = Nothing

%>