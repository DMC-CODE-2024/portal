	//var featureId = 26;
	var featureId = $("body").attr("data-featureId");
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var roleType = $("body").attr("data-roleType");
	var userName = $("body").attr("data-selected-username");
	var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	$.i18n().locale = lang;
    $('div#initialloader').delay(300).fadeOut('slow');
	$.i18n().load( {
		'en': './resources/i18n/en.json',
		'km': './resources/i18n/km.json'
	}).done( function() {
	});





	function searchIMEIDetails() {
        //$('#initialtextloader').show();
		var imei = $('#searchIMEI').val();
		var ticketId=$('#searchTicketId').val();



	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	// Define additional headers
    var clientType = "END_USER";
    var clientId = "DUMMY_AGENT";
    var loggedInUser = "2";

     $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': token,
            'X-Client-Type': clientType,
            'X-Client-Id': clientId,
            'loggedInUser': loggedInUser
        }
    });

    $.ajax({
		url: './verify-ticket/'+ticketId,
		dataType : 'json',
		type: 'GET',
		contentType : 'application/json; charset=utf-8',
		async:false,
		success: function (data) {
		    //console.log(" Response data "+ JSON.stringify(data.data));
			 if (data.data != null) {
                            Promise.all([
                                getImsiMsidn(),
                                getDeviceInformation(),
                                getDevicetableState()
                            ]).then(() => {
                                console.log("All requests completed successfully.");
                            }).catch((error) => {
                                console.error("Error in one of the requests:", error);
                            });
                        } else {
                            $("#errorMsg").css("display", "block");
                        }

		},
        error: function (jqXHR, textStatus, errorThrown) {
               $("#errorMsg").css("display", "block");
        }

	});
		return false;

	};




	function getImsiMsidn(){
	let title = "getImsiMsidn";
    	var payload={
    			"imei": $('#searchIMEI').val(),
    			"userId":parseInt(userId),
    			"featureId":parseInt(featureId),
    			"userTypeId": parseInt($("body").attr("data-userTypeID")),
    			"userType":$("body").attr("data-roleType"),
    			"userName" : userName,
    			"roleType" : $("body").attr("data-roleType"),
    			"requestId" : $('#searchTicketId').val()
    	}

    	var token = $("meta[name='_csrf']").attr("content");
    	var header = $("meta[name='_csrf_header']").attr("content");
    	$.ajaxSetup({
    		headers:
    		{ 'X-CSRF-TOKEN': token }
    	});
        let promise = new Promise(function(resolve, myReject) {
    	$.ajax({
    		url: './searchimei-msisdn',
    		dataType : 'json',
    		type: 'POST',
    		async: false,
    		contentType : 'application/json; charset=utf-8',
    		data : JSON.stringify(payload),
    		success: function (data) {
    			var result=data.data
                if(result != null){
    			 setGsmaDetails(result);
                 resolve(true);
                }else{
                 myReject(false);
                }
            }
        });

    	});
    	return promise.then((value) =>
    	 { isValid(value,title)},
    	   (error) => {isValid(error,title)});


    };

    function getDeviceInformation(){
        let title = "getDeviceInformation";
        	var payload={
        			"imei": $('#searchIMEI').val(),
        			"userId":parseInt(userId),
        			"featureId":parseInt(featureId),
        			"userTypeId": parseInt($("body").attr("data-userTypeID")),
        			"userType":$("body").attr("data-roleType"),
        			"userName" : userName,
        			"roleType" : $("body").attr("data-roleType")
        	}

        	var token = $("meta[name='_csrf']").attr("content");
        	var header = $("meta[name='_csrf_header']").attr("content");
        	$.ajaxSetup({
        		headers:
        		{ 'X-CSRF-TOKEN': token }
        	});
            let promise = new Promise(function(resolve, myReject) {
            $.ajax({
        		url: './get-device-details',
        		dataType : 'json',
        		type: 'POST',
        		async: false,
        		contentType : 'application/json; charset=utf-8',
                data : JSON.stringify(payload),
        		success: function (data) {
        			var result=data.data
        			setDeviceInformation(result);

        			if(result.id != null){
                        resolve(true);
                    }else{
                         myReject(false);
                    }

        		}
        	});
        });
                	return promise.then((value) =>
                	 { isValid(value,title)},
                	   (error) => {isValid(error,title)});

        };

     function getDevicetableState() {
        let title="getDevicetableState";
        var customerCareRequest = {
                "imei": $('#searchIMEI').val(),
                "msisdn": "",
        };

        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': token
            }
        });
        let promise = new Promise(function(resolve, myReject) {
        return $.ajax({
            url: "./get-device-state",
            type: 'POST',
            async: false,
            data: JSON.stringify(customerCareRequest),
            dataType : 'json',
            contentType : 'application/json; charset=utf-8',
            success: function (data) {
                //console.log("data " +JSON.stringify(data));
                var flattenedData = data.result.flat();
                    var allIdsNull = flattenedData.every(function(item) {
                                return item.id === null;
                            });
                     if(!allIdsNull){
                          resolve(true);
                     }else{
                          myReject(false);
                     }

             },
        });
        });
        return promise.then((value) =>
                    	 { isValid(value,title)},
                    	   (error) => {isValid(error,title)});
    };

    var isTrue=false;
        function isValid(flag,title){
            $("#errorIMEIMsg").css("display", "none");
            //localStorage.removeItem("jsonData");
            //localStorage.removeItem("mdrJsonData");
            console.log("flag " +flag + "and title" +title);
            //condition to check once if true then forward
            isTrue = (title === "getImsiMsidn" && flag) ||
                               (title === "getDeviceInformation" && flag) ||
                               (title === "getDevicetableState" && flag);

             console.log("jsonData " + JSON.stringify(jsonData));
            console.log("mdrJsonData " + JSON.stringify(mdrJsonData));
            if (isTrue) {
                    localStorage.setItem("jsonData",JSON.stringify(jsonData));
                    localStorage.setItem("mdrJsonData",JSON.stringify(mdrJsonData));
                    window.location.replace("./search?via=other&imei="+$('#searchIMEI').val());
                }else{
                    $("#errorIMEIMsg").css("display", "block");
                }
                // $('#initialtextloader').hide();
        }



        var jsonData = {};
        function setGsmaDetails(data){
                let {msisdn,imei,imsi}={msisdn:data.msisdn, imei: data.imei, imsi:data.imsi};
                jsonData['msisdn']=msisdn,jsonData['imei']=imei,jsonData['imsi']=imsi
            };


    var mdrJsonData;
    function setDeviceInformation(data){
              mdrJsonData = {
                                "deviceType": data.deviceType,
                                "os": data.os,
                                "brandName":data.brandName,
                                "modelName":data.modelName,
                                "marketingName":data.marketingName,
                                "manufacturer":data.manufacturer,
                                "deviceStatus" :data.deviceStatus,
                                 "organizationId":data.organizationId,
                                 "trcApprovedStatus":data.trcApprovedStatus
                                 }
    };



      $('.cancel-btn-search-imei').click(function() {
      $('#searchIMEI,#searchTicketId').val('');
                 $("#errorMsg").css("display", "none");
                 $("#errorIMEIMsg").css("display", "none");
      });


