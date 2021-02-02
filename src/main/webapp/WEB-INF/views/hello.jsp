<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="./common/header.jsp"></jsp:include>

<link rel="stylesheet"
	href="../../share/treeview/css/jquery.treeview.css" />
<link rel="stylesheet" href="../../share/treeview/css/screen.css" />
<script src="../../share/treeview/lib/jquery.cookie.js"
	type="text/javascript"></script>
<script src="../../share/treeview/lib/jquery.treeview.js"
	type="text/javascript"></script>

<script type="text/javascript">
        $(function() {
            $("#tree").treeview({
                collapsed: true,
                animated: "medium",
                control:"#sidetreecontrol",
                persist: "location"
            });
        })
    </script>
<style>
.info-wrap {
	border: 1px solid #c9c9c9;
	padding: 15px;
	background: white;
	margin-left: 30px;
	height: 690px;
}

.tree {
	height: 690px;
	overflow-y: auto;
	background: white;
	border: 1px solid #c9c9c9;
	padding: 15px;
}

.sub_title+.row {
	margin-bottom: 60px;
}

.row .title {
	text-align: center;
}
.form-group .row {
    margin-bottom: 30px;
}
</style>
<div id="sensor" class="body_wrap">

	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">기기 등록</h1>
		</div>
		<!-- sub_title -->
		<div class="row">
			<div class="col-xs-2 tree">
				<ul id="tree">
					<c:forEach items="${lists}" var="list" varStatus="status">
						<li id="tree-${status.index}"><strong>${list.gu}</strong></li>

						<script>
						var a = [${list.equi}];
						var b = {"a":"b"};
						console.log("${list.gu}", a,b);
						
						function depth(arr) {
							var text = "<ul>"
							$.each(arr, function(a,b) {
								text += '<li style="cursor: pointer;" onclick="infoSet(this);" id="'+b+'">'+b+'</li>';
							})
							text+="</ul>"
							$('#tree-${status.index}').append(text)
						}
						
						depth(a);
					</script>
					</c:forEach>
				</ul>
			</div>
			<div class="col-xs-10 info">
				<div class="info-wrap">
					<form>
						<div class="form-group">
							<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
								<div class="col-xs-8" style="line-height: 30px;">
									기기 명 - V02Q1940059
								</div>
								<div class="col-xs-4">
									<input class="search_btn col-xs-3" type="button" value="추가" style="background: white; color: #666; border: 1px solid #c9c9c9;"/>
									<input class="search_btn col-xs-offset-1 col-xs-3" type="button" value="삭제" style="margin-left: 40px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
									<input class="search_btn col-xs-offset-1 col-xs-3" type="submit" value="저장" style="margin-left: 40px;"/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-1 title">설치구분</div>
								<div class="col-xs-3">
									<select id="sel-1">
										<option>설치구분 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">기기종류</div>
								<div class="col-xs-3">
									<select id="sel-2">
										<option>가기종류 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">스테이션명</div>
								<div class="col-xs-3">
									<input class="form-control" type="text"/>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-1 title">위도</div>
								<div class="col-xs-3">
									<input class="form-control" type="text"/>
								</div>
								<div class="col-xs-1 title">경도</div>
								<div class="col-xs-3">
									<input class="form-control" type="text"/>
								</div>

							</div>
							
							<div class="row">
								<div class="col-xs-1 title">센서타입</div>
								<div class="col-xs-2">
									<select id="sel-3">
										<option>센서타입 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">용도1</div>
								<div class="col-xs-2">
									<select id="sel-4">
										<option>용도1 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">용도2</div>
								<div class="col-xs-2">
									<select id="sel-5">
										<option>용도2 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">용도3</div>
								<div class="col-xs-2">
									<select id="sel-6">
										<option>용도3 선택</option>
									</select>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-1 title">설치년도</div>
								<div class="col-xs-3">
									<select id="sel-7">
										<option>설치년도 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">관리번호</div>
								<div class="col-xs-3">
									<input class="form-control" type="text"/>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-1 title">행정구</div>
								<div class="col-xs-3">
									<select id="sel-8">
										<option>행정구 선택</option>
									</select>
								</div>
								<div class="col-xs-1 title">도로명</div>
								<div class="col-xs-3">
									<input class="form-control" type="text"/>
								</div>
								<div class="col-xs-1 title">행정명</div>
								<div class="col-xs-3">
									<input class="form-control" type="text"/>
								</div>
							</div>
							
							<div class="row">
								<label class="col-xs-offset-1 choice-label"><input id="c-day" value="day" type="checkbox"><i></i>  설치여부</label>
								<label class="choice-label"><input id="c-day2" value="day" type="checkbox"><i></i>  완료여부</label>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function infoSet(target) {
		var id = $(target)[0].id;
	}
	function infoSelect(target, data, parse) {
		var text = "";
		$.each(data, function(a,b) {
			if(b.sortCd == parse) {
				if(b.relCd1 == "null") {
					text += "<option value='"+b.code+"'>"+b.codeNm+"</option>"
				} else {
					text += "<option value='"+b.code+"'>"+b.relCd1+"</option>"
				}
			}
		})
		
		$("#"+target).append(text)
	}
	$(document).ready(function() {
		$.ajax({
			url: '/setting/equiCommon',
			type: 'GET',
			success: function(r) {
				infoSelect("sel-1", r.data, "측정요소")
				infoSelect("sel-2", r.data, "기기종류")
				infoSelect("sel-3", r.data, "센서유형")
				infoSelect("sel-4", r.data, "용도1")
				infoSelect("sel-5", r.data, "용도2")
				infoSelect("sel-6", r.data, "용도3")
				infoSelect("sel-7", r.data, "설치년도")
				infoSelect("sel-8", r.data, "서울시구정의")
			}
		})
	})
</script>
<jsp:include page="./common/footer.jsp"></jsp:include>