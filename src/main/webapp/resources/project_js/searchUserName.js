/*
		window.parent.$('#langlist').on('change', function() {
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
			window.location.assign("./uploadPaidStatus?lang="+lang);
		}); */
	
	$('#btnLink').css({"display":"none"});	
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var roleType = $("body").attr("data-roleType"); 
	
	function hide() {
		var In = $('#Search').val();
		if(In.length == 0){
				////////console.log("please field input");
		}else{
			var searchRequest={
					"username" : $('#Search').val()
			}
			////console.log("searchRequest--->" +JSON.stringify(searchRequest));
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			}); 	
				$.ajax({
					url: './searchUser',
					type: 'POST',
					data : JSON.stringify(searchRequest),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					success: function (data, textStatus, jqXHR) {
		/*				alert(data.selfRegister)
						if(data.statusCode==200 && (data.selfRegister == 1 || data.selfRegister == 2)){
							var primaryRole = data.primaryRole;
							var userId = data.userId;
							sessionStorage.setItem("primaryRole", primaryRole);
							sessionStorage.setItem("userId", userId);
							window.location.href = "./openGrievanceForm?reqType=formPage";
						}else{
							
							$('#ErrorPopup').openModal({
								dismissible:false
							});
							//window.location.href = "./raiseCCgrievance";
						}*/
						if(data.statusCode==200 && data.selfRegister == 1){
							var primaryRole = data.primaryRole;
							var userId = data.userId;
							sessionStorage.setItem("primaryRole", primaryRole);
							sessionStorage.setItem("userId", userId);
							window.location.href = "./openGrievanceForm?reqType=formPage";	
							}
							else{
							window.location.href = "./raiseCCgrievance";
							}
					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax")

					}
				});
				
				//$("#submitbtn").css("display", "none");
				//$("#endUserRaiseGrievance").css("display", "block");
			}
		return false;
	    	
	}