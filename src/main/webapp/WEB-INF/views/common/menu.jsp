<%@page import="com.seoulsi.dto.MemberDto"%>
<%@page import="java.util.Optional"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
	ArrayList list = (ArrayList)request.getAttribute("menu"); 
%>

		<c:forEach items="<%=list %>" var="i" varStatus="status">

			<c:choose>
				<c:when test="${i.menuId % 100 == 0}">
					<c:if test="${status.index ne '0' }">
								</ul>
							</div>
						</li>
					</c:if>
					<li class="col-xs-3"><a href="#">${i.caption }</a>
						<div class="sub_menu">
							<ul>
					
				</c:when>
				<c:otherwise>
					<li><a href="/${i.path}">${i.caption }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
				
