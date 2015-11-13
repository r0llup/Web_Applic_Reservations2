<%-- 
    Document   : catalog
    Created on : 20-oct.-2012, 21:21:15
    Author     : Sh1fT
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.BeanDBAccess"%>
<%@page import="beans.BeanDBAccessMySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<jsp:useBean id="beanDbAccess" class="beans.BeanDBAccess" scope="session" />
<%
    // login check
    Boolean logged = (Boolean) session.getAttribute("logged");
    if ((logged == null) || (!logged))
        response.sendRedirect("/Web_Applic_Reservations2/jsp/login.jsp");
    // db setup
    beanDbAccess = new BeanDBAccessMySQL("localhost", 3306, "bd_hotels",
            "root", "", "true", false);
    String query = "SELECT * FROM chambres;";
    ResultSet rs = beanDbAccess.executeQuery(query);
    ResultSetMetaData rsmd = rs.getMetaData();
    Integer numColumns = rsmd.getColumnCount();
    Integer rowCount = 0;
%>
<fmt:setBundle basename="resource_bundle" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web_Applic_Reservations2 :: <fmt:message key="catalog" /></title>
    </head>
    <body>
        <h1>Web_Applic_Reservations2 :: <fmt:message key="catalog" /></h1>
        <jsp:include page="menu.jsp" />
        <form name="basket" action="basket.jsp" method="POST">
            <table border="1" cellpadding="1" cellspacing="1">
                <tr>
                    <td><fmt:message key="catalog.reservate" /></td>
                <% for (Integer i=1; i < numColumns+1; i++) { %>
                    <td><%= rsmd.getColumnName(i) %></td>
                <% } %>
                </tr>
                <% while (rs.next()) { rowCount++; %>
                <tr>
                    <td>
                        <input type="checkbox" name="reserve<%= rowCount %>"
                               value="<%= rs.getString(1) %>" />
                    </td>
                <% for (Integer i=1; i < numColumns+1; i++) { %>
                    <td><%= rs.getString(i)%></td>
                <% } %>
                </tr>
                <% } rs.close(); beanDbAccess.stop(); %>
            </table>
            <input type="submit" value="<fmt:message key="catalog.validate" />" name="validate" />
        </form>
    </body>
</html>