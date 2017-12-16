// Try me from your project 
var settings = { 
    "url": "https://testme.appdrag.com/api/SearchProducts", 
    "data": { 
        "brand" : "nivea" // or pass a variable 
    }, 
    "method": "POST", 
    "async": true, 
    "crossDomain": true, 
    "processData": true 
}; 
$.ajax(settings).done(function (response) { 
    console.log(response); // TODO: Do something with the result 
});
