<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

	import = "java.sql.SQLException, java.sql.ResultSet, com.wjh.board.BoardQuery, com.wjh.board.Encoding"    
    
%>

<%

String no = request.getParameter("no");
String title = Encoding.toLatin(request.getParameter("title"));
String name = Encoding.toLatin(request.getParameter("name"));
String contents = Encoding.toLatin(request.getParameter("contents"));
String depth = request.getParameter("depth");
String uid = request.getParameter("uid"); 

boolean status = BoardQuery.reply(no, title, name, contents, uid, depth);

if(status==true){
	 response.sendRedirect("list.jsp?page=1");
} else response.sendRedirect("error.jsp");


%>
    