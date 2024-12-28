window.parent
				.$('#langlist')
				.on(
						'change',
						function() {
							var lang = window.parent.$('#langlist').val() == 'km' ? 'km'
									: 'en';
							
							window.location
									.assign("./openGrievanceForm?reqType=formPage&lang="
											+ lang);
						});
	
		var documenttype, selectfile, selectDocumentType,REGISTER_TYPE_APPROVE_REJECTED,TRCRegister_futureRef;
		var featureId = 21;
		
		populateCountries("country");
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
	        headers:
	        { 'X-CSRF-TOKEN': token }
	    	});
		
		$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].state).text(data[i].interp)
				.appendTo('#status');
			}
		});
		
		$.getJSON('./productList', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].brand_name)
						.appendTo('#productname');
			}
			$('select#productname').select2();
		});

		$('#productname').on(
				'change',
				function() {
					var brand_id = $('#productname').val();
					$.getJSON('./productModelList?brand_id=' + brand_id,
							function(data) {
					/*	$('#select2-modelNumber-container').empty();
								$("#modelNumber").empty();
								for (i = 0; i < data.length; i++) {
									$('<option>').val(data[i].id).text(
											data[i].modelName).appendTo(
											'#modelNumber');
								}
								*/
						$('#select2-modelNumber-container').empty();
								$('#modelNumber').empty();
								var html='<option value="">'+$.i18n('selectModelNumber')+'</option>';
								$('#modelNumber').append(html);	
								for (i = 0; i < data.length; i++){
									var html='<option value="'+data[i].id+'">'+data[i].modelName+'</option>';
									$('#modelNumber').append(html);	
								}
								
								
								
							});
					$('select#modelNumber').select2();
				});
		
	
		
		function registerTAC() {
			//$('div#initialloader').fadeIn('fast');
			var trademark = $('#trademark').val();
			var productName = $('#productname').val();
			var modelNumber = $('#modelNumber').val();
			var manufacturerCountry = $('#country').val();
			var frequencyRange = $('#frequencyrange').val();
			var tac = $('#tac').val();
			var userId = $("body").attr("data-userID");
			
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
			
			//$('.fileDiv').each(function() {
			
			for (var k=1; k<id; k++){
				
			
			if($('#docTypetag'+fieldId).val() != undefined && $('#docTypetag'+fieldId).val() != false ){
				
				
			var x={
				"docType":$('#docTypetag'+fieldId).val(),
				"fileName":$('#docTypeFile'+fieldId).val().replace('C:\\fakepath\\','')
				}
				formData.append('files[]',$('#docTypeFile'+fieldId)[0].files[0]);
			documentFileName=$('#docTypeFile'+fieldId).val().replace('C:\\fakepath\\','')
			docTypeTag=$('#docTypetag'+fieldId).val();
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
			}
				fieldId++;
				i++;
				
			//}); 
			};
			
			if(filesameStatus==true)
			{	
			
			//$('#fileFormateModal').openModal();
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
			//$('#fileFormateModal').openModal();
				$('#fileErrormessage').text('')
				$('#fileErrormessage').text($.i18n('documentTypeName'));
			return false;
			
			}
			
			var multirequest={
					"attachedFiles":fileInfo,
					"trademark" : $('#trademark').val(),
					"productName" : parseInt($('#productname').val()),
		 			"modelNumber" : parseInt($('#modelNumber').val()),
					"manufacturerCountry" : $('#country').val(),
		 			"frequencyRange" : $('#frequencyrange').val(),
					"tac" : $('#tac').val(),
			 		"userId" : $("body").attr("data-userID"),
			 		"featureId" : featureId,
			 		"approveStatus" : 0
				}
			//////console.log("multirequest------------->" +JSON.stringify(multirequest))
			formData.append('fileInfo[]',JSON.stringify(fileInfo));
			formData.append('multirequest',JSON.stringify(multirequest));
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
			});
			
			$.ajax({
				url : './register-approved-device',
				type : 'POST',
				data : formData,
				mimeType: 'multipart/form-data',
				processData : false,
				contentType : false, 
				async:false,
				success : function(data, textStatus, jqXHR) {
					//$('div#initialloader').delay(300).fadeOut('slow');
					$("#trcSubmitButton").prop('disabled', true);
						var result =  JSON.parse(data)
						//////console.log("successdata-----" +result);
						$("#trcSubmitButton").prop('disabled', true);
						//$('#RegisterManageTypeDevice').openModal();
						$('#RegisterManageTypeDevice').openModal({
					    	   dismissible:false
					       });
						$.i18n().locale = lang;
						$.i18n().load({
							'en' : './resources/i18n/en.json',
							'km' : './resources/i18n/km.json'
						}).done(function() {
							if(result.errorCode==200){
								//$('#sucessMessage').text('');
								//$('#sucessMessage').text($.i18n('TRCRegister_futureRef'));
								$('#txnId').append(result.txnId);
							}else if(result.errorCode==201){
								$('#sucessMessage').text('');
								$('#sucessMessage').text($.i18n('REGISTER_TYPE_APPROVE_REJECTED'));
							}else if(result.errorCode == 204) {
								$('#sucessMessage').text('');
								$('#sucessMessage').text($.i18n('TYPE_APPROVE_WRONG_ID'));
							}else if(result.errorCode == 500) {
								$('#sucessMessage').text('');
								$('#sucessMessage').text($.i18n('TYPE_APPROVE_UPDATE_FAIL'));
							}else if(result.errorCode == 409) {
								$('#sucessMessage').text('');
								$('#sucessMessage').text($.i18n('UPDATE_ERROR'));
							}
							
							//REGISTER_TYPE_APPROVE_REJECTED=$.i18n('REGISTER_TYPE_APPROVE_REJECTED');
							//TRCRegister_futureRef=$.i18n('TRCRegister_futureRef');
							
						});
						
						
						
				},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});

			return false;

		}


		$.getJSON('./getSourceTypeDropdown/DOC_TYPE/21', function(data) {
			//////console.log("@@@@@" + JSON.stringify(data));
			for (i = 0; i < data.length; i++) {
				//////console.log(data[i].interp);
				$('<option>').val(data[i].tagId).text(data[i].interp).appendTo(
						'#docTypetag1');
				$('<option>').val(data[i].value).text(data[i].tagId).appendTo(
						'#docTypetagValue1');
				$('#docTypetagValue1').val(data[i].value);
			}
		});

		function cleanReplyPopUp() {
			//////console.log("reset form function");
			$('#replymessageForm').trigger("reset");
		}
 
		$.getJSON('./addMoreFile/more_files_count', function(data) {
			//////console.log(data);
			
			localStorage.setItem("maxCount", data.value);
			
		});
	 
			//var max_fields = 2; //maximum input boxes allowed
			var max_fields =localStorage.getItem("maxCount");
			if (max_fields==0){
				//////console.log("1111");
				 $(".add_field_button").prop('disabled', true);
			 }
		var wrapper = $(".mainDiv"); //Fields wrapper
		var add_button = $(".add_field_button"); //Add button ID
		var x = 1; //initlal text box count
		var id = 2;
		$(".add_field_button")
				.click(
						function(e) { //on add input button click
							e.preventDefault();
							if (x < max_fields) { //max input box allowed
								x++; //text box increment
								$(wrapper)
										.append(
												'<div id="filediv'+id+'" class="fileDiv"><div class="row"><div class="file-field col s12 m6"><label for="Category">'
														+ $
																.i18n('documenttype')
														+ '</label><select id="docTypetag'+id+'"  class="browser-default"> <option value="" disabled selected>'
														+ $
																.i18n('selectDocumentType')
														+ ' </option></select><select id="docTypetagValue'+id+'" style="display:none" class="browser-default"> <option value="" disabled selected>'
														+ $
																.i18n('selectDocumentType')
														+ ' </option></select></div> <div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'
														+ $.i18n('selectfile')
														+ '</span><input id="docTypeFile'+id+'" type="file" onchange=enableAddMore("docTypeFile'+id+'","filediv'+id+'") name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" type="text"></div></div><div style="cursor:pointer;background-color:red;margin-right: 1.7%;" onclick="remove_field('+id+')" class="remove_field btn right btn-info">-</div></div></div>'); //add input box
							}

							if(x==max_fields){
								
								 $(".add_field_button").prop('disabled', true);
							}
							
							$.getJSON('./getSourceTypeDropdown/DOC_TYPE/21', function(
									data) { 	

								for (i = 0; i < data.length; i++) {
									//////console.log(data[i].interp);
									var optionId = id - 1;
									$('<option>').val(data[i].tagId).text(
											data[i].interp).appendTo(
											'#docTypetag' + optionId);
									$('<option>').val(data[i].value).text(
											data[i].tagId).appendTo(
											'#docTypetagValue' + optionId);
									//////console.log('#docTypetag' + optionId);

								}
							});
							id++;

						});
		/* $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
			e.preventDefault();
			$(this).parent('div').remove();
			x--;
			id--;
		})
		 */
		function remove_field(fieldId ){
			$('#filediv' + fieldId).remove();
			$(this).parent('div').remove();
			x--;
			 $(".add_field_button").prop('disabled', false);
		}
		
		/*$(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
			e.preventDefault();
			var Iid = id - 1;
			//alert("@@@"+Iid)
			$('#filediv' + Iid).remove();
			$(this).parent('div').remove();
			x--;
			id--;

		})*/
		
		function saveDocTypeValue() {
			$('#docTypetagValue').val(data[i].value).change();
			$('#docTypetagValue').val(data[i].value).change();
		}

	
		
/*		function fileTypeValueChanges(dd, ddd) {
			var uploadedFileName = $("#file").val();
			uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
			var ext = uploadedFileName.split('.').pop();
			
			var fileSize = ($("#file")[0].files[0].size);
			fileSize = (Math.round((fileSize / 1024) * 100) / 100)
		   if (uploadedFileName.length > 30) {
		       $('#fileFormateModal').openModal();
		       $('#fileErrormessage').text('');
		       $('#fileErrormessage').text('file name length must be less then 30 characters.');
		   } 
			else if(ext!='csv')
				{
				$('#fileFormateModal').openModal();
				 $('#fileErrormessage').text('');
			       $('#fileErrormessage').text('file extension must be in  CSV.');
				}
			else if(fileSize>='5000'){
				$('#fileFormateModal').openModal();
				 $('#fileErrormessage').text('');
			       $('#fileErrormessage').text('file size must be less then 5 mb.');
			}
			else {
				////console.log("file formate is correct")
				
			}
		}
		*/
		
	/*	function clearFileName() {
			$('#docTypeFile1').val('');
			$("#file").val('');
			$('#fileFormateModal').closeModal();
		}*/

		function enableAddMore(id,removeFileDivId){
			 var uploadedFileName = $("#"+id).val();
				uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
				////alert("file extension=="+uploadedFileName)
				var ext = uploadedFileName.split('.').pop();

				var fileSize = ($("#"+id)[0].files[0].size);
				/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
					//alert("----"+fileSize);*/
				fileSize = Math.floor(fileSize/1000);
				$('#FilefieldId').val(id);
				////alert(uploadedFileName+"----------"+ext+"----"+fileSize)
				var fileExtension =ext.toLowerCase();
				////console.log("file type: "+fileExtension);
				var extArray = ["png","jpg","jpeg","gif","bmp","gif","csv"];
				var isInArray =extArray.includes(fileExtension);
				
				$('#removeFileInput').val(id);
				$('#removeFileId').val(removeFileDivId);
				////console.log("isInArray: "+isInArray)
				if (uploadedFileName.length > 30) {
					$('#fileFormateModal').openModal();
					$('#fileErrormessage').text('');
					$('#fileErrormessage').text($.i18n('imageValidationName'));
				} 
				else if(isInArray ==false)
				{
					$('#fileFormateModal').openModal({
						dismissible:false
					});
					$(".add_field_button").attr("disabled", true);
					$('#fileErrormessage').text('');
					$('#fileErrormessage').text($.i18n('imageMessage'));

				}
				else if(ext=='csv')
				{
					
					if(fileSize>='10000'){
						$(".add_field_button").attr("disabled", true);
						window.parent.$('#fileFormateModal').openModal({
							dismissible:false
						});
						
					}
					
				}
				else if(fileSize>=5000){
					$('#fileFormateModal').openModal({
						dismissible:false
					});
					$('#fileErrormessage').text('');
					$('#fileErrormessage').text($.i18n('imageSize'));	
					$(".add_field_button").attr("disabled", true);
				}
				

			$(".add_field_button").attr("disabled", false);
		}
		function enableSelectFile(){
			if($('#docTypetag1').val() != ''){
				$("#docTypeFile1").attr("disabled", false);
				$("#docTypeFile1").attr("required", true);
				$("#removestar").find(".star").remove();
				$("#supportingdocumentFile").append('<span class="star">*</span>');
			}else{
				$("#docTypeFile1").attr("required", false);
				$('#filetextField').val('');
				$("#removestar").find(".star").remove();
			}
			
		}
		

		$("input[type=file]").keypress(function(ev) {
		    return false;
		    //ev.preventDefault(); //works as well

		});
		
		
		function clearFileName() {
			/*$('#fileName').val('');
			$("#file").val('');
			$('#fileFormateModal').closeModal();*/
			
			$('#fileFormateModal').closeModal();
			var fieldInput=$('#removeFileInput').val();
			$('#'+fieldInput).val('');
			var inputPlaceHolder=$('#removeFileId').val();
			$('#'+inputPlaceHolder).find('input:text').val(''); 

		}