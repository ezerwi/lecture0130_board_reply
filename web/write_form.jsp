<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
</head>
<body>

<div align = "center">
<h1>글을 써보자</h1>
</div>
<form action = "write_insert.jsp" accept-charset = "UTF-8" method = get>
<fieldset>
<legend>제목</legend>
	<input type = "text" name = "title" placeholder = "제목을 써주세요" size = 70% required />
</fieldset><p>
<fieldset>
<legend>작성자</legend>
	<input type = "text" name = "name" placeholder = "작성자 이름을 써주세요" size = 70% required />
</fieldset><p>
<fieldset>
<legend>내용</legend>
	<textarea name = "contents" cols = 70 rows = 20 placeholder = "내용을 입력해주세요" required ></textarea>	
</fieldset><p>

<fieldset>
<legend>설정</legend>
	e-mail&nbsp;&nbsp;:&nbsp;&nbsp;<input type ="email" name = "email" size = "50%" /> 
</fieldset><p>

<div align = "center" >
	<input type = "reset"  value = "다시쓰기" />
	<input type = "submit" value = "작성완료" />
</div>
</form>

</body>
</html>