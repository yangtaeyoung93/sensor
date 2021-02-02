<%@page import="com.seoulsi.util.HashUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>서울시복합센서운영시스템</title>
	<link rel=" shortcut icon" href="../../share/img/favicon.ico">
	<link rel="icon" href="../../share/img/favicon.ico">
	
	<link rel="stylesheet" type="text/css" href="../../share/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="../../share/css/bootstrap-theme.css"/>
	<link rel="stylesheet" type="text/css" href="../../share/css/xeicon.css"/>
	<link rel="stylesheet" type="text/css" href="../../share/css/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="../../share/css/base.css"/>
	<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanumgothic.css">
	<link rel="stylesheet" type="text/css" href="../../share/css/layout.css"/>
	<link rel="stylesheet" type="text/css" href="../../share/css/menu.css"/>

	<script type="text/javascript" src="../../share/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="../../share/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../../share/js/jquery-ui.min.js"></script>
	
	<link href="../../share/css/board.css" rel="stylesheet" />

	<!-- chartjs -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.css">
    <script src="../../share/js/chartjs/moment.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<!-- alertify -->	
    <script src="../../share/alertifyjs/alertify.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../../share/alertifyjs/css/alertify.min.css"/>
	<link rel="stylesheet" type="text/css" href="../../share/alertifyjs/css/bootstrap.min.css"/>
	
    
	<script type="text/javascript" src="../../share/js/common.js"></script>
	
	<!-- 	easyui -->
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.edatagrid.js"></script>
    <link rel="stylesheet" type="text/css" href="../../share/css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../share/css/easyui/icon.css">
    <style>
    	body {
    		overflow: hidden;
    	}
    </style>
</head>
<body>

		<script>
			$.fn.serializeObject = function() {
			    var obj = null;
			    try {
			        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
			            var arr = this.serializeArray();
			            if (arr) {
			                obj = {};
			                jQuery.each(arr, function() {
			                    obj[this.name] = this.value;
			                });
			            }//if ( arr ) {
			        }
			    } catch (e) {
			        alert(e.message);
			    } finally {
			    }
			 
			    return obj;
			};
		</script>
		<div class="dim"></div>