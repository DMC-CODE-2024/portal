	var featureId = 6;
	$('#langlist').on('change', function() {
		lang=$('#langlist').val() == 'km' ? 'km' : 'en';
		var url_string = window.location.href;
		var url = new URL(url_string);
		var type = url.searchParams.get("reportType");

		window.location.assign("raiseAgrievance?reportType="+type+"&lang="+lang);			
		}); 


	
	
	
	$(document).ready(function () {
		 $('#langlist').val(data_lang_param);
		 $.i18n().locale = data_lang_param;
			var successMsg;
			$.i18n().load( {
				'en': './resources/i18n/en.json',
				'km': './resources/i18n/km.json'
			} ).done( function() { 
			});

		// $('.modal').modal();
	});

	/*if(sessionStorage.getItem("cierRoletype")=="Customer Care"){
		window.raisedBy = "Customer Care";  
		//alert("window.raisedBy1------->" +window.raisedBy);
	}else{
		window.raisedBy = "Self";
		//alert("window.raisedBy2------->" +window.raisedBy);
	}*/
	
	/*//alert("userId-->" +$("body").attr("data-userID"));
	//alert("usertype-->" +$("body").attr("data-roleType"));*/
	
function saveaAonymousGrievance(){

	var firstName=$('#firstName').val();
	var middleName=$('#middleName').val();
	var lastName=$('#lastName').val();
	var contactNumber=$('#contactNumber').val();
	var emailID=$('#emailID').val();
	var category=$('#endUsercategory').val();
	
	var txnId=$('#endUsertransactionId').val();
	var remark=$('#endUserRemark').val();
	var file=$('#myInput').val();
	var fieldId=1;
	var fileInfo =[];
	var formData= new FormData();
	var fileData = [];
	
	var x;
	var filename='';
	var filediv;
	var i=0;
	var formData= new FormData();
	var docTypeTagIdValue='';
	var filename='';
	var filesameStatus=false;
	var documenttype=false;
	var docTypeTag='';
	var documentFileNameArray=[];
	$('.endUserfileDiv').each(function() {	

		
		var x={
		"docType":$('#endUserdocTypetag'+fieldId).val(),
		"fileName":$('#endUserdocTypeFile'+fieldId).val().replace('C:\\fakepath\\','')
		}
		formData.append('files[]',$('#endUserdocTypeFile'+fieldId)[0].files[0]);
		documentFileName=$('#endUserdocTypeFile'+fieldId).val().replace('C:\\fakepath\\','')
		docTypeTag=$('#endUserdocTypetag'+fieldId).val();
		
		var fileIsSame=	documentFileNameArray.includes(documentFileName);
		
		var documentTypeTag=documentFileNameArray.includes(docTypeTag);
	
		if(filesameStatus!=true){
			filesameStatus=	fileIsSame;
		}
		
		 if(documenttype!=true)
			{
			documenttype=documentTypeTag;
	
			}
		documentFileNameArray.push(documentFileName);
		documentFileNameArray.push(docTypeTag);
		
		fileInfo.push(x);
		fieldId++;
		i++;
	});
	
	if(filesameStatus==true)
	{	
	
	$('#fileFormateModal').openModal({
        dismissible:false
    });
		$('#fileErrormessage').text('')
		$('#fileErrormessage').text($.i18n('duplicateFileName'));
	return false;
	
	}
	
	if(documenttype==true)
	{	
		
	$('#fileFormateModal').openModal({
        dismissible:false
    });
		$('#fileErrormessage').text('')
		$('#fileErrormessage').text($.i18n('documentTypeName'));
	return false;
	
	}
	
	var multirequest={
			"attachedFiles":fileInfo,
			"txnId":txnId,
			"categoryId":category,
			"remarks":remark,
			"email":emailID,
			"firstName":firstName,
			"lastName":lastName,
			"middleName":middleName,
			"phoneNo":contactNumber,
			"featureId":6,
			"raisedBy" : "Customer Care",
			"raisedByUserId" : parseInt($("body").attr("data-userID")), 
			"raisedByUserType" : $("body").attr("data-roleType"),
			"userTypeId" :  $("body").attr("data-userTypeID")
			//"userType" : "Customer Care"
	}
	
	formData.append('fileInfo[]',JSON.stringify(fileInfo));
	formData.append('multirequest',JSON.stringify(multirequest));
	/*formData.append('categoryId',category);
	formData.append('remarks',remark);
*/	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './saveEndUserGrievance',
		type: 'POST',
		data: formData,
		mimeType: 'multipart/form-data',
		processData: false,
		contentType: false,
		async:false,
		success: function (data, textStatus, jqXHR) {
			//////console.log(data);
			 $("#saveAnonymousGrieavance").prop('disabled', true);
			var x=data;
			var y= JSON.parse(x);
			 $('#GrievanceMsg').openModal({
			        dismissible:false
			    }); 
			 $('#sucessMessageGrievance').text(y.txnId); 
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			/* //////console.log("error in ajax") */
			 $('#exceptionMessage').openModal({
			        dismissible:false
			    }); 
		}
	});
