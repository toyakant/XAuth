<%@ page import="java.sql.*, com.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blockchain Data Viewer</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #eef2f3, #ffffff);
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-top: 30px;
        }
        form {
            text-align: center;
            margin-top: 20px;
        }
        select {
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
            outline: none;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            border: none;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        table {
            width: 95%;
            margin: 30px auto;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #2c3e50;
            color: white;
            text-transform: uppercase;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        td {
            color: #333;
        }
    </style>
</head>
<body>

<h2>Blockchain Data Viewer</h2>

<form method="get">
    <label for="tableSelect"><b>Select Blockchain Table:</b></label>
    <select name="table" id="tableSelect">
        <option value="primary_chain" <%= "primary_chain".equals(request.getParameter("table")) ? "selected" : "" %>>Primary Chain</option>
        <option value="secondary_chain" <%= "secondary_chain".equals(request.getParameter("table")) ? "selected" : "" %>>Secondary Chain</option>
    </select>
    <input type="submit" value="View Data" />
</form>

<%
    String selectedTable = request.getParameter("table");
    if (selectedTable == null) selectedTable = "primary_chain";

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;

        if ("primary_chain".equals(selectedTable)) {
            ps = con.prepareStatement("SELECT * FROM primary_chain ORDER BY block_id DESC");
            rs = ps.executeQuery();
%>

<h2>Primary Chain Data</h2>
<table>
    <tr>
        <th>Block ID</th>
        <th>Previous Hash</th>
        <th>Current Hash</th>
        <th>User ID</th>
        <th>Action Type</th>
        <th>Action Details</th>
        <th>Timestamp</th>
    </tr>
<%
            while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("block_id") %></td>
        <td><%= rs.getString("previous_hash") %></td>
        <td><%= rs.getString("current_hash") %></td>
        <td><%= rs.getInt("user_id") %></td>
        <td><%= rs.getString("action_type") %></td>
        <td><%= rs.getString("action_details") %></td>
        <td><%= rs.getTimestamp("timestamp") %></td>
    </tr>
<%
            }
        } else if ("secondary_chain".equals(selectedTable)) {
            ps = con.prepareStatement("SELECT * FROM secondary_chain ORDER BY block_id DESC");
            rs = ps.executeQuery();
%>

<h2>Secondary Chain Data</h2>
<table>
    <tr>
        <th>Block ID</th>
        <th>Previous Hash</th>
        <th>Current Hash</th>
        <th>User ID</th>
        <th>Filename</th>
        <th>File Path</th>
        <th>Original Path</th>
        <th>Encryption Key</th>
        <th>File Hash</th>
        <th>Analysis Data</th>
        <th>Timestamp</th>
    </tr>
<%
            while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("block_id") %></td>
        <td><%= rs.getString("previous_hash") %></td>
        <td><%= rs.getString("current_hash") %></td>
        <td><%= rs.getInt("user_id") %></td>
        <td><%= rs.getString("filename") %></td>
        <td><%= rs.getString("file_path") %></td>
        <td><%= rs.getString("original_path") %></td>
        <td><%= rs.getString("encryption_key") %></td>
        <td><%= rs.getString("file_hash") %></td>
        <td><%= rs.getString("analysis_data") %></td>
        <td><%= rs.getTimestamp("timestamp") %></td>
    </tr>
<%
            }
        }

        if (rs != null) rs.close();
        if (ps != null) ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</table>

</body>
</html>
