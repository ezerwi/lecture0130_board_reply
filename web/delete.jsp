<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    
    import = "java.sql.SQLException, java.sql.ResultSet, com.wjh.board.BoardQuery, com.wjh.board.Encoding"    
    
%>

<%
String no = request.getParameter("no");

boolean status = BoardQuery.delete_one(no);

if(status==true){
	response.sendRedirect("list.jsp?page=1");
}
else response.sendRedirect("error.jsp");
%>
