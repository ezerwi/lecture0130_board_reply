<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    
    import = "com.wjh.board.BoardQuery, java.sql.ResultSet, java.sql.SQLException, com.wjh.board.Encoding"
    
    %>

<%
String no = request.getParameter("no");
String uid = "";
int depth = 0;
String before_contents = "";

ResultSet rs = BoardQuery.show_one(no);
rs.beforeFirst();
while(rs.next()){
	uid = rs.getString("uid");
	depth = Integer.parseInt(rs.getString("depth"));
	before_contents = Encoding.toUnicode(rs.getString("contents"));	
}

depth+=1;

%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>답글쓰기</title>
</head>
<body>

<div align = "center">
<h1><%=no %>번 글의 답글을 써보자</h1>
</div>
<form action = "reply_insert.jsp" accept-charset = "UTF-8" method = get>
<input type = "hidden" name = "no" value = <%=no%> />
<input type = "hidden" name = "uid" value = <%=uid%> />
<input type = "hidden" name = "depth" value = <%=depth%> />
<fieldset>
<legend>제목</legend>
	<input type = "text" name = "title" placeholder = "제목을 써주세요" value="[<%=no%>번 글의 답글] " size = 70% required />
</fieldset><p>
<fieldset>
<legend>작성자</legend>
	<input type = "text" name = "name" placeholder = "작성자 이름을 써주세요" size = 70% required />
</fieldset><p>
<fieldset>
<legend>내용</legend>
	<textarea name = "contents" cols = 70 rows = 20 placeholder = "<%=before_contents %>" required ></textarea>	
</fieldset><p>

<fieldset>
<legend>설정</legend>
	e-mail&nbsp;&nbsp;:&nbsp;&nbsp;<input type ="email" name = "email" size = "50%" /> 
</fieldset><p>

<div align = "center" >
<input type = "button" value = "글로 돌아가기" onclick="location.href='detail.jsp?no=<%=no %>'" />
<input type = "reset"  value = "다시쓰기" />
<input type = "submit" value = "작성완료" />

</div>
</form>


</body>
</html>