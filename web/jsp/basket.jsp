<%-- 
    Document   : basket
    Created on : 22 oct. 2012, 15:48:09
    Author     : Sh1fT
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.BeanDBAccess"%>
<%@page import="beans.BeanDBAccessMySQL"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
    // common check
    Boolean basket = (Boolean) session.getAttribute("basket");
    if ((basket == null) || (!basket)) {
        basket = true;
        session.setAttribute("basket", basket);
    }
    // login check
    Integer idVoyageur = (Integer) session.getAttribute("idVoyageur");
    Boolean logged = (Boolean) session.getAttribute("logged");
    if ((logged == null) || (!logged))
        response.sendRedirect("/Web_Applic_Reservations2/jsp/login.jsp");
    // db setup
    BeanDBAccess beanDbAccess = (BeanDBAccess) session.getAttribute("beanDbAccess");
    beanDbAccess = new BeanDBAccessMySQL("localhost", 3306, "bd_hotels",
            "root", "", "true", false);
    // insert to basket
    String query = "INSERT INTO caddy VALUES(?, ?);";
    PreparedStatement ps = beanDbAccess.getDBConnection().prepareStatement(query);
    Enumeration params = request.getParameterNames();
    while(params.hasMoreElements()) {
        String param = (String) params.nextElement();
        if (param.contains("reserve")) {
            ps.setInt(1, idVoyageur);
            ps.setString(2, request.getParameter(param));
            beanDbAccess.executeUpdate(ps);
        }
    }
    ps.close();
    beanDbAccess.getDBConnection().commit();
    // delete to basket
    query = "DELETE FROM caddy WHERE idVoyageur = ? AND idChambre LIKE ?;";
    ps = beanDbAccess.getDBConnection().prepareStatement(query);
    String deleteItem = request.getParameter("deleteItem");
    if (deleteItem != null) {
        params = request.getParameterNames();
        while(params.hasMoreElements()) {
            String param = (String) params.nextElement();
            if (param.contains("delete")) {
                ps.setInt(1, idVoyageur);
                ps.setString(2, request.getParameter(param));
                beanDbAccess.executeUpdate(ps);
            }
        }
    }
    ps.close();
    beanDbAccess.getDBConnection().commit();
    // select to basket
    query = "SELECT * from caddy WHERE idVoyageur = ?;";
    ps = beanDbAccess.getDBConnection().prepareStatement(query);
    ps.setInt(1, idVoyageur);
    ResultSet rs = beanDbAccess.executeQuery(ps);
    ResultSetMetaData rsmd = rs.getMetaData();
    Integer numColumns = rsmd.getColumnCount();
    Integer rowCount = 0;
    Boolean empty = true;
    if (rs.next())
        empty = false;
    rs.beforeFirst();
%>
<fmt:setBundle basename="resource_bundle" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web_Applic_Reservations2 :: <fmt:message key="basket" /></title>
    </head>
    <body>
        <h1>Web_Applic_Reservations2 :: <fmt:message key="basket" /></h1>
            <jsp:include page="menu.jsp" />
            <% if (empty) { %>
            <p><fmt:message key="basket.empty" /></p>
            <% } else { %>
            <p><fmt:message key="basket.content" /></p>
            <form name="basket" action="basket.jsp?deleteItem" method="POST">
                <table border="1" cellpadding="1" cellspacing="1">
                    <tr>
                        <td><fmt:message key="basket.delete" /></td>
                    <% for (Integer i=1; i < numColumns+1; i++) { %>
                        <td><%= rsmd.getColumnName(i) %></td>
                    <% } %>
                    </tr>
                    <% while (rs.next()) { rowCount++; %>
                    <tr>
                        <td>
                            <input type="checkbox" name="delete<%= rowCount %>"
                                   value="<%= rs.getString(2) %>" />
                        </td>
                    <% for (Integer i=1; i < numColumns+1; i++) { %>
                        <td><%= rs.getString(i)%></td>
                    <% } %>
                    </tr>
                    <% } rs.close(); beanDbAccess.stop(); %>
                </table>
                <input type="submit" value="<fmt:message key="basket.validate" />" name="validate" />
            </form>
            <p><a href="reservation.jsp"><fmt:message key="basket.confirm" /></a></p>
            <% } %>
    </body>
</html>