function FormDataToJSON(FormElement) {
    var formData = new FormData((document.getElementById(FormElement)));
    var ConvertedJSON = {};
    for (const [key, value]  of formData.entries())
    {
        ConvertedJSON[key] = value;
    }

    return ConvertedJSON
}

function populate(frm, data) {
    $.each(data, function (key, value) {
        $('[name=' + key + ']', frm).val(value);
    });
}

/*$('.textarea').on("cut copy paste",function(e) {
    e.preventDefault();
 });*/

/*$('.textarea').bind('copy paste cut',function(e) {
	  e.preventDefault();
	  alert('cut,copy & paste options are disabled !!');
	});*/
/*$('input[type=textarea]').bind("cut copy paste",function(e) {
	  e.preventDefault();
	  alert('cut,copy & paste options are disabled !!');
	 });*/

/*$('textarea').on("paste", function(e) {   
    e.preventDefault();
});*/

$(document).keypress(
		  function(event){
			  
			  
		    if (event.which == '13') {
		      event.preventDefault();
		    }
		    
		    if (event.which == '33'){  event.preventDefault();}
		    if (event.which == '35'){  event.preventDefault();}
		    if (event.which == '36'){  event.preventDefault();}
		    if (event.which == '37'){  event.preventDefault();}
		    if (event.which == '94'){  event.preventDefault();}
		    if (event.which == '38'){  event.preventDefault();}
		    if (event.which == '42'){  event.preventDefault();}
		    if (event.which == '43'){  event.preventDefault();}
		    if (event.which == '61'){  event.preventDefault();}
		    if (event.which == '91'){  event.preventDefault();}
		    if (event.which == '93'){  event.preventDefault();}
		    if (event.which == '123'){  event.preventDefault();}
		    if (event.which == '125'){  event.preventDefault();}
		    if (event.which == '92'){  event.preventDefault();}
		    if (event.which == '124'){  event.preventDefault();}
		    if (event.which == '59'){  event.preventDefault();}
		    if (event.which == '39'){  event.preventDefault();}
		    if (event.which == '34'){  event.preventDefault();}
		    if (event.which == '58'){  event.preventDefault();}
		    if (event.which == '60'){  event.preventDefault();}
		    if (event.which == '62'){  event.preventDefault();}
		    //if (event.which == '47'){  event.preventDefault();}
		    if (event.which == '63'){  event.preventDefault();}
		 //  alert(event.which);
		    
});



function setData(myForm,result){
	
	for (var i = 0; i < myForm.elements.length; i++) {
       
         	var idOfElement=myForm.elements[i].id;
         	if(idOfElement!=""){
         		
	            	if(result.hasOwnProperty(idOfElement)){
	            		
	            			$("#"+idOfElement).val(result[idOfElement]);
	            		
	            	}	            	
	            	else{
	            		$("#"+idOfElement).val("");
	            	}
         	}
         }
	
}

function getEntityFieldsByFormId(formId){
	
	var myForm="";
	myForm = document.getElementById(formId);
	
	for (var i = 0; i < myForm.elements.length; i++) {
        // console.log(myForm.elements[i].id);
         	var idOfElement=myForm.elements[i].id;
         	if(idOfElement!=""){
         		console.log("entity..."+idOfElement);	
         	}
         }
	
}
function checkManInvoice() {

    var fields = ["doctype", "docnum", "docDate", "supTyp",
        "selgstin", "selLglNm", "selTrdNm", "selemail", "selAddr1",
        "selAddr2", "selLoc", "selpinno", "selState", "selphone",
        "buygstin", "buyLglNm", "buyTrdNm", "buyemail", "buyAddr1",
        "buyAddr2", "buyLoc", "buypinno", "buyState", "buybPos",
        "buyphone", "dispLglNm", "dispLoc", "dispPin", "dispStCd",
        "dispAddr1", "dispAddr2", "shipLglNm", "shipGSTIN", "shipTrdNm",
        "shipLoc", "shipPin", "shipStcd", "shipAddr1", "shipAddr2",
        "valSGST", "valCGST", "valIGST", "valCes", "valAssVal",
        "valTotInvVal", "valTotRo"];


    /*for (var i = 0; i < fields.length; i++) {
        console.log(fields[i] + " :: " + document.getElementsByName(fields[i])[0].value);
        if (document.getElementsByName(fields[i])[0].value === "") {
            addValCss(fields[i]);
            return false;
        }
    }
    return true;*/
}

function addValCss(controlName) {
    
   if(controlName=="states"){
        		 $(".select2-selection select2-selection--multiple").css(
                     "border", "1px solid red !important"
                 );
                 $('[name="' + controlName + '"]').focus();
        		 
        	}
       else{
	  $('[name="' + controlName + '"]').css({'border': '1px solid red', 'box-shadow': 'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(249, 0, 0, 0.6)', '-webkit-box-shadow': 'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(249, 0, 0, 0.6)', 'outline-color': 'transparent'});
    $('[name="' + controlName + '"]').focus();
		}
}

function removeValCss(controlName) {
    $('[name="' + controlName + '"]').css({'border': '1px solid #b7b7b7', 'box-shadow': 'none', '-webkit-box-shadow': 'none'});
}