return false;

}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});
$.getJSON('./addMoreFile/more_files_count', function(data) {
	//////console.log(data);
	
	localStorage.setItem("maxCount", data.value);
	
});

	//var max_fields = 2; //maximum input boxes allowed
	var max_fields =localStorage.getItem("maxCount");
	//////console.log("max_fields from api="+max_fields);


//var max_fields = 15; //maximum input boxes allowed
var endUserwrapper = $(".endUsermainDiv"); //Fields wrapper
var add_button = $(".endUser_add_field_button"); //Add button ID
var x = 1; //initlal text box count
var id=2;
$(".endUser_add_field_button").click(function (e) { //on add input button click
	e.preventDefault();
	if (x < max_fields) { //max input box allowed
		x++; //text box increment
		$(endUserwrapper).append(
				'<div id="endUserfilediv'+id+'" class="endUserfileDiv"><div class="row"><div class="file-field col s12 m6"><label for="">'+$.i18n('documenttype')+' <span class="star">*</span></label><select id="endUserdocTypetag'+id+'" required class="browser-default"> <option value="" disabled selected>'+$.i18n('selectDocumentType')+' </option></select></div> <div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'+$.i18n('selectfile')+'</span><input id="endUserdocTypeFile'+id+'" type="file" required name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" placeholder="Upload file" type="text"></div></div><div  class="endUser_remove_field btn right btn-info">-Remove</div></div></div>'
				/* '<div id="filediv'+id+'" class="fileDiv"><div class="row"><div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'+$.i18n('selectfile')+'</span><input id="docTypeFile'+id+'" type="file" required name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" type="text"></div></div><div class="file-field col s12 m6"><label for="Category">'+$.i18n('documenttype')+' <span class="star">*</span></label><select id="docTypetag'+id+'" required class="browser-default"> <option value="" disabled selected>'+$.i18n('selectDocumentType')+' </option></select><select id="docTypetagValue'+id+'" style="display:none" class="browser-default"> <option value="" disabled selected>'+$.i18n('selectDocumentType')+' </option></select></div><div style="cursor:pointer;background-color:red;margin-right: 1.7%;" class="remove_field btn right btn-info">-</div></div></div>' */
		); //add input box
	}
	
	
	/* $.getJSON('./getDropdownList/DOC_TYPE', function(data) {


		for (i = 0; i < data.length; i++) {
			//////console.log(data[i].interp);
			var optionId=id-1;
			$('<option>').val(data[i].tagId).text(data[i].interp).appendTo('#endUserdocTypetag'+optionId);
			

		}
	}); */
	var request ={
			 "childTag": "DOC_TYPE",
			  "featureId": 6,
			  "parentValue":  parseInt($('#endUsercategory').val()),	
			  "tag": "GRIEVANCE_CATEGORY",
			  "userTypeId":17 
		}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
////////console.log("request --->" +JSON.stringify(request));	
 $.ajax({
		url: './get/tags-mapping',
		type: 'POST',
		data : JSON.stringify(request),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		success: function (data, textStatus, jqXHR) {
			
			////////console.log(data);
			
			for (i = 0; i < data.length; i++){
				var optionId=id-1;
				
				$('<option>').val(data[i].tagId).text(data[i].interp).appendTo('#endUserdocTypetag'+optionId);
				
			}
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});
 
	id++;

});

$(endUserwrapper).on("click", ".endUser_remove_field", function (e) { //user click on remove text
e.preventDefault();
var Iid=id-1;
/*//alert("@@@"+Iid)*/
$('#endUserfilediv'+Iid).remove();
$(this).parent('div').remove();
x--;
id--;

})


/* $.getJSON('./getDropdownList/DOC_TYPE', function(data) {
for (i = 0; i < data.length; i++) {
	//////console.log(data[i].interp);
	$('<option>').val(data[i].tagId).text(data[i].interp).appendTo('#endUserdocTypetag1');
	
}
}); */
var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
$.getJSON('./getTypeDropdownList/GRIEVANCE_CATEGORY/17', function(data) {
for (i = 0; i < data.length; i++) {
	//////console.log(data[i].interp);
	$('<option>').val(data[i].value).text(data[i].interp).appendTo('#endUsercategory');
	
}
});


if($('#pageTypeValue').val()==0)
{
//////console.log("if condition ++++++++");
$('#endUserRaiseGrievance').css("display", "block");
$('#trackGrievanceDiv').css("display", "none");
$('#trackGrievanceHeader').css("display", "none");
$('#trackGrievanctableDiv').css("display", "none");
}
else
{
//////console.log("else condition ++++++++");
$('#endUserRaiseGrievance').css("display", "none");
$('#trackGrievanceDiv').css("display", "block");
$('#trackGrievanctableDiv').css("display", "none");

}



function  openCancelPopUp()
{
 $('#cancelMessage').openModal({
     dismissible:false
 }); 
}

function  closeCancelPopUp()
{
 $('#cancelMessage').closeModal();
}

function enableEndUserAddMore(){
$(".endUser_add_field_button").attr("disabled", false);
}

function enableEndUserReplyAddMore(){
$(".add_field_button").attr("disabled", false);
}


function enableReplySelectFile(){
	$("#docTypeFile1").attr("disabled", false);
	$("#docTypeFile1").attr("required", true);
	$("#docTypeFile1Label").append('<span class="star">*</span>');
}



			function endUserviewGrievanceHistory(grievanceId,projectPath,userId)
			{
				////////console.log(projectPath+path);
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: './endUserViewGrievance?recordLimit=2&grievanceId='+grievanceId+"&userId="+userId,
					type: 'GET',
					processData: false,
					contentType: false,
					success: function (data, textStatus, jqXHR) {

						//////console.log(JSON.stringify(data));
						$('#chatMsg').empty();
						$('#manageAccount').openModal({
			    	    	   dismissible:false
			    	       });
						//////console.log("****projectPath"+projectPath);
						//////console.log("+++++path"+path);
						
						var projectpath=path+"/Consignment/dowloadFiles/actual";
						//////console.log("--projectpath--"+projectpath);
						for(var i=0; i<data.length; i++)
						{
							//////console.log("iiiiiii"+i);
							$("#chatMsg").append("<div class='chat-message-content clearfix'><span class='chat-time' id='timeHistory'>"+data[i].modifiedOn+"</span><h5 id='userTypehistory'>"+data[i].userDisplayName+"</h5><textarea class='materialize-textarea' id='messageHistory'>"+data[i].reply+"</textarea></div>");
								for (var j=0 ; j<data[i].attachedFiles.length;j++)
								{
									
									if(data[i].attachedFiles[j].docType==null)
									{
									////////console.log("if condition file and doctype is empty");	
									//$("#chatMsg").append("<div class='chat-message-content clearfix'><a href='"+projectpath+"/"+data[i].attachedFiles[j].fileName+"/"+data[i].attachedFiles[j].grievanceId+"/"+data[i].attachedFiles[j].docType+"'>"+data[i].attachedFiles[j].fileName+"</a></div>");
									}
								else{
									if(data[i].attachedFiles[j].docType=="")
									{
									//$("#chatMsg").append("<div class='chat-message-content clearfix'> <span class='document-Type' ><b>Document Type : </b>"+data[i].attachedFiles[j].docType+"</span> <a href='"+projectpath+"/"+data[i].attachedFiles[j].fileName+"/"+data[i].attachedFiles[j].grievanceId+"/"+data[i].attachedFiles[j].docType+"'>"+data[i].attachedFiles[j].fileName+"</a></div>");
									}
									else{
									
									fileName=data[i].attachedFiles[j].fileName.split(' ').join('%20');
									$("#chatMsg").append("<div class='chat-message-content clearfix'> <span class='document-Type' ><b>Document Type : </b>"+data[i].attachedFiles[j].docType+"</span> <a onclick=fileDownload('"+fileName+"','actual','"+data[i].attachedFiles[j].grievanceId+"','"+data[i].attachedFiles[j].docType+"')>"+data[i].attachedFiles[j].fileName+"</a></div>");
									}
								}
								}
								$("#chatMsg").append("<div class='chat-message-content clearfix'><hr></div>");
						
						}
					},
					error: function (jqXHR, textStatus, errorThrown) {
						////////console.log("error in ajax")
					}
				});
			}


			
			
			function endUserGrievanceReply(userId,grievanceId,txnId)
			{	
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: './endUserViewGrievance?recordLimit=2&grievanceId='+grievanceId+"&userId="+userId,
					type: 'GET',
					processData: false,
					contentType: false,
					success: function (data, textStatus, jqXHR) {

						////////console.log(JSON.stringify(data));
						$('#replyModal').openModal({
			    	    	   dismissible:false
			    	       });
						setDocTypeValue(data[0].grievance.categoryId);
						$('#grievanceSelectedCategory').val(data[0].grievance.categoryId);
						$('#grievanceIdToSave').text(grievanceId);
						$('#grievanceTxnId').text(txnId);
						$('#grievanceUserid').val(userId);
						var usertype = $("body").attr("data-roleType");
						var projectpath=path+"/Consignment/dowloadFiles/actual";
						//////console.log("usertype=="+usertype);
						$("#viewPreviousMessage").empty();
						for(var i=0; i<data.length; ++i)
						{

							$("#viewPreviousMessage").append("<div class='chat-message-content clearfix'><h6 style='float: left; font-weight: bold; margin-top:0;' id='mesageUserType'>" +data[i].userDisplayName+" : </h6><span style='float:right;'>" + data[i].modifiedOn + "</span><textarea class='materialize-textarea'>" + data[i].reply + "</textarea></div>");
							
							for (var j=0 ; j<data[i].attachedFiles.length;j++)
							{
								if(data[i].attachedFiles[j].docType==null)
									{
									
									//$("#viewPreviousMessage").append("<div class='chat-message-content clearfix'><a href='"+projectpath+"/"+data[i].attachedFiles[j].fileName+"/"+data[i].attachedFiles[j].grievanceId+"/"+data[i].attachedFiles[j].docType+"'>"+data[i].attachedFiles[j].fileName+"</a></div>");
									}
								else{
								////alert(data[i].attachedFiles[j].docType);
								if(data[i].attachedFiles[j].docType=="")
									{
									//$("#chatMsg").append("<div class='chat-message-content clearfix'> <span class='document-Type' ><b>Document Type : </b>"+data[i].attachedFiles[j].docType+"</span> <a href='"+projectpath+"/"+data[i].attachedFiles[j].fileName+"/"+data[i].attachedFiles[j].grievanceId+"/"+data[i].attachedFiles[j].docType+"'>"+data[i].attachedFiles[j].fileName+"</a></div>");
									}
								else{
									
									
									fileName=data[i].attachedFiles[j].fileName.split(' ').join('%20');
									$("#viewPreviousMessage").append("<div class='chat-message-content clearfix'> <span class='document-Type' ><b>Document Type : </b>"+data[i].attachedFiles[j].docType+"</span> <a onclick=fileDownload('"+fileName+"','actual','"+data[i].attachedFiles[j].grievanceId+"','"+data[i].attachedFiles[j].docType+"') >"+data[i].attachedFiles[j].fileName+"</a></div>");
								}
								}
								
								
							}

						}
						if(usertype=='CEIRAdmin')
						{
							$("#closeTicketCheckbox").css("display","block");
							//////console.log("block");
						}
						else{
							$("#closeTicketCheckbox").css("display","none");	
							//////console.log("none");
						}
						/*$.getJSON('./getDropdownList/DOC_TYPE', function(data) {
							for (i = 0; i < data.length; i++) {
								//////console.log(data[i].interp);
								$('<option>').val(data[i].tagId).text(data[i].interp).appendTo('#docTypetag1');
								
							}
						});

*/
					},
					error: function (jqXHR, textStatus, errorThrown) {
						 $('#errorModal').openModal({
			    	    	   dismissible:false
			    	       });
					}
				});
			}
			
			
			
			
			function saveEndUserGrievanceReply()
			{
				 var endUseruserId=488;
				var endUsergrievanceTicketStatus;
				if ($('#closeTicketCheck').is(":checked"))
				{
					endUsergrievanceTicketStatus=3;

				}
				else{
					endUsergrievanceTicketStatus=0;
				}
				var endUserremark=$('#replyRemark').val();
				var endUserreplyFile=$('#replyFile').val();
				var  endUsergrievanceIdToSave= $('#grievanceIdToSave').text();
				var  endUsergrievanceTxnId=  $('#grievanceTxnId').text();
				
				////////console.log("remark "+remark+"  replyFile="+replyFile+" grievanceTxnId="+grievanceTxnId+"grievanceIdToSave="+grievanceIdToSave+"grievanceTicketStatus=="+grievanceTicketStatus);
				var endUserfieldId=1;
				var endUserfileInfo =[];
				var endUserformData= new FormData();
				var endUserfileData = [];
			
				var endUserx;
				var endUserfilename='';
				var endUserfilediv;
				var endUseri=0;
				var formData= new FormData();
				var endUserdocTypeTagIdValue='';
				var endUserfilename='';
		
				$('.fileDiv').each(function() {	
					var endUserx={
					"docType":$('#docTypetag'+endUserfieldId).val(),
					"fileName":$('#docTypeFile'+endUserfieldId).val().replace('C:\\fakepath\\',''),
					"grievanceId":$('#grievanceIdToSave').text()
					}
					endUserformData.append('files[]',$('#docTypeFile'+endUserfieldId)[0].files[0]);
					endUserfileInfo.push(endUserx);
					endUserfieldId++;
					endUseri++;
				});
				var endUsermultirequest={
						"attachedFiles":endUserfileInfo,
						"txnId":endUsergrievanceTxnId,
						"reply":endUserremark,
						"grievanceId":endUsergrievanceIdToSave,
						"grievanceStatus":endUsergrievanceTicketStatus,
						"featureId":6,
						"userId":endUseruserId
					}
				endUserformData.append('fileInfo[]',JSON.stringify(endUserfileInfo));
				endUserformData.append('multirequest',JSON.stringify(endUsermultirequest));
				
				
				formData.append('file', $('#replyFile')[0].files[0]);
				formData.append('remark',remark);
				formData.append('grievanceId',grievanceIdToSave);
				formData.append('txnId',grievanceTxnId);
				formData.append('grievanceStatus',grievanceTicketStatus);
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: './saveEndUserGrievanceReply',
					type: 'POST',
					data: formData,
					processData: false,
					contentType: false,
					success: function (data, textStatus, jqXHR) {
					
						$('#replyMsg').openModal({
			    	    	   dismissible:false
			    	       });
						//////console.log(data.txnId);
						if(data.errorCode=="0")
						{
							
							$('#replyGrievanceId').text(data.txnId);

						}
						else 
						{
							$('#showReplyResponse').text('');
							$('#showReplyResponse').text(data.message);
						}
						
					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax")
					}
				});
				return false;
			}
			
			
			
			function dispatchDateValidation() {
				var currentDate;
				var dispatcDate = $('#expectedDispatcheDate').val();
				var now = new Date();
				if (now.getDate().toString().charAt(0) != '0') {
					currentDate = '0' + now.getDate();

					/* //alert("only date="+currentDate); */
				} else {
					currentDate = now.getDate();
				}
				var today = now.getFullYear() + '-' + (now.getMonth() + 1) + '-'
						+ currentDate;
				////alert("today"+today);
				//////console.log("dispatche=" + dispatcDate);
				//////console.log("todays parse date" + Date.parse(today));
				//////console.log("dispatche parse date" + Date.parse(dispatcDate));

				if (Date.parse(today) > Date.parse(dispatcDate)) {
					myFunction("dispatche date should be greater then or equals to today");
					$('#expectedDispatcheDate').val("");
				}

				////alert("current date="+today+" dispatche date="+dispatcDate)
			}
			
	$('#endUsercategory').on('change',function() {
	          var request ={
				 "childTag": "DOC_TYPE",
				  "featureId": 6,
				  "parentValue":  parseInt($('#endUsercategory').val()),	
				  "tag": "GRIEVANCE_CATEGORY",
				  "userTypeId":17,
			}
	
	////////console.log("request --->" +JSON.stringify(request));
	        var token = $("meta[name='_csrf']").attr("content");
	  		var header = $("meta[name='_csrf_header']").attr("content");
	  		$.ajaxSetup({
	  			headers:
	  			{ 'X-CSRF-TOKEN': token }
	  		});         
	 $.ajax({
			url: './get/tags-mapping',
			type: 'POST',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
				$("#endUserdocTypetag1").empty();
				$('#endUserdocTypetag1').append('<option value="">'+$.i18n('selectDocumentType')+'</option>');
				//////console.log(data);
				for (i = 0; i < data.length; i++){
						//var html='<option value="'+data[i].value+'">'+data[i].interp+'</option>';
						//$('#docTypetag1').append(html);	
					$('<option>').val(data[i].tagId).text(data[i].interp).appendTo('#endUserdocTypetag1');
				
				}
				
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//////console.log("error in ajax")
			}
		});
	 
	}); 
	
	function setDocTypeValue(categoryParentValue){
		
		
		var request ={
					 "childTag": "DOC_TYPE",
					  "featureId": 6,
					  "parentValue":  parseInt(categoryParentValue),	
					  "tag": "GRIEVANCE_CATEGORY",
					  "userTypeId": 17,
				}
		
		////////console.log("request --->" +JSON.stringify(request));
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		}); 	
  		
		 $.ajax({
				url: './get/tags-mapping',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
					$("#docTypetag1").empty();
					$('#docTypetag1').append('<option value="">'+$.i18n('selectDocumentType')+'</option>');
					//////console.log(data);
					for (i = 0; i < data.length; i++){
							//var html='<option value="'+data[i].value+'">'+data[i].interp+'</option>';
							//$('#docTypetag1').append(html);	
							
						$('<option>').val(data[i].tagId).text(data[i].interp).appendTo('#docTypetag1');
					
					}
					
				},
				error: function (jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
		}
	
	
	
	
	function enableSelectFile(){
		
		//$("#endUserdocTypeFile1").attr("disabled", false);
		//$("#endUserdocTypeFile1").attr("required", true);
		//$("#endUserFileLabel").append('<span class="star">*</span>');		
		if($('#endUserdocTypetag1').val() != ''){
			$("#endUserdocTypeFile1").attr("disabled", false);
			$("#endUserdocTypeFile1").attr("required", true);
			$("#removestar").find(".star").remove();
			$("#endUserFileLabel").append('<span class="star">*</span>');
		}else{
			$("#endUserdocTypeFile1").attr("required", false);
			$('#filetextField').val('');
			$("#removestar").find(".star").remove();
		}
	}
	$("input[type=file]").keypress(function(ev) {
	    return false;
	    //ev.preventDefault(); //works as well

	});