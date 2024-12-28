		var cierRoletype =$("body").attr("data-roleType");	
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="42";
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
		
	
		$.i18n().locale = lang;	
		
		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		} ).done( function() { 
			
		});

		$(document).ready(function(){
			$('div#initialloader').fadeIn('fast');
			Datatable(lang);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		//var sourceType =localStorage.getItem("sourceType");
		//var TagId = sessionStorage.getItem("tagId");
	
		var reportnameId = $("body").attr("data-tableName");
		;
		//var reportnameId = sessionStorage.getItem("reportname");
		var reportNameInterp = sessionStorage.getItem("reportInterp");
		
		//**************************************************filter table**********************************************
		
		function Datatable(lang){
			var trend=$('#reportType').val();
			var trendTypeFlag = "";
			if(trend==undefined || trend=="undefined" )
				{
				trendTypeFlag= sessionStorage.getItem("trendTypeFlag");
				}
			else{
				trendTypeFlag=trend;		
			}
			var filterRequest={
					"startDate" : $('#startDate').val(), 
					"endDate":$('#endDate').val(),
					"reportnameId" : parseInt(reportnameId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"userId" : parseInt($("body").attr("data-userID")),
					"typeFlag": trendTypeFlag
					//"pageNo": Integer.parseInt(pageNo),
					//"pageSize":Integer.parseInt(pageSize),

			}
			
			////console.log(JSON.stringify(filterRequest));
			
			if(lang=='km'){
				var langFile="./resources/i18n/khmer_datatable.json";
			}else if(lang=='en'){
				var langFile='./resources/i18n/english_datatable.json';
			}				
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});	

		$.ajax({
				url: 'tableHeaders?reportnameId='+parseInt(reportnameId)+"&typeFlag="+trendTypeFlag,
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#reportLibraryTable").DataTable({
						destroy:true,
						"serverSide": true,
						orderCellsTop : true,
						"ordering" : false,
						"bPaginate" : true,
						"bFilter" : true,
						"bInfo" : true,
						"bSearchable" : true,
						"scrollX": true,
						"scrolly": true,
						"searching": false,
						"oLanguage": {  
							"sUrl": langFile  
						},
						initComplete: function() {
					 		$('.dataTables_filter input')
	       .off().on('keyup', function(event) {
	    	   if (event.keyCode === 13) {
	    			 table.search(this.value.trim(), false, false).draw();
	    		}
	          
	       });
		   },
						ajax: {
							url : 'dbReportData',
							type: 'POST',
							dataType: "json",
							data : function(d) {
								d.filter = JSON.stringify(filterRequest); 
								//////console.log(JSON.stringify(filterRequest));
							},
							error: function (jqXHR, textStatus, errorThrown,data) {
								
								 window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
								 // messageWindow(jqXHR['responseJSON']['message']);
								 window.parent.$('#500ErrorModal').openModal({
								 dismissible:false
								 });
								
							}

						},
						"columns": result,"defaultContent":"",
						fixedColumns: true,
					});
					
					$('div#initialloader').delay(300).fadeOut('slow');
					
					$('.dataTables_filter').css("display", "none");	
					sessionStorage.removeItem("reportname");
					
				},
				error: function (jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax");
				}
			});
		
		}
		
		
		function pageRendering(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: 'dbReportTable/pageRendering?reportName='+reportNameInterp,
				type: 'POST',
				dataType: "json",
				async:false,
				success: function(data){
					data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );
						
					var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
					$("#pageHeader").append(elem);
					var button=data.buttonList;
					var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
						if(date[i].type === "date"){
							$("#dbTableDiv").append("<div class='input-field col s6 m2'>"+
									"<div id='enddatepicker' class='input-group'>"+
									"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off' onchange='checkDate(startDate,endDate)'>"+
									"<label for="+date[i].id+">"+date[i].title
									+"</label>"+
									"<span	class='input-group-addon' style='color: #ff4081'>"+
									"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");

						}else if(date[i].type === "text"){
							$("#dbTableDiv").append("<div class='input-field col s6 m2' ><input type="+date[i].type+" id="+date[i].id+" maxlength='19' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						}
					} 
			
					// dynamic dropdown portion
					var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#dbTableDiv").append("<div class='col s6 m2 selectDropdwn'>"+
								
									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+dropdown[i].id+" class='select2 initialized'>"+
									"<option value='' selected Disabled>"+dropdown[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					}

						$("#dbTableDiv").append("<div class=' col s3 m2 l1'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
						$("#dbTableDiv").append("<div class=' col s3 m5 l4'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportReportData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}

					

				
					
				$('.datepicker').datepicker({
						dateFormat: "yy-mm-dd"
					});
				}
			}); 
			setReportType();
			//alert("reportNameInterp--->" +reportNameInterp)
			
}


		function exportReportData(){
			var table = $('#reportLibraryTable').DataTable();
			var info = table.page.info(); 
			var pageNo=info.page;
			var pageSize =info.length;
			
			var filterRequest={
					"startDate" : $('#startDate').val(), 
					"endDate":$('#endDate').val(),
					"reportnameId" : parseInt(reportnameId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"userId" : parseInt($("body").attr("data-userID")),
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize),
					
					
					
					
					
					
			}
			//////console.log(JSON.stringify(filterRequest))
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './exportReportData',
				type: 'POST',
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(filterRequest),
				success: function (data, textStatus, jqXHR) {
					finalURL(data.url);

				},
				error: function (jqXHR, textStatus, errorThrown) {
					
				}
			});
			
			
		}
		
		function setReportType(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './fetchReportType?reportnameId='+parseInt(reportnameId),
				type: 'POST',
				contentType : 'application/json; charset=utf-8',
				async:false,
				success: function (data, textStatus, jqXHR) {
					var result= data;
					if(result.reportTrends.length>1){
					for (i = 0; i < result.reportTrends.length; i++){
						//alert(result[i].reportTrends[0].typeFlag);
						//$('<option>').val(result[i].reportnameId).text(result[i].reportName).appendTo('#reportType');
						
						$('<option>').val(result.reportTrends[i].typeFlag).text(result.reportTrends[i].typeFlagInterp).appendTo('#reportType');
					}
				}
					else{
						$("#reportType").css("display", "none");
					}

				},
				error: function (jqXHR, textStatus, errorThrown) {
					
				}
			});
		}
