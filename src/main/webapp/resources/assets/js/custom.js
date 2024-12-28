$(".close").click(function() {
$(this).closest('.modal').removeAttr("style");
});

$(document).ready(function () {
$(".select-row:checkbox").change(function () {
$(this).parent().parent().parent().toggleClass("trselected");
});
});

$(function() {
 $('.slide-right').bind('click',function(event){
          const leftPos = $('.slide-content').scrollLeft();
              $(".slide-content").animate({scrollLeft: leftPos + 250}, 150);    });
               $('.slide-left').bind('click',function(event){
                 const leftPos = $('.slide-content').scrollLeft();
                     $(".slide-content").animate({scrollLeft: leftPos - 250}, 150);
                       });});