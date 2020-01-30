<%--
  Created by IntelliJ IDEA.
  User: WnJ
  Date: 2020/01/30
  Time: 22:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@
    page import ="com.wjh.board.BoardQuery, java.sql.SQLException, java.sql.ResultSet"
%>

<%
        String no = request.getParameter("no");
        boolean status = BoardQuery.hit_up(no);
        if(status==true) {
                response.sendRedirect("detail.jsp?no="+no);
        }
        else response.sendRedirect("error.jsp");

%>