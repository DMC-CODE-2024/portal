function verifyOtp(){
	var obj="";
	$("#verifyOtpForm").each(function(key, val){
        val = $(this);
        if(val.html() !== "") {
            obj =  
                { 
            		phoneOtp:val.find('#phoneOtp').val(),
            		emailOtp:val.find('#emailOtp').val(),
            		userid: val.find('#userid').val()
                } 
        }
        });
	$.ajax({
		type : 'POST',
		url : contextpath + '/verifyOtp',
		contentType : "application/json",
		dataType : 'html',
		data : JSON.stringify(obj),
		success : function(data) {
		////console.log(data);	
         var resp=JSON.parse(data);
         if(resp.statusCode==200){
//        	window.location.href='#otpMessage';
        	$('#otpMessage').openModal();   
        	$("#otpResponse").text(resp.response);
        	// $('#otpMessage').modal('open');
         }
         else{
        	  
         }
		},
		error: function (xhr, ajaxOptions, thrownError) {
	      }
		
	});
} 
 
function resendOtp(){
	var id=document.getElementById("userid").value;
	$.ajax({
		type : 'POST',
		url : contextpath + '/resendOtp/'+id,
		contentType : "application/json",
		dataType : 'html',
		success : function(data) {
         var response=JSON.parse(data);
        $("#resendOtp").text(response.response); 
		},    
		error: function (xhr, ajaxOptions, thrownError) {
	      }
	});
}

function refreshCaptcha(imageId){
	
	 path = contextpath+'/captcha?cache='; //for example
	   imageObject = document.getElementById(imageId);
	   imageObject.src = path + (new Date()).getTime();
}

function reg(){
	
	return false;
	
}








