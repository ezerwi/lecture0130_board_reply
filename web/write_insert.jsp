<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@
page import = "java.sql.SQLException, java.sql.ResultSet, com.wjh.board.BoardQuery, com.wjh.board.Encoding"
 %>
 
 <%
 String title = Encoding.toLatin(request.getParameter("title"));
 String name = Encoding.toLatin(request.getParameter("name"));
 String contents = Encoding.toLatin(request.getParameter("contents"));
 
 boolean status = BoardQuery.insert_one(title, name, contents);
 
 if(status==true){
	 response.sendRedirect("list.jsp?page=1");
 } else response.sendRedirect("error.jsp");
 
 %>
