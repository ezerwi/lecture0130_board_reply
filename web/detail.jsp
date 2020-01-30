<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@
page import = "com.wjh.board.BoardQuery, java.sql.ResultSet, java.sql.SQLException, com.wjh.board.Encoding"
 %>
    
<%
String no = request.getParameter("no");
String title = "";
String name = "";
String contents = "";

ResultSet rs = BoardQuery.show_one(no);
rs.beforeFirst();

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 상세보기</title>
</head>
<body>
<div align = "center">
<h1><%=no%>번 글 상세보기</h1>
</div>
<%
while(rs.next()) {
	title = Encoding.toUnicode(rs.getString("title"));
	name = Encoding.toUnicode(rs.getString("name"));
	contents = Encoding.toUnicode(rs.getString("contents"));
}

%>

<fieldset>
<legend>제목</legend>
<%=title %>
</fieldset>

<fieldset>
<legend>글쓴이</legend>
<%=name %>
</fieldset>

<fieldset>
<legend>내용</legend>
<%=contents %>
</fieldset>
<p>

<div align = "center">
<input type = button value = "수정" onclick = "location.href='renew.jsp?no=<%=no%>'" />&nbsp;
<input type = button value = "삭제" onclick = "location.href='delete.jsp?no=<%=no%>'" />&nbsp;
<input type = "button" value = "답글달기" onclick = "location.href = 'reply_form.jsp?no=<%=no%>'" /><p>
<input type = "button" value = "돌아가기" onclick = "location.href = 'list.jsp?page=1'" />
</div>

</body>
</html>