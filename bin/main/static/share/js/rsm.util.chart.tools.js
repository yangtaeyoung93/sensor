var SwatChart = (function () {
	var __charts = {};
	var getCustomColors = function(colorsetName) {
		colorsetName = colorsetName || "default";
		var colorset = {
			"default": ["#6633FF", "#CC33FF", "#FF33CC", "#FF3366", "#3366FF", "#3D00F5", "#2E00B8", "#FF6633", "#33CCFF", "#8AB800", "#B8F500", "#FFCC33", "#33FFCC", "#33FF66", "#66FF33", "#CCFF33"]
			,"color1":["#67b7dc","#eed44a","#d593b9","#92c96c","#F8FF01","#B0DE09","#04D215","#0D8ECF","#0D52D1","#2A0CD0","#8A0CCF","#CD0D74","#754DEB","#DDDDDD","#999999","#333333","#000000","#57032A","#CA9726","#990000","#4B0C25"]
		};
		return colorset[colorsetName] || [];
	};
	var getEmptyData = function(pChartOptions) {
		var emptyRow = {};
		$.each(pChartOptions.valueAxesIds, function(i, id) {
			emptyRow[id] = 0;
		});
		if(pChartOptions.categoryType == "date") {
			var dataDateFormat = pChartOptions.dataDateFormat.toUpperCase()
			.replace('JJ', 'HH')
			.replace('mm', 'MM')
			.replace('NN', 'MI');
			emptyRow[pChartOptions.categoryField] = (new Date()).format(dataDateFormat);
		}
		else {
			emptyRow[pChartOptions.categoryField] = "-";
		}
		return [emptyRow];
	}
	var createChart = function(selector, options) {
		if (__charts[selector] && options["recreate"]) delete __charts[selector];
		else if(__charts[selector]) return;
		var chart = null;
		var chartOptions = {
				
		
			//pathToImages: (window["gGlobal"].rootPath + "/scripts/amcharts_3.17.1/images/"),
			pathToImages: 	gGlobal.ROOT_PATH+ "/scripts/amcharts/images/",
			graphsType:"line",
			categoryType:"date",
			trendLines:[],
			zoomable:false,
			rotate:false,
			dataDateFormat:"YYYY-MM-DD JJ:NN:SS",
			displayDateFormat:"YYYY-MM-DD JJ:NN:SS",
			theme:"default",
			legendPosition:"top", //"bottom",
			legendEnable:true,
			legendAlign:"right",
			legendTop:0,
			legendLeft:0,
			legendBackgroundAlpha:0,
			legendBorderAlpha:0,
			legendBorderColor:"#000000",
			categoryField:"date",
			valueAxesIds:["value"],
			graphsTitles:["value"],
			categoryAxisLabelRotation:15,
		    categoryAxisMinPeriod:"hh", //ss-second, mm-minute, hh-hour, DD-day, MM-month, YYYY-year
		    categoryAxisParseDates:true,
			graphsBalloonTitle:options.graphsType == "line"?"title" :"category",
		    graphsConnect:true,
		    
		    
		    graphsColorField:null,
		    graphsColors:[],
		    graphsCustomColors:false,
		    graphsCustomColorsName:"defalut",
		    chartScrollbarEnable:false,
		    recreate:false
		};
		$.each(options, function(key, value) {
			chartOptions[key] = value;
		});
		/* 범례를 우측상단에 위치 */
        if (chartOptions.legendPosition == "absolute") {
        	chartOptions.legendAlign = "right";
        	chartOptions.legendTop = -10;
        	chartOptions.legendLeft = 5;
        	chartOptions.legendBackgroundAlpha = 0.7;
        	chartOptions.legendBorderColor = "LightGray";
        	chartOptions.legendBorderAlpha = 0.7;
        }
		if (chartOptions.graphsCustomColors === true) {
			chartOptions.graphsColors = getCustomColors(chartOptions.graphsCustomColorsName);
		}
		var getValueAxesIds = function(pChartOptions) {
			var valueAxesSettings =[];
			
			$.each(pChartOptions.valueAxesIds, function(i, valueField) {
				
				valueAxesSettings.push({
					integerOnly:true,
					position:'left',
					dashLength:0
				}
				)
			});
			
			// ADD BY YAKIM 롤링되는 화면의 타이틀 추가를 위해. 추가함
			if("valueAxes" in pChartOptions )  {
				
				$.each( pChartOptions.valueAxes, function( key, value ) {
					valueAxesSettings[key] = value ;					
					});				
			}			
			
			return valueAxesSettings;
		}
		//LineGraph
		/*
		var getLineGraphsSettings = function(pChartOptions) {
			var graphSettings = [];
			$.each(pChartOptions.valueAxesIds, function(i, valueField) {
				graphSettings.push({
					useNegativeColorIfDown:true,
					labelPosition:"top",
					labelText:"[[value]]",
					balloonText:"[[" + pChartOptions.graphsBalloonTitle + "]] : [[value]]",
					bullet:"round",
					bulletBorderAlpha:1,
					bulletBorderColor:"#FFFFFF",
					hideBulletsCount:50,
					lineThickness:1.5,
					lineColor:pChartOptions.graphsColors[i]?pChartOptions.graphsColors[i] :null,
					title:pChartOptions.graphsTitles[i],
					valueField:valueField,
			        type:pChartOptions.graphsType,
			        connect:pChartOptions.graphsConnect,
			        colorField:pChartOptions.graphsColorField
				});
			});
			return graphSettings;
		};
		*/
		
		 //LineGraph
        var getLineGraphsSettings = function(pChartOptions) {
            var graphSettings = [];
            $.each(pChartOptions.valueAxesIds, function(i, valueField) {
                graphSettings.push({
                    useNegativeColorIfDown : true,
                    labelPosition : "top",
                    labelText : "[[value]]",
                    balloonText : "[[" + pChartOptions.graphsBalloonTitle + "]] : [[value]]",
                    bullet : "round",
                    bulletBorderAlpha : 1,
                    useLineColorForBulletBorder: true,
                    bulletColor: "#FFFFFF",                    
                    /* bulletBorderColor : "#FFFFFF", */
                    hideBulletsCount : 50,
                    lineThickness : 1.5,
                    lineColor : pChartOptions.graphsColors[i] ? pChartOptions.graphsColors[i] : null,
                    title : pChartOptions.graphsTitles[i],
                    valueField : valueField,
                    type : pChartOptions.graphsType,
                    connect : pChartOptions.graphsConnect,
                    colorField : pChartOptions.graphsColorField,
                    bulletSize: 10
                });
            });
            return graphSettings;
        };
        
		//BarGraph
		var getBarGraphsSettings = function(pChartOptions) {
			var graphSettings = [];
			$.each(pChartOptions.valueAxesIds, function(i, valueField) {
				graphSettings.push({
					fontSize:12,
					labelPosition:"top",
					labelText:"[[value]]",
					balloonText:"[[" + pChartOptions.graphsBalloonTitle + "]] : [[value]]",
					fillAlphas:0.9,
					lineAlpha:pChartOptions.graphsColorField?0 :1,
					title:pChartOptions.graphsTitles[i],
					valueField:valueField,
					id:valueField,
			        type:pChartOptions.graphsType,
			        colorField:pChartOptions.graphsColorField
				});
			});
			return graphSettings;
		};
		var getGraphsSettings = {"line":getLineGraphsSettings, "column":getBarGraphsSettings};
		var zoomChart = function() {
			if(this.zoomToIndexes) {
				this.zoomToIndexes(130, this.length - 1);
			}
		};
		var supportsSVG = function() {
			return !!document.createElementNS && !!document.createElementNS('http://www.w3.org/2000/svg', "svg").createSVGRect;
		};
		var chartSettings = {
			fontFamily:"나눔고딕', NanumGothic, Verdana",
			fontSize:14,
		    type:"serial",
		    dataDateFormat:chartOptions.categoryType == "date"?chartOptions.dataDateFormat :null,
			theme:chartOptions.theme,
			startDuration:supportsSVG()?0.3 :0,
		    pathToImages: chartOptions.pathToImages,
		    rotate:chartOptions.rotate,
		    legend: {
		    	markerType:"circle",
		    	valueText:"[[value]]",
		    	valueWidth:0,
		    	marginLeft:10,
		    	marginRight:10,
		    	equalWidths:false,
		        useGraphSettings:false,
		        position:chartOptions.legendPosition,
		        align:chartOptions.legendAlign,
		        left:chartOptions.legendLeft,
		        top:chartOptions.legendTop,
		        backgroundAlpha:chartOptions.legendBackgroundAlpha,
		        borderAlpha:chartOptions.legendBorderAlpha,
		        borderColor:chartOptions.legendBorderColor
		    },
		    chartCursor: {
		    	cursorPosition:"mouse",
		    	fullWidth:true,
		    	cursorAlpha:0.1,
		    	categoryBalloonDateFormat:chartOptions.categoryType == "date"?chartOptions.displayDateFormat :null,
		    	valueLineEnabled:true,
		    	valueLineBalloonEnabled:true,
		        zoomable:chartOptions.zoomable,
				cursorColor:"#A8A8A8"
		    },
		    chartScrollbar: {
		    	enabled:chartOptions.chartScrollbarEnable
		    },
		    valueAxes:getValueAxesIds(chartOptions),
		    categoryField:chartOptions.categoryField,
		    categoryAxis: {
		        parseDates:chartOptions.categoryType == "date"?chartOptions.categoryAxisParseDates :false,
		        minPeriod:chartOptions.categoryType == "date"?chartOptions.categoryAxisMinPeriod :"",
		        minorGridEnabled:false,
		        position:"bottom",
	        	labelRotation:chartOptions.categoryAxisLabelRotation
		    },
		    graphs:getGraphsSettings[chartOptions.graphsType](chartOptions),
		    trendLines:chartOptions.trendLines,
		    gridAboveGraphs:true
		};
		if (chartOptions.graphsColors.length > 0) chartSettings["colors"] = chartOptions.graphsColors
		if (chartOptions.legendEnable === false) delete chartSettings["legend"];
		if (chartOptions.chartScrollbarEnable === false) delete chartSettings["chartScrollbar"];
		chart = AmCharts.makeChart(selector, chartSettings);
		if (chartOptions.zoomable === true) {
			chart.addListener("dataUpdated", function() { zoomChart.apply(chart); });
			zoomChart.apply(chart);
		}
		chart.createdOptions = chartOptions;
		__charts[selector] = chart;
		setTimeout(function() {
			if (!chart.dataProvider) {
				chart.dataProvider = getEmptyData(chart.createdOptions);
				chart.validateData();
			}
		}, 1000);
	};
	var createPieChart = function(selector, options) {
		if (__charts[selector] && options["recreate"]) delete __charts[selector];
		else if(__charts[selector]) return;		
		var chartOptions = {
		    "type": "pie",
		    //"theme": "light",
		    
		    "colorField": "color",
		    "valueField": "value",
		    "labelsEnabled": true,
		    "startDuration": 0,
		    "pullOutDuration": 0,
		    "pullOutRadius": 0,
		    "balloonText": " [[percents]] ([[value]])",
		    "radius": "44%",
		    "innerRadius": "50%"		    	
		};
		$.extend(chartOptions, options);
		var chart = AmCharts.makeChart(selector, chartOptions);		
		__charts[selector] = chart;
	};
	var chartBind = function(selector, rows, rowsAction) {
		var chart = __charts[selector];
		if (chart && rows) {
			if (rowsAction) {
				$.each(rows, rowsAction);
			}
			chart.dataProvider = rows[0]&&rows||getEmptyData(chart.createdOptions);
			chart.validateData();
		}	
	};
	return {
		create: function(selector, options) {
			options["graphsType"] = options["graphsType"] || "line";
			createChart(selector, options);
			return SwatChart;
		},		
		createLine:function(selector, options, categoryField) {
			options["graphsType"] = "line";
			options["categoryField"] = categoryField || "date";
			createChart(selector, options);
			return SwatChart;
		},
		createBar:function(selector, options, categoryField) {
			options["graphsType"] = "column";
			options["categoryField"] = categoryField || "category";
			options["categoryType"] = "text";
			createChart(selector, options);
			return SwatChart;
		},
		createPie:function(selector, options) {
			options = options||{};
			options["graphType"] = "pie";
			createPieChart(selector, options);
			return SwatChart;
		},
		updateOption:function(selector, options){
			
			return __charts[selector];
		},
		bind:function(selector, rows, rowsAction) {
			chartBind(selector, rows, rowsAction);
			return SwatChart;
		},
		randomNumber:function(range) {
			range = range || 10;
			return Math.floor(Math.random() * range);
		},
		/*
		example:
		var dataset = SwatChart.convertMultiPartData(
			data.rows,
			"MONI_DATE",
			"HOUR_RTS_BUSY",
			["TENANT_1", "TENANT_2", "TENANT_3"],
			function(v) { return v["MONI_DATE"] + v["HOUR"].ZPad(2); },
			function(v) { return "TENANT_" + v["TENANT_ID"]; }
		);
		*/
		convertMultiPartData: function (rows, xaxisKeyName, yaxisKeyName, yaxisKeyList/* ["ycol1", "ycol2"] */, getXaxisKey/* function(v){return v.name;} */, getYaxisKey/* function(v){return v.name;} */) {
			if (!rows) {
				return [];
			}
			var dataset = ({});
			$.each(rows, function(i, v) {
				var xaxisKey = getXaxisKey(v);
				var row = dataset[xaxisKey];
				if (!row) {
					row = {};
					row[xaxisKeyName] = xaxisKey;
					$.each(yaxisKeyList, function(i, v) { row[v] = 0; });
				}
				row[getYaxisKey(v)] = v[yaxisKeyName];
				dataset[xaxisKey] = row;
			});
			return $.map(dataset, function(v, i) { return v; });
		},
		extractUniqueList:function(rows, colname) {
			var uniqueList = {};
			$.map(rows, function(v, i) {
				uniqueList[v[colname]] = null;
			});
			return $.map(uniqueList, function(v, k) {
				return k;
			});
		},
		updateColorField: function(rows, colors, colorField, colorsName) {
			colorsName = colorsName || "default";
			rows = rows || [];
			colors = colors || getCustomColors(colorsName);
			colorField = colorField || "color";
			$.each(rows, function(i, row) {
				row[colorField] = colors[i];
			});
			return rows;
		}
	};
})();