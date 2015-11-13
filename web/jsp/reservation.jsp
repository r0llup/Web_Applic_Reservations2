<%-- 
    Document   : reservation
    Created on : 22 oct. 2012, 14:10:32
    Author     : Sh1fT
--%>

<%@page import="beans.BeanDBAccessMySQL"%>
<%@page import="com.sun.xml.internal.ws.api.pipe.NextAction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.LinkedList"%>
<%@page import="beans.BeanDBAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
    // login check
    Integer idVoyageur = (Integer) session.getAttribute("idVoyageur");
    Boolean logged = (Boolean) session.getAttribute("logged");
    if ((logged == null) || (!logged))
        response.sendRedirect("/Web_Applic_Reservations2/jsp/login.jsp");
    // common check
    Boolean basket = (Boolean) session.getAttribute("basket");
    if ((basket == null) || (!basket))
        response.sendRedirect("/Web_Applic_Reservations2/jsp/basket.jsp");
    BeanDBAccess beanDbAccess = (BeanDBAccess) session.getAttribute("beanDbAccess");
    beanDbAccess = new BeanDBAccessMySQL("localhost", 3306, "bd_hotels",
            "root", "", "true", false);
    if ((beanDbAccess == null) || (!basket))
        response.sendRedirect("/Web_Applic_Reservations2/jsp/catalog.jsp");
    // insert to reservations
    String query = "INSERT INTO reservations(idReservation, chambre," +
            "voyageurTitulaire, paye) SELECT ?, caddy.idChambre, caddy.idVoyageur," +
            " true FROM caddy WHERE caddy.idVoyageur = ?;";
    PreparedStatement ps = beanDbAccess.getDBConnection().prepareStatement(query);
    ps.setInt(1, 0);
    ps.setInt(2, idVoyageur);
    beanDbAccess.executeUpdate(ps);
    ps.close();
    beanDbAccess.getDBConnection().commit();
    // delete to basket
    query = "DELETE FROM caddy WHERE idVoyageur = ?;";
    ps = beanDbAccess.getDBConnection().prepareStatement(query);
    ps.setInt(1, idVoyageur);
    beanDbAccess.executeUpdate(ps);
    beanDbAccess.getDBConnection().commit();
    beanDbAccess.stop();
%>
<fmt:setBundle basename="resource_bundle" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web_Applic_Reservations2 :: <fmt:message key="reservation" /></title>
    </head>
    <body>
        <h1>Web_Applic_Reservations2 :: <fmt:message key="reservation" /></h1>
        <jsp:include page="menu.jsp" />
        <p><fmt:message key="reservation.success" /></p>
    </body>
</html>