<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h2>Available Files</h2>
<c:forEach var="file" items="${fileList}">
  <p>${file.filename} 
    <form action="RequestFileServlet" method="post" style="display:inline;">
      <input type="hidden" name="fileId" value="${file.block_id}">
      <input type="hidden" name="ownerId" value="${file.user_id}">
      <button type="submit">Request Access</button>
    </form>
  </p>
</c:forEach>


</body>
</html>