
var langParam=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
$.i18n().locale = langParam;
var successMsg;
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
	successMsg=$.i18n('successMsg');
});

function registerConsignment() {
	$('div#initialloader').fadeIn('fast');
	var supplierId = $('#supplierId').val();
	var supplierName = $('#supplierName').val();
	var consignmentNumber = $('#consignmentNumber').val();
	var expectedArrivalDate = $('#expectedArrivaldate').val();
	var expectedDispatcheDate = $('#expectedDispatcheDate').val();
	var expectedArrivalPort = $('#expectedArrivalPort').val();
	var organisationcountry = $('#country').val();
	var currency = $('#currency').val();
	var totalPrice = $('#totalPrice').val();
	var quantity = $('#quantity').val();
	var formData = new FormData();
	formData.append('file', $('#file')[0].files[0]);
	formData.append('supplierId', supplierId);
	formData.append('supplierName', supplierName);
	formData.append('consignmentNumber', consignmentNumber);
	formData.append('expectedArrivaldate', expectedArrivalDate);
	formData.append('expectedDispatcheDate', expectedDispatcheDate);
	formData.append('expectedArrivalPort', expectedArrivalPort);
	formData.append('organisationcountry', organisationcountry);
	formData.append('quantity', quantity);
	formData.append('currency', currency);
	formData.append('totalPrice', totalPrice);
	formData.append('featureId', parseInt(featureId));
	formData.append('userTypeId', parseInt($("body").attr("data-userTypeID")));
	formData.append('userType', $("body").attr("data-roleType"));
	formData.append('userName', $("body").attr("data-username"));
	formData.append('portAddress', parseInt($('#portAddress').val()));
	formData.append('deviceQuantity', parseInt($('#deviceQuantity').val()));	
	formData.append('roleType', $("body").attr("data-roleType"));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : './registerConsignment',
		type : 'POST',
		data : formData,
		processData : false,
		contentType : false,
		success : function(data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			$("#consignmentSubbmitButton").prop('disabled', true);
			$('#submitConsignment').openModal({dismissible:false});
			if (data.errorCode == "0") {
				$('#sucessMessage')
				.text(successMsg);
				$('#sucessMessage').append(data.txnId);
				$('#errorCode').val(data.errorCode);
			} else if (data.errorCode == "3") {
				$('#sucessMessage').text('');
				$('#sucessMessage').text(
				"consignment number already exist");
				$('#errorCode').val(data.errorCode);
			}
			else if(data.errorCode == 5){
				$('#sucessMessage').text('');
				$('#sucessMessage').text($.i18n(data.tag));
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
		}
	});

	return false;

}

function openDeleteModal(transactionId) {
	/*   $('#deletemodal').modal('open');
							backdrop: 'static' */
	$('#deletemodal').openModal({dismissible:false});
	$('#deleteTransactionId').val(transactionId);
}


function myFunction(message) {
	var x = document.getElementById("snackbar");
	x.className = "show";
	$('#errorMessage').html(message);
	setTimeout(function() {
		x.className = x.className.replace("show", "");
	}, 3000);
}

function dispatchDateValidation() {
	var currentDate;
	var dispatcDate = $('#expectedDispatcheDate').val();
	var now = new Date();
	if (now.getDate().toString().charAt(0) != '0') {
		currentDate = '0' + now.getDate();

		/* alert("only date="+currentDate); */
	} else {
		currentDate = now.getDate();
	}
	var today = now.getFullYear() + '-' + (now.getMonth() + 1) + '-'
	+ currentDate;
	//alert("today"+today);
	////console.log("dispatche=" + dispatcDate);
	////console.log("todays parse date" + Date.parse(today));
	////console.log("dispatche parse date" + Date.parse(dispatcDate));

	if (Date.parse(today) > Date.parse(dispatcDate)) {
		myFunction("dispatche date should be greater then or equals to today");
		$('#expectedDispatcheDate').val("");
	}

	//alert("current date="+today+" dispatche date="+dispatcDate)
}

function arrivalDateValidation() {
	var currentDate;
	var dispatcDate = $('#expectedArrivalDate').val();
	var now = new Date();
	if (now.getDate().toString().charAt(0) != '0') {
		currentDate = '0' + now.getDate();

		/* alert("only date="+currentDate); */
	} else {
		currentDate = now.getDate();
	}
	var today = now.getFullYear() + '-' + (now.getMonth() + 1) + '-'
	+ currentDate;
	//alert("today"+today);
	////console.log("dispatche=" + dispatcDate);
	////console.log("todays parse date" + Date.parse(today));
	////console.log("dispatche parse date" + Date.parse(dispatcDate));

	if (Date.parse(today) > Date.parse(dispatcDate)) {
		myFunction("Arrival date should be greater then or equals to today");
		$('#expectedArrivalDate').val("");
	}

	//alert("current date="+today+" dispatche date="+dispatcDate)
}

function closeConfirmation() {

	var errorCode = $('#errorCode').val();
	if (errorCode == 0) {
		$("#closeOkPop").submit();
	} else if (errorCode == 3) {
		$('#sucessMessage').text('');
		$('#submitConsignment').closeModal();
		/// $('#submitConsignment').modal('hide');
	}
}


populateCountries("country");

$(document).ready(function() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.getJSON('./getDropdownList/CURRENCY', function(data) {
		/ $("#expectedArrivalPort").empty(); /
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp).appendTo('#currency');
		}
	});

	$.getJSON('./getDropdownList/CUSTOMS_PORT', function(data) {
		/* $("#expectedArrivalPort").empty(); */
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#expectedArrivalPort');

		}
	});
	$('#currencyDiv').hide();
});

$('.datepick').datepicker({
	dateFormat : "yy-mm-dd"
});



$(document).on("keyup", "#totalPrice", function(e) {
	var totalPrice=$('#totalPrice').val();
	if(totalPrice.length<'1' )
	{
		$("#currency").attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		$('#currencyDiv').hide();

		$("#currency")[0].selectedIndex = 0;

	}
	else
	{
		$('#currency').prop('required',true);
		//$("#currency").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$('#currencyDiv').show();

	}
});



function clearFileName() {
	$('#fileName').val('');
	$("#file").val('');
	$('#fileFormateModal').closeModal();
}

$("input[type=file]").keypress(function(ev) {
    return false;
    //ev.preventDefault(); //works as well

});



function getByPort(port) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
				type : 'GET',
				url : './byArrivalPort/' + port,
				contentType : "application/json",
				dataType : 'html',
				async : false,
				success : function(data) {
					var response = JSON.parse(data);
					var asTypeDropdown = $("#portAddress");
					asTypeDropdown.empty();
					var header = "<option value='' disabled selected>Select address</option>";
					asTypeDropdown.append(header);
					for (var i = 0; i < response.length; i++) {
						var data2 = '<option value="' + response[i].id + '">'
								+ response[i].address + '</option>';
						asTypeDropdown.append(data2);
					}
				},
				error : function(xhr, ajaxOptions, thrownError) {
				}
			});
}


$('div#initialloader').delay(300).fadeOut('slow');