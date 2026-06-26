<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>Pending Requests</h2>
<c:forEach var="req" items="${requestList}">
  <p>Request ${req.request_id} by Researcher ${req.researcher_id} for File ${req.filename} 
    <form action="ApproveRequestServlet" method="post" style="display:inline;">
      <input type="hidden" name="requestId" value="${req.request_id}">
      <button name="action" value="APPROVE">Approve</button>
      <button name="action" value="REJECT">Reject</button>
    </form>
  </p>
</c:forEach>


</body>
</html>