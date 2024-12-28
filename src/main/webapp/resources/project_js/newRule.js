	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});

		
		function getFeature(current){

			$.ajax({
				url: './getFeatureName?ruleName='+current.value,
				type: 'POST',
				processData: false,
				contentType: false,
				async : false,
				success: function (data, textStatus, jqXHR) {

					$('#Feature').empty();
					var html='<option value="">Feature Name</option>';
					$('#Feature').append(html);
			    	for (i = 0; i < data.length; i++) {
			    		/*$('<option>').val(data[i]).text(data[i]).appendTo('#Feature,#editFeature');*/
			    		$('<option>').val(data[i].feature).text(data[i].feature).appendTo('#Feature,#editFeature');
			    	}
					
				
				
				},
				error: function (jqXHR, textStatus, errorThrown) {

				}
			});

		}
		

$.getJSON('./getDistinctUserTypeList', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i]).text(data[i])
		.appendTo('#User');
	}
});


$.getJSON('./ruleName', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].name).text(data[i].name)
		.appendTo('#Rule');
	}
});

/*$.getJSON('./getDropdownList/PERIOD_ACTION', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].interp).text(data[i].interp)
		.appendTo('#GracePeriod,#PostGracePeriod');
	}
});
*/


function getGrace(current){
	var rule=$('#Rule').val();
	$.ajax({
		url: './gracePostgraceActionMapping?tag=PERIOD_ACTION',
		type: 'POST',
		processData: false,
		contentType: false,
		async : false,
		success: function (data, textStatus, jqXHR) {
			$('#GracePeriod,#PostGracePeriod').empty();
			
	    for (i = 0; i < data.length; i++) {
	    		$('<option>').val(data[i].interp).text(data[i].interp).appendTo('#GracePeriod,#PostGracePeriod');
	    	}
		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});

}


$.getJSON('./getDropdownList/MOVE_TO_NEXT', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].interp).text(data[i].interp)
		.appendTo('#MoveToGracePeriod,#MoveToPostGracePeriod');
	}
});


function save( ){
	var name=$('#editName').val();
	var description=$('#editDescription').val();
	var state=$('#editState').val();
	var existOrNot="no";
    var newRule={
			"failedRuleActionGrace": $('#MoveToGracePeriod').val(),
			"failedRuleActionPostGrace":$('#MoveToPostGracePeriod').val(),
			"feature": $('#Feature').val(),
			"graceAction": $('#GracePeriod').val(),
			"name": $('#Rule').val(),
			"postGraceAction": $('#PostGracePeriod').val(),
			"ruleOrder":parseInt($('#order').val()),
			"userType":$('#User').val(),
			"output": $('#output').val(),
			"userId":parseInt($("body").attr("data-userID")),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userName":$("body").attr("data-username"),
			"roleType":$("body").attr("data-roleType"),
			"existOrNot":existOrNot
	}
 // Put the object into storage
    sessionStorage.setItem('newRule', JSON.stringify(newRule));
    
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({

		url : "./save",
		data : JSON.stringify(newRule),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success: function (data, textStatus, jqXHR) {
			if(data.errorCode == 0){
			//if(data.errorCode == null){
			$("#consignmentSubbmitButton").prop('disabled', true);
			$("#successModal").openModal({
				dismissible:false
			});
			sessionStorage.removeItem('newRule');
			}	
			if(data.errorCode == 401){
				//messageWindow(data.message);
			
				$("#updateModalAllowed").openModal({
					dismissible:false
				});
				$('#ErrorFieldMessage').text($.i18n(data.message));
				$('#ErrorFieldMessage').append(" "+data.data);
			}
			else if(data.errorCode == 402){
				//messageWindow(data.message);
				
				$("#updateModal").openModal({
					dismissible:false
				});
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});

	return false;
}

function confirmRuleUpdate(){
	
	var saveRequest=sessionStorage.getItem('newRule');
	
	saveRequest =JSON.parse(saveRequest);
	saveRequest['existOrNot'] = 'yes';
	  
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({

		url : "./save",
		data :  JSON.stringify(saveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success: function (data, textStatus, jqXHR) {
			if(data.errorCode == 0){
			//if(data.errorCode == null){
		 
			$("#successModal").openModal({
				dismissible:false
			});
			sessionStorage.removeItem('newRule');
			
			}	
			if(data.errorCode == 401){
				//messageWindow(data.message);
			
				$("#updateModalAllowed").openModal({
					dismissible:false
				});
			}
			else if(data.errorCode == 402){
				//messageWindow(data.message);
				
				$("#updateModal").openModal({
					dismissible:false
				});
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});
}

function closeRuleUpdateOrder(){
	sessionStorage.removeItem('newRule');
}

function getFeaturedUserType(featureID){
	var featureName=$('#'+featureID).val();
	$.ajax({
		url: './getFeaturedUserType?featureName='+featureName+'&name='+$('#Rule').val(),
		type: 'POST',
		processData: false,
		contentType: false,
		async : false,
		success: function (data, textStatus, jqXHR) {
			$('#User').empty();
		 for (i = 0; i < data.length; i++) {
			 $('<option>').val(data[i].userType).text(data[i].userType).appendTo('#User');
	    	}
		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});
}