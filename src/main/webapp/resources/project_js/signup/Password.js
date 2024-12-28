$(document).on('click', '.toggle-password', function() {

    $(this).toggleClass("fa-eye fa-eye-slash");
    
    var input = $(".password");
    input.attr('type') === 'password' ? input.attr('type','text') : input.attr('type','password')
});


$(document).on('click', '.toggle-password2', function() {

    $(this).toggleClass("fa-eye fa-eye-slash");
    
    var input = $(".password2");
    input.attr('type') === 'password' ? input.attr('type','text') : input.attr('type','password')
});

$(document).on('click', '.toggle-password3', function() {

    $(this).toggleClass("fa-eye fa-eye-slash");
    
    var input = $(".password3");
    input.attr('type') === 'password' ? input.attr('type','text') : input.attr('type','password')
});

$(document).on('click', '.toggle-password4', function() {

    $(this).toggleClass("fa-eye fa-eye-slash");
    
    var input = $(".password4");
    input.attr('type') === 'password' ? input.attr('type','text') : input.attr('type','password')
});