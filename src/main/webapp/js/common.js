function dateValidationCheck(date1, date2){	 
	var check="false";		
	
	if(date1 !="" && date2 !=""){
		
		date1=moment(date1, 'DD-MM-YYYY HH:mm:ss').format('YYYY-MM-DD');
	
		date2=moment(date2, 'DD-MM-YYYY HH:mm:ss').format('YYYY-MM-DD');
			
			if(date1 > date2){
				check="true";
			}
			
	}	
		return check;
  }


function replaceAllSpecialCharacter(data){
	
	data=data.replace(/[^\x00-\x7F]/g, "");
	
	return data.replace(/[^a-zA-Z0-9 ]/g, " ");
}

function addDaysToDate(date, days){
	
	var new_date="";
	if(date !="" && days !="" && days!="0" ){
		 new_date = moment(date, "DD-MM-YYYY").add(days, 'days').format("DD-MM-YYYY");
	}
	
	return new_date;	
}

function substractDaysFromDate(date, days){
	
	var new_date="";
	if(date !="" && days !="" && days!="0" ){
		 new_date = moment(date, "DD-MM-YYYY").subtract(days, 'days').format("DD-MM-YYYY");
	}
	
	return new_date;	
}

/*by Prashant 3 june start here */

function validateSelfAssessmentForm(observedScore,MaxScore,fieldId){
	
	console.log("observedScore >> "+observedScore);
	console.log("MaxScore >> "+MaxScore);
	console.log("fieldId >> "+fieldId);
	
	
	/*if(parseInt(observedScore) > parseInt(MaxScore)){	*/
	if(parseFloat(observedScore) > parseFloat(MaxScore)){	
		$("#"+fieldId).val("");
	      Toast.fire({
	          type: 'error',
	          title: 'Observed Score is greater then Maximum Score.'
	        })
	}else if(parseFloat(observedScore)<0){
		$("#"+fieldId).val("");
	      Toast.fire({
	          type: 'error',
	          title: 'Observed Score is less then 0 .'
	        })
	}
	
}


function fillFileNameInLabel(evt,obj){
	
	  var fileName = evt.target.files[0].name;
	  console.log(fileName);
	  var extension = fileName.substring(fileName.lastIndexOf(".") , fileName.length);
		fileName = fileName.substring(0 , fileName.lastIndexOf("."));
		fileName = replaceAllSpecialCharacter(fileName);	
		fileName=fileName.trim();
	  fileName = fileName+extension;	
//	  /debugger;
      //replace the "Choose a file" label
      $(obj).next('.custom-file-label').html(fileName);
}


function differnceBetweenDatesInDays(startDate,endDate){
	// fromat should be in YYYY-MM-DD
	
	endDate= moment(endDate);
	startDate= moment(startDate);
	
	var age=endDate.diff(startDate, 'days');
	age=parseInt(age);
	return age;
}

function calcBusinessDays(dDate1, dDate2) {

    var startDate = parseDate(dDate1);
    var endDate = parseDate(dDate2);

    if (endDate < startDate) {
        return 0;
    }

// Calculate days between dates
    var millisecondsPerDay = 86400 * 1000; // Day in milliseconds
    startDate.setHours(0, 0, 0, 1);  // Start just after midnight
    endDate.setHours(23, 59, 59, 999);  // End just before midnight
    var diff = endDate - startDate;  // Milliseconds between datetime objects    
    var days = Math.ceil(diff / millisecondsPerDay);

    console.log(" days1 >> "+days);
    // Subtract two weekend days for every week in between
/*    var weeks = Math.floor(days / 7);
    days -= weeks * 2;
    console.log(" days2 >> "+days);
    // Handle special cases
    var startDay = startDate.getDay();
    var endDay = endDate.getDay();

    // Remove weekend not previously removed.   
    if (startDay - endDay > 1) {
        days -= 2;
        console.log(" days3 >> "+days);
    }
    // Remove start day if span starts on Sunday but ends before Saturday
    if (startDay == 0 && endDay != 6) {
        days--;
        console.log(" days4 >> "+days);
    }
    // Remove end day if span ends on Saturday but starts after Sunday
    if (endDay == 6 && startDay != 0) {
        days--;
        console.log(" days6 >> "+days);
    }*/
    /* Here is the code */
    console.log("date diff >> " + days);
    return days;
}

function parseDate(input) {
    // Transform date from text to date
    var parts = input.match(/(\d+)/g);
    // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
    return new Date(parts[0], parts[1] - 1, parts[2]); // months are 0-based
}




/*End here */
