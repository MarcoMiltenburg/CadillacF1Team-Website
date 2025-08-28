<!--#include virtual="/includes/common.asp"--><%

    On Error Resume Next

    Response.Expires = -1
    Response.CodePage = 65001
    Response.CharSet = "UTF-8"

%><!--#include virtual="/includes/init-xlpics.asp"--><%

    XLpics.Page = XLpicsPage_Homepage
    XLpics.Init

%><!--#include virtual="/includes/page-top.asp"-->
<!--#include virtual="/includes/header.asp"-->

        <main id="main" class="homepage">

            <div class="latestevents">

<%

    RecentEvents = XLpics.RecentEvents

    If IsArray(RecentEvents) Then
        If (UBound(RecentEvents) < 0) Then

%>              <p><%=Server.HTMLEncode(XLpics.RecentEventsMessage)%></p>
<%

        Else

            HasAtLeastOneRecentEvent = False
            
            For i = UBound(RecentEvents) To 0 Step -1

                RecentEvent = RecentEvents(i)
                ReDim Preserve RecentEvent(UBound(RecentEvent) + 1)
                
                RecentEvent(UBound(RecentEvent)) = False

                Set LatestPictures = XLpics.GetLatestPicturesFromEventSession(RecentEvents(i)(XLpicsEventDataField_EventID), "", 8)

                If Not (LatestPictures Is Nothing) Then
                    If (LatestPictures.Count > 0) Then
                    
                        RecentEvent(UBound(RecentEvent)) = True
                        HasAtLeastOneRecentEvent = True

%>              <article class="eventsummary">
                    <div class="eventtitle">
                        <div class="eventnamedate">
                            <h2><a href="<%=Server.HTMLEncode(EventURL(RecentEvents(i)(XLpicsEventDataField_SeriesID), RecentEvents(i)(XLpicsEventDataField_EventID), "", False, 0, Array()))%>"><%=Server.HTMLEncode(RecentEvents(i)(XLpicsEventDataField_EventName))%></a></h2>
                            <h3><%=Server.HTMLEncode(XLpics.FormatStartEndDate(RecentEvents(i)(XLpicsEventDataField_StartDate), RecentEvents(i)(XLpicsEventDataField_EndDate)))%></h3>
                        </div>
<%

                        SessionData = RecentEvents(i)(XLpicsEventDataField_Sessions)
                        
                        If (UBound(SessionData) > 0) Or RecentEvents(i)(XLpicsEventDataField_HasTopShots) Then

%>                        <div class="eventsessions">
                            <ul>
<%

                            For j = 0 To UBound(SessionData)
                            
								If (SessionData(j)(XLpicsEventData_SessionField_SessionID) <> "event") Then
								
									If (SessionData(j)(XLpicsEventData_SessionField_PhotoStatus) = 1) Then
								
%>                              <li><a href="<%=Server.HtmlEncode(EventURL(RecentEvents(i)(XLpicsEventDataField_SeriesID), RecentEvents(i)(XLpicsEventDataField_EventID), SessionData(j)(XLpicsEventData_SessionField_SessionID), False, 0, Array()))%>"><%=Server.HtmlEncode(SessionData(j)(XLpicsEventData_SessionField_ShortName))%></a></li>
<%

									Else

%>                              <li><%=Server.HtmlEncode(SessionData(j)(XLpicsEventData_SessionField_ShortName))%></li>
<%

									End If
									
								End If

                            Next

                            If RecentEvents(i)(XLpicsEventDataField_HasTopShots) Then
                            
%>                              <li><a href="<%=Server.HtmlEncode(EventURL(RecentEvents(i)(XLpicsEventDataField_SeriesID), RecentEvents(i)(XLpicsEventDataField_EventID), "", True, 0, Array()))%>">Top Shots</a></li>
<%
                            
                            End If
                            
%>                          </ul>
                        </div>
<%

                        End If

%>                    </div>
                    <div class="thumbnails">
                        <ul>
<%

                        For j = 1 To LatestPictures.Count

%>                          <li><div class="cont"><div class="slide"><a href="<%=Server.HTMLEncode(PictureViewURL(RecentEvents(i)(XLpicsEventDataField_SeriesID), RecentEvents(i)(XLpicsEventDataField_EventID), "", LatestPictures.Item(j)(XLpicsPictureCollectionField_PictureID), False))%>" data-caption="<%=Server.HtmlEncode(LatestPictures.Item(j)(XLpicsPictureCollectionField_ShortCaption))%>"><img src="/thumbnails<%=Server.HtmlEncode(LatestPictures.Item(j)(XLpicsPictureCollectionField_ThumbnailURL))%>" alt="<%=Server.HtmlEncode(RemoveLineBreaks(LatestPictures.Item(j)(XLpicsPictureCollectionField_ShortCaption)))%>" loading="lazy"></a></div></div></li>
<%

                        Next

%>                      </ul>
                    </div>
                </article>

<%

                    End If
                End If

                RecentEvents(i) = RecentEvent
            Next

        End If
        
        If Not HasAtLeastOneRecentEvent Then
        
%>              <p>There are no photos available yet.</p>
<%

        End If
        
    End If

%>
            </div>

<%

    If HasAtLeastOneRecentEvent Then
    
%>            <aside class="links">

              <div class="linksheader">
                    <h1>Season <%=XLpics.Season%></h1>
<%

        If IsArray(Seasons) Then
            If (UBound(Seasons) >= 0) Then
            
%>                  <form method="get">
                        <fieldset class="switchseason">
                            <label for="switchseason">Choose:</label>
                            <select id="switchseason" name="season">
<%

                For i = UBound(Seasons) To 0 Step -1

%>                              <option value="<%=Seasons(i)%>"<% If (XLpics.Season = Seasons(i)) Then %> selected<% End If %>><%=Seasons(i)%></option>
<%

                Next

%>                          </select>
                        </fieldset>
                    </form>
<%

            End If
        End If
    
%>              </div>

<%

        If IsArray(RecentEvents) Then
            If (UBound(RecentEvents) >= 0) Then

%>              <div class="events">

<%

                If (Len(XLpics.RecentEventsMessage) <> 0) Then
            
%>                  <p><%=Server.HtmlEncode(XLpics.RecentEventsMessage)%></p>
<%

                End If

                If (UBound(RecentEvents) >= 0) Then
            
%>                  <ol>
<%

                    For i = UBound(RecentEvents) To 0 Step -1

                        RecentEvent = RecentEvents(i)
                        If (RecentEvent(UBound(RecentEvent))) Then

%>                      <li><ul><li><%=Server.HtmlEncode(XLpics.FormatStartEndDate(RecentEvents(i)(XLpicsEventDataField_StartDate), RecentEvents(i)(XLpicsEventDataField_EndDate)))%></li><li><a href="<%=Server.HTMLEncode(EventURL(RecentEvents(i)(XLpicsEventDataField_SeriesID), RecentEvents(i)(XLpicsEventDataField_EventID), "", False, 0, Array()))%>"><%=Server.HtmlEncode(RecentEvents(i)(XLpicsEventDataField_EventName))%></a></li></ul></li>
<%

                        End If

                    Next

%>                  </ol>
<%

                End If

%>
                </div>

<%

            End If
        End If

%>
            </aside>
            
<%

    End If

%>
        </main>

<!--#include virtual="/includes/footer.asp"-->
<!--#include virtual="/includes/page-bottom.asp"-->
<%

    XLpics.DeInit
    Set XLpics = Nothing

%>