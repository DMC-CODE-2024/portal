

function InvalidMsg(textbox,type,msg) {

	var element = document.getElementById(textbox.id);

	if(element.validity.valueMissing){
		if(type=="input" ){
			element.setCustomValidity($.i18n('requiredMsg_input'));
		}
		else if(type=="date"){
			element.setCustomValidity($.i18n('requiredMsg_date'));	
		}
		else if(type=="select"){
			element.setCustomValidity($.i18n('requiredMsg_select'));	
		}
		else if(type=="fileType"){
			element.setCustomValidity($.i18n('requiredMsg_fileType'));	
		}
		else if(type=="email"){
			element.setCustomValidity($.i18n('requiredMsg_email'));	
		}
		else if(type=="checkbox" && $('#'+textbox.id).is(":checked")== false){
			element.setCustomValidity($.i18n('requiredMsg_checkbox'));	
		}
	}

	else if (element.validity.patternMismatch) {

		if(type=="input" || type=="date" || type=="select" || type=="fileType" || type=="email"){
			element.setCustomValidity(msg);
		}

		else if(type=="checkbox" && $('#'+textbox.id).is(":checked")== true){
			element.setCustomValidity('');
		}

		return false;
	} 
	else{

		if(type=="input" || type=="date" || type=="select" || type=="fileType" || type=="email" || (type=="checkbox" && $('#'+textbox.id).is(":checked")== true)){
			element.setCustomValidity('');
		}

		return true;

	}
}