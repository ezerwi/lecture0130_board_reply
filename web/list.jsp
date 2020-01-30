<%--
  Created by IntelliJ IDEA.
  User: WnJ
  Date: 2020/01/30
  Time: 20:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@
        page import = "java.sql.SQLException, java.sql.ResultSet, com.wjh.board.BoardQuery, com.wjh.board.DB, com.wjh.board.Encoding"
%>

<%
  int total_articles = BoardQuery.total_articles();
  int total_pages = (total_articles/20)+1;
  int pages = Integer.parseInt(request.getParameter("page"));

  String no = "";
  String title = "";
  String hit = "";
  String writer = "";
  String time = "";
  String uid = "";
  int depth = 0;

  ResultSet rs = BoardQuery.show_pages(pages);
  rs.beforeFirst();

%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>게시글 목록</title>
</head>
<body>

<div align = "center">
  <h1>게시글 목록 보기</h1>
</div>
<input type = "button" value = "새로고침" onclick = "location.href='list.jsp?page=1'"><p>
  <div align = "center">
    <table border = 3>
      <tr>
        <th>글번</th>	<th>depth</th>	<th>uid</th>	<th>제목</th>	<th>조회수</th>	<th>작성자</th> 	<th>작성일시</th>
      </tr>

      <%
        while(rs.next()){
          no = Encoding.toUnicode(rs.getString("idx"));
          depth = Integer.parseInt(rs.getString("depth"));
          uid = rs.getString("uid");
          title = Encoding.toUnicode(rs.getString("title"));
          if(depth!=0){
            for(int i = 0; i<depth; i++){
              title=" > " + title;
            }

          }
          hit = Encoding.toUnicode(rs.getString("hit"));
          writer = Encoding.toUnicode(rs.getString("name"));
          time = Encoding.toUnicode(rs.getString("mkdate"));

      %>

      <tr>
        <td><%=no %></td>	<td><%=depth %></td>	<td><%=uid %></td>	<td><a href = "hit.jsp?no=<%=no%>"><%=title %></a></td>	<td><%=hit %></td>	<td><%=writer %></td>	<td><%=time %></td>
      </tr>

      <%
        }
      %>

    </table><p>

<%
  for(int page_num = 1; page_num < total_pages+1 ; page_num++){
%>
  <input type = "button" value = "<%=page_num%>" onclick = "location.href = 'list.jsp?page=<%=page_num%>'" />&nbsp;
<%
  }
%>
<p>

  <input type = "button" value = "새글쓰기" onclick = "location.href='write_form.jsp'">&nbsp;
<p>

  </div>
</body>
</html>