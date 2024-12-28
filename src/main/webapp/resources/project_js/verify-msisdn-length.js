let isCheckPass = (paramValue, callback) => {
    $.ajax({
        url: './msisdn-series/series/' + paramValue,
        dataType: 'json',
        async: false,
        success: function(data) {
            callback(data.valid);
        },
        error: function() {
            // Handle error if needed
         //   callback(false); // Or return any other default value in case of error
        }
    });
};
