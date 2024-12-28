
$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});

$(document).ready(function(){
$('.datepicker').datepicker({
    dateFormat: "yy-mm-dd"
    });
});