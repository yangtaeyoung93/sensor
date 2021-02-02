<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- BEGIN :: Receive Ware List Modal -->
<div class="modal fade receiveWareListDetail" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg"
		style="transform: translateY(-50%); top: 50%; padding: 20px; width: 600px;">
		<div class="modal-content" style="padding: 16px;">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h3><strong id="wareCatMsg"></strong></h3>
				<hr/>
				<div id="modalFormDiv" class="info-wrap">
					<table id="wareListTable" class="modalTable">
					</table>
					<div id="noticeMsgDiv" class="msgDiv"></div>
				</div>
				<hr/>
			</div>
			<!-- modal-body -->
		</div>
		<!-- modal-content -->
	</div>
</div>
<!-- END :: Receive Ware List Modal -->

<!-- BEGIN :: Status Ware List Modal -->
<div class="modal fade statusWareListDetail" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg"
		style="transform: translateY(-50%); top: 50%; padding: 20px; width: 600px;">
		<div class="modal-content" style="padding: 16px;">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h3><strong id="statusWareCatMsg"></strong></h3>
				<hr/>
				<div id="modalFormDiv" class="info-wrap">
					<table id="statusWareListTable" class="modalTable">
					</table>
					<div id="statusNoticeMsgDiv" class="msgDiv"></div>
				</div>
				<hr/>
			</div>
			<!-- modal-body -->
		</div>
		<!-- modal-content -->
	</div>
</div>
<!-- END :: Bad Ware List Modal -->