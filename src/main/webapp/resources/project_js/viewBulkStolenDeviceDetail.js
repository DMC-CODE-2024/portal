var featureId =$("body").attr("data-featureid");

var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType");
var startdate=$('#startDate').val();
var endDate=$('#endDate').val();

$.i18n().locale = "en";
var documenttype,selectfile,selectDocumentType;

$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	var requestIdToFetchDetail=$("#requestIdToFetchDetail").val()
	openBulkStolenViewForm(requestIdToFetchDetail)
});

var role = currentRoleType == null ? roleType : currentRoleType;

$.getJSON('./getDropdownList/nationality', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#ownerNationalityBulk');
				//////console.log("...........");
			}
		});

function openBulkStolenViewForm(rowId){
	 var tempId=rowId;
		if(tempId==null || tempId=="" || tempId==''){
			$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
			return false;
		}

		var request ={
				"requestId" : rowId,
				"userId": parseInt(userId),
				"featureId":parseInt($("body").attr("data-featureid")),
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
				url: './bulkStolen/view',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data
						console.log(JSON.stringify(result));
						$("#ViewBulkStolenDevice").openModal({
						 	   dismissible:false
						    });
						    setBulkStolenViewFormData(result);

			$('div#initialloader').delay(300).fadeOut('slow');
					//noRecordMessage
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
					$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
				}
			});
		}

function setBulkStolenViewFormData(result){
        var stolenDate=result.deviceLostDdateTime.substring(0,10);
		var stolenTime=result.deviceLostDdateTime.substring(11);
        $('#stolenDateBulk').val(stolenDate);
        $('#stolenTimeBulk').val(stolenTime);
		$('#stolenOwnerBulk').val(result.deviceOwnerName);
		$('#stolenEmailBulk').val(result.deviceOwnerEmail);
		$('#stolenOwnerAddress1Bulk').val(result.deviceOwnerAddress);
		$('#stolenOwnerAddress2Bulk').val(result.deviceOwnerAddress2);
		$('#stolenOwnerNIDBulk').val(result.deviceOwnerNationalID);
		$('#stolenOwnerOTPContactBulk').val(result.contactNumberForOtp);
		$('#ownerNationalityBulk').val(result.deviceOwnerNationality);
		$('#provinceCityBulk').val(result.province).change();
		$('#districtBulk').val(result.district).change();
		$('#communeBulk').val(result.commune).change();
		$('#policeStationBulk').val(result.policeStation);
		$('#ownerDOBBulk').val(result.ownerDOB);
		$('#stolenOtpEmailBulk').val(result.otpEmail);
		$('#stolenOwnerPassportBulk').val(result.passportNumber);
		$('#categoryBulk').val(result.category).change();
		$('#incidentDetailBulk').val(result.incidentDetail);
		$('#stolenRemarkBulk').val(result.remarks);
		$('#stolenMobileFileBulk').val(result.fileName);
		var domainURL=domainURLBulk(result.firCopyUrl);
		$('#stolenMobileFileBulkPreview').attr("onclick",'previewStolenFile("'+domainURL+'","'+result.fileName+'","'+result.requestId+'")');
        $('#stolenMobileInvoiceBulk').val(result.mobileInvoiceBill);
        $('#stolenMobileInvoiceBulkPreview').attr("onclick",'previewStolenFile("'+domainURL+'","'+result.mobileInvoiceBill+'","'+result.requestId+'")');
        $('#deviceFirCopyBulk').val(result.devicePurchaseInvoiceUrl);
        $('#deviceFirCopyBulkPreview').attr("onclick",'previewStolenFile("'+domainURL+'","'+result.devicePurchaseInvoiceUrl+'","'+result.requestId+'")');
        $('#stolenOwnerNIDfileBulk').val(result.deviceOwnerNationalIdUrl);
        $('#stolenOwnerNIDfileBulkPreview').attr("onclick",'previewStolenFile("'+domainURL+'","'+result.deviceOwnerNationalIdUrl+'","'+result.requestId+'")');
        $('#stolenOtherdocumentBulk').val(result.otherDocument);
        $('#stolenOtherdocumentBulkPreview').attr("onclick",'previewStolenFile("'+domainURL+'","'+result.otherDocument+'","'+result.requestId+'")');

        //$('#stolenPreviewID2').attr("onclick",'previewStolenFile("'+result.firCopyUrl+'","'+stolenData.deviceOwnerNationalIdUrl+'","'+stolenData.requestId+'")');
}

function domainURLBulk(dataURL){

        if(dataURL ==null || dataURL == "" || dataURL ==undefined){
        }
        else{
        var urlInRespone=dataURL;
        var parts = urlInRespone.split('/');
        var extractedValue = parts.slice(0, 3).join('/');
        var finalPath = urlInRespone.replace(extractedValue, window.urlWithProtocol);
        return finalPath;
        }
        }