/* validateDate
 * 
 * This function uses the function 'checkDate' to check if a date is
 * valid, otherwise it will invoke a modal dialog.
 * 
 * jQuery:
 *     bootstrap.js (for modal), http://getbootstrap.com/javascript/
 * 
 * Arguments:
 *     dateField: HTML id of field name
 *     separator: date format separator; e.g. '-', '/', ...
 */
function validateDate(dateField, separator) {
    var date=document.getElementById(dateField).value
    if (date=='' || isNaN(date.charAt(0)))
        return
    if (checkDate(date, separator)==false) {
        var elementId='validateDate_'+dateField
        if (document.getElementById(elementId)) {
            var focusField='#'+dateField
            $('#'+elementId).keydown(function(event) {
                if(event.keyCode == 13) { // prevent ENTER from closing modal
                  event.preventDefault()
                  return false
                }
            })                            // %V substitution
            var message=$('#modal-body_'+dateField).text()
            message=message.replace('%V',date)
            $('#modal-body_'+dateField).text(message)
            $('#'+elementId).modal()
            $('#'+elementId).on('hidden.bs.modal', function () {
                                          // wait for modal to terminate...
                $(focusField).focus()     // ...and then set focus to field...
                $('#'+elementId).off()    // ...and then remove all handlers.
                message=message.replace(date,'%V')
                $('#modal-body_'+dateField).text(message)
            })                            // on error, clear field value
            document.getElementById(dateField).value=''
            CURR_VALUE=''
        }
        else {
            alert("INVALID DATE DETECTED. PLEASE RE-ENTER.\n\nMODAL NOT FOUND.")
        }
    }
    return false
}

function checkDate(input, separator) {
    var monthfield=input.split(separator)[0]
    var dayfield=input.split(separator)[1]
    var yearfield=input.split(separator)[2]
    var dayobj = new Date(yearfield, monthfield-1, dayfield)
    if ((dayobj.getMonth()+1!=monthfield)||(dayobj.getDate()!=dayfield)||(dayobj.getFullYear()!=yearfield))
        return false
    else
        return true
}

/* validateState
 * 
 * This function checks if the input is a valid state code. If not, a modal
 * dialog is displayed.
 * 
 * jQuery:
 *     bootstrap.js (for modal), http://getbootstrap.com/javascript/
 * 
 * Arguments:
 *     stateField: HTML id of field name
 */
function validateState(stateField) {
    var state=document.getElementById(stateField).value.trim()
    var states=["AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE",
                "FL","GA","GU","HI","IA","ID","IL","IN","KS","KY",
                "LA","MA","MD","ME","MH","MI","MN","MO","MS","MT",
                "NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK",
                "OR","PA","PR","PW","RI","SC","SD","TN","TX","UT",
                "VA","VI","VT","WA","WI","WV","WY"]
    if (state=='')
        return
    for(var i=0;i<states.length;i++) {
        if(state==states[i]) {
            return true
        }
    }
    var elementId='validateState_'+stateField
    if (document.getElementById(elementId)) {
        var focusField='#'+stateField
        $('#'+elementId).keydown(function(event) {
            if(event.keyCode == 13) {     // prevent ENTER from closing modal
              event.preventDefault()
              return false
            }
        })                                // %V substitution
        var message=$('#modal-body_'+stateField).text()
        message=message.replace('%V',state)
        $('#modal-body_'+stateField).text(message)
        $('#'+elementId).modal()
        $('#'+elementId).on('hidden.bs.modal', function () {
                                          // wait for modal to terminate...
            $(focusField).focus()         // ...and then set focus to field...
            $('#validateState').off()     // ...and then remove all handlers.
            message=message.replace(state,'%V')
            $('#modal-body_'+stateField).text(message)
        })                                // on error, clear field value
        document.getElementById(stateField).value=''
        CURR_VALUE=''
    }
    else {
        alert("INVALID STATE DETECTED. PLEASE RE-ENTER.\n\nMODAL NOT FOUND")
    }
    return false
}

/* validateRange
 * 
 * This function checks if the input is a numeric within a specified range.
 * If not, a modal dialog is displayed.
 * 
 * jQuery:
 *     bootstrap.js (for modal), http://getbootstrap.com/javascript/
 *     
 * Arguments:
 *     field: HTML id of field name
 *     min: minimum value of range
 *     max: maximum value of range
 */
function validateRange(field, min, max) {
    var value=document.getElementById(field).value
    if (value=='' || (!isNaN(value) && value >= min && value <= max))
        return
    var elementId='validateRange_'+field
    if (document.getElementById(elementId)) {
        var focusField='#'+field
        $('#'+elementId).keydown(function(event) {
            if(event.keyCode == 13) {  // prevent ENTER from closing modal
              event.preventDefault()
              return false
            }
        })                             // %V substitution
        var message=$('#modal-body_'+field).text()
        message=message.replace('%V',value)
        $('#modal-body_'+field).text(message)
        $('#'+elementId).modal()
        $('#'+elementId).on('hidden.bs.modal', function () {
                                       // wait for modal to terminate...
            $(focusField).focus()      // ...and then set focus to field...
            $('#'+elementId).off()     // ...and then remove all handlers.
            message=message.replace(value,'%V')
            $('#modal-body_'+field).text(message)
        })                             // on error, clear field value
        document.getElementById(field).value=''
        CURR_VALUE=''
    }
    else {
        alert("INVALID RANGE DETECTED. PLEASE RE-ENTER.\n\nMODAL NOT FOUND.")
    }
    return false
}

/* getFmask
 * 
 * This function provides a Fixed mask for a field.
 * 
 * jQuery:
 *     maskedinput.js, http://digitalbush.com/projects/masked-input-plugin/
 * 
 * Arguments:
 *     field: HTML id of field name
 *     mask: specification of the mask; e.g. a date might look like '99/99/9999'
 *     customMask: used to extend available mask types; e.g. mask of '~9' and
 *         customMask of '[0-2]', will permit only value of < 3 for the first digit
 *     placeholder: can be used to pre-fill a field with required format; this does
 *         not change the value of the field; e.g 'MM/DD/YYYY' for a date field
 */
function getFmask(field, mask, customMask, placeholder) {
    if (mask=='')
        return
    jQuery(function($) {
        if (customMask!='') {
            $.mask.definitions['~']=customMask
        }
        $('#'+field).mask(mask,{placeholder:placeholder})
    } )
}  

/* getNmask
 * 
 * This function provides a Numeric mask for a field.
 * 
 * jQuery:
 *     autonumeric.js, http://www.decorplanit.com/plugin/
 * 
 * Arguments:
 *     field: HTML id of field name
 *     aSep: the thousand separator; e.g. ',', '.', ':', ...
 *     lZero: leading zeros behavior
 *     vMin: minimum value of field (NOT a range)
 *     vMax: maximum value of field (NOT a range)
 */
function getNmask(field, aSep, lZero, vMin, vMax) {
    jQuery ( function($) { 
        $('#'+field).autoNumeric('init',{aSep:aSep,lZero:lZero,vMin:vMin,vMax:vMax})
    })
}