var totalData = 1000;    // 총 데이터 수
    var dataPerPage = 20;    // 한 페이지에 나타낼 데이터 수
    var pageCount = 10;        // 한 화면에 나타낼 페이지 수
    
    var board = {

        paging : function (totalData, dataPerPage, pageCount, currentPage, csrfToken){
            // console.log("currentPage : " + currentPage);
            var _this = this;
            var totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
            var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹
            
            // console.log("pageGroup : " + pageGroup);
            
            var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
            if(last > totalPage)
                last = totalPage;
            var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
            var next = last+1;
            var prev = first-1;
            
            // first 음수 처리
            first = (first < 0) ? 1 : first;
            
            var $pingingView = $("#page");
            
            var html = "";

            if(prev > 0)
                html += '<a data-page="'+i+'" href="?page='+prev+'" class="prev" id="prev" title="이전 블럭"><img src="../../img/common/left.png"></a>';
            
            for(var i=first; i <= last; i++){
                html += '<a data-page="'+i+'" href="?page='+i+'" id="page'+i+'" title="'+i+' page">'+i+'</a>';
            }
            
            if(last < totalPage)
                html += '<a data-page="'+i+'" href="?page='+next+'" class="next" id="next" title="다음 블럭"><img src="../../img/common/right.png"></a>';
            
            $("#page span").html(html);    // 페이지 목록 생성
            $("#page a#page" + currentPage).addClass('on');    // 현재 페이지 표시
            
            $("#page a").click(function(e){
                e.preventDefault();
                var to = $('#to').val();
				var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
				var from = $('#from').val();
				var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)
				var gu = $('#gu').val();
				var equi = $('#equi').val();
                var $item = $(this);
                var $id = $item.attr("id");
                var selectedPage = $item.text();
                
                if($id == "next")    selectedPage = next;
                if($id == "prev")    selectedPage = prev;
                
                $.ajax({
					url: '/sensor/equiSearchList',
					type: 'POST',
					data: {
						"toDate":toDate, "fromDate":fromDate, "gu":gu, "equiInfoKey": equi,
						"_csrf" : csrfToken,
						"pageStart": $(this).data('page'), "pageEnd": 20
					},
					success: function(r) {
						console.log(r);
						sensor.rowSet(r.data);
						_this.paging(totalData, dataPerPage, 10, $(this).data('page'), r.data, 'rowSet');
						//board.paging(num, 20, 10, <?= $pageNum ?>);
					}
				})
            });
                                               
            
        }
        
    }
