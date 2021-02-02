<%@page import="com.seoulsi.dto.MemberDto"%>
<%@page import="java.util.Optional"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="com.seoulsi.util.HashUtil"%>
<%@page import="com.seoulsi.util.AES256Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta name="robots " content="noindex, nofollow">
	<title>서울시복합센서운영시스템</title>
	<link rel=" shortcut icon" href="../../share/img/favicon.ico">
	<link rel="icon" href="../../share/img/favicon.ico">

	<link rel="stylesheet" type="text/css" href="../../share/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="../../share/css/bootstrap-theme.css" />
	<link rel="stylesheet" type="text/css" href="../../share/css/xeicon.css" />
	<link rel="stylesheet" type="text/css" href="../../share/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="../../share/css/base.css" />
	<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanumgothic.css">
	<link rel="stylesheet" type="text/css" href="../../share/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="../../share/css/menu.css" />

	<!-- <script type="text/javascript" src="../../share/js/jquery-3.5.1.js"></script> -->
	<script type="text/javascript" src="../../share/js/jquery-1.12.4.min.js"></script>
	
	<script type="text/javascript" src="../../share/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../../share/js/jquery-ui.min.js"></script>
	<!-- 	validate-jQuery -->
	<!-- <script type="text/javascript" src="../../share/js/validate/additional-methods.min.js"></script> -->
	<script type="text/javascript" src="../../share/js/validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="../../share/js/validate/messages_ko.min.js"></script>

	<link href="../../share/css/board.css" rel="stylesheet" />

	<!-- alertify -->
	<script src="../../share/alertifyjs/alertify.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../../share/alertifyjs/css/alertify.min.css" />
	<link rel="stylesheet" type="text/css" href="../../share/alertifyjs/css/bootstrap.min.css" />


	<script type="text/javascript" src="../../share/js/common.js"></script>
	<script type="text/javascript" src="../../share/js/page/common/common.js"></script>

	<!-- 	easyui -->
	<script type="text/javascript" src="../../share/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../share/js/easyui/jquery.edatagrid.js"></script>
	<link rel="stylesheet" type="text/css" href="../../share/css/easyui/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../share/css/easyui/icon.css">
	
	


</head>
<%
	String userName = (String)request.getAttribute("userName"); 
	Boolean popup = (Boolean)request.getAttribute("900");
	pageContext.setAttribute("popup", popup);
%>

<body>
	<script>

		function popupCreate() {
				var popupWidth = 780;
				var popupHeight = 1000;

				var popupX = (window.screen.width / 2) - (popupWidth / 2);
				// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

				var popupY= (window.screen.height / 2) - (popupHeight / 2);
				// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

				window.open('/popup01', '', 'scrollbars=yes,status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
			}
	</script>
	<div class="wrap">
		<nav>
			<div class="gnb">
				<div class="container">
					<div class="logo">
						<img src="../../img/common/top_logo.png">
					</div>
					<div class="my">
						<c:if test="${popup}">
							<span onclick="popupCreate()" style="cursor: pointer; font-weight: bold;padding: 5px 15px;border: 1px solid #0c82e9;margin-right: 20px;color: #0c82e9;">대시보드 보기</span>
						</c:if>
						<%=userName%>님 <a href="/logout?userId=">로그아웃</a>
					</div>
				</div><!-- container -->
			</div><!-- gnb -->

			<div class="menu_wrap">
				<div class="container">
					<div class="row">
						<div class="col-xs-5">
							스마트 서울 도시데이터 센서 (S-DoT) 운영시스템
						</div>
						<div class="col-xs-7 top_menu">
							<ul class="row rows">
								<jsp:include page="./menu.jsp"></jsp:include>
							</ul>
						</div>
						</li>
						</ul>
						<div class="bg"></div>
					</div><!-- top_menu -->
				</div><!-- row -->
			</div><!-- container -->
	</div><!-- menu_wrap -->
	<div class="bread container"
		style="position: absolute; bottom:-35px; left: 50%; transform: translateX(-50%); text-align: right;">
	</div>
	</nav><!-- web -->

	<div class="dim"></div>