		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="41";
		var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated;
		var consignmentDeleted,deleteInProgress;
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


		$.i18n().locale = lang;	
		
		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		} ).done( function() { 
			rejectedMsg=$.i18n('rejectedMsg');
			consignmentApproved=$.i18n('consignmentApproved');
			errorMsg=$.i18n('errorMsg');
			havingTxnID=$.i18n('havingTxnID');
			updateMsg=$.i18n('updateMsg');
			hasBeenUpdated=$.i18n('hasBeenUpdated');
			consignmentDeleted=$.i18n('consignmentDeleted');
			deleteInProgress=$.i18n('deleteInProgress');
		});

         $(window).load(function(){
			$('div#initialloader').fadeIn('fast');
			
			sessionStorage.removeItem("session-value");
			
		 });
		

	
	var request = {	
		"dataId":parseInt(userId), 
		"userId":parseInt(userId),
		"featureId":parseInt(featureId),
		"userTypeId": parseInt($("body").attr("data-userTypeID")),
		"userType":$("body").attr("data-roleType"),
		"username" : $("body").attr("data-selected-username")
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	
		$.ajax({
			url: './viewUser',
			type: 'POST',
		    data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
					var result = data.data;
					viewPopupData(result);
					$('div#initialloader').delay(300).fadeOut('slow');
			},
			error: function (jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});	
	
	function viewPopupData(result){
		result.firstName=="" || result.firstName==null ? $("#viewfirstName").val('NA') : $("#viewfirstName").val(result.firstName);
		result.middleName=="" || result.middleName==null ? $("#viewmiddleName").val('NA') : $("#viewmiddleName").val(result.middleName);
		result.lastName=="" || result.lastName==null ? $("#viewlastName").val('NA') : $("#viewlastName").val(result.lastName);
		result.phoneNo=="" || result.phoneNo==null ? $("#viewcontactNumber").val('NA') : $("#viewcontactNumber").val(result.phoneNo);
		result.email=="" || result.email==null ? $("#viewemailID").val('NA') : $("#viewemailID").val(result.email);
		result.password=="" || result.password==null ? $("#viewPassword").val('NA') : $("#viewPassword").val(result.password);
		result.password=="" || result.password==null ? $("#viewconfirmPassword").val('NA') : $("#viewconfirmPassword").val(result.password);
		result.viewUserType=="" || result.viewUserType==null ? $("#viewuserType").val('NA') : $("#viewuserType").val(result.viewUserType);
		result.userName=="" || result.userName==null ? $("#viewuserName").val('NA') : $("#viewuserName").val(result.userName);
		result.remarks=="" || result.remarks==null ? $("#viewuserRemark").val('NA') : $("#viewuserRemark").val(result.remarks);
		$("label[for='viewfirstName']").addClass('active');
		$("label[for='viewmiddleName']").addClass('active');
		$("label[for='viewlastName']").addClass('active');
		$("label[for='viewcontactNumber']").addClass('active');
		$("label[for='viewemailID']").addClass('active');
		$("label[for='viewPassword']").addClass('active');
		$("label[for='viewconfirmPassword']").addClass('active');
		$("label[for='viewuserType']").addClass('active');
		$("label[for='viewuserRemark']").addClass('active');
		$("label[for='viewuserName']").addClass('active');
		
		
	}
	
	