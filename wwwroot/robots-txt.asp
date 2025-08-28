<!--#include virtual="/includes/common.asp"--><%

    Response.ContentType = "text/txt"
    Response.Expires = 4 * 60

%>User-agent: *
<%

    For i = 0 To UBound(AllSeries)

%>Disallow: <%=Response.Write(SeriesURL(AllSeries(i)) & "event/" & Chr(10))%>
<%

    Next

%>Disallow: /search
Disallow: /search-view
