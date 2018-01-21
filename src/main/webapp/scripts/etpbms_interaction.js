/* *********************************************** */
/* Keyboard event and field interaction handler    */
/* *********************************************** */   

var DISABLE_ONHELP = true; // Trap and Disable IE onhelp (Allows F1 to be custom mapped)
var CELL_WIDTH=13.33; // Based on DPI=96 and CPI=7.2
var CELL_HEIGHT=1.7*(CELL_WIDTH/0.6);
var CURR_VALUE; // Value of current input field

// 
// Add event listeners
//
if (document.addEventListener)
{
    document.addEventListener('keydown', handleKeyDown, false);   
    document.addEventListener('keypress', handleKeyPress, false);
    document.addEventListener('keyup', handleKeyUp, false);         
}
else
{        
    if(document.captureEvents)
    {
       if(Event.KEYDOWN && Event.KEYPRESS && Event.KEYUP)
       {
          //NS 4, NS 6+, Mozilla 0.9+
          document.captureEvents(Event.KEYDOWN | Event.KEYPRESS | Event.KEYUP);
       }
    }
          
    // Register event handler for IE
    document.onkeydown = handleKeyDown;
    document.onkeypress = handleKeyPress;
    document.onkeyup = handleKeyUp;      
    document.onhelp = function() { return !DISABLE_ONHELP; };
}
// 
// End of add event listeners
//

function doClickAction(curForm, elementName) 
{
    var elementIndex=getElementIndex(curForm,elementName);
    if (elementIndex>=0)
    {
       curForm.elements[elementIndex].click();
       return true;
    }

    return false;
}

function doTabForward(curForm,curElement)
{
    return validateField(curElement);
}

function doTabBackward(curForm,curElement)
{
    return validateField(curElement);   
}

function doCursorHome(curForm,curElement)
{
    if (!validateField(curElement)) return false;
    focusOnEditableFieldIndex(curForm, 0);
    return false;   
}

function doCursorUp(curForm,curElement)
{
    if (!validateField(curElement)) return false;

    var sourceIndex=getElementIndex(curForm,curElement.name);

    var bottom=findOffsetTop(curElement)+CELL_HEIGHT;
    var cursorLoc=findOffsetLeft(curElement);

    if (typeof(curElement.selectionStart)!='undefined')
    {
       var offset=(curElement.selectionEnd+curElement.selectionStart)/2;
       cursorLoc+=(offset*CELL_WIDTH);
    }
    else if ((typeof(document.selection)!='undefined') && document.selection.createRange)
    {
       var offset=-document.selection.createRange().move("character",-0x7FFFFFFF);
       cursorLoc+=(offset*CELL_WIDTH);
    }

    var curLeft, curWidth, curBottom, dist, deltax, deltay;

    var shortestDistanceIndex=-1;      
    var shortestDistance=0x7fffffff;

    var scaleY=CELL_HEIGHT;
    var scaleX=CELL_WIDTH;      
    
    while (sourceIndex>0)
    {
       sourceIndex--;

       curElement=curForm.elements[sourceIndex];
       if (!isEditableTextField(curElement)) continue;

       curBottom=findOffsetTop(curElement)+CELL_HEIGHT;
       if (curBottom>=bottom) continue;
       
       curLeft=findOffsetLeft(curElement);
       curWidth=findOffsetWidth(curElement);
 
       deltay=(bottom-curBottom)*scaleY;

       deltax=((curLeft+curWidth)-cursorLoc)*scaleX;
       dist=Math.sqrt(deltax*deltax+deltay*deltay);
       if (dist<shortestDistance) 
       {
          shortestDistance=dist;
          shortestDistanceIndex=sourceIndex;
       }
       
       deltax=(curLeft-cursorLoc)*scaleX;
       dist=Math.sqrt(deltax*deltax+deltay*deltay);
       if (dist<shortestDistance) 
       {
          shortestDistance=dist;
          shortestDistanceIndex=sourceIndex;
       }
    }
    
    if (shortestDistanceIndex>=0)
    {
       focusOnEditableFieldIndex(curForm, shortestDistanceIndex);
       return true;
    }
    
    return false;   
}

function doCursorDown(curForm,curElement)
{
    if (!validateField(curElement)) return false;

    var sourceIndex=getElementIndex(curForm,curElement.name);

    var top=findOffsetTop(curElement);
    var cursorLoc=findOffsetLeft(curElement);

    if (typeof(curElement.selectionStart)!='undefined')
    {
       var offset=(curElement.selectionEnd+curElement.selectionStart)/2;
       cursorLoc+=(offset*CELL_WIDTH);
    }
    else if ((typeof(document.selection)!='undefined') && document.selection.createRange)
    {
       var offset=-document.selection.createRange().move("character",-0x7FFFFFFF);
       cursorLoc+=(offset*CELL_WIDTH);
    }
    
    var curLeft, curWidth, curTop, dist, deltax, deltay;

    var shortestDistanceIndex=-1;      
    var shortestDistance=0x7fffffff;

    var scaleY=CELL_HEIGHT;
    var scaleX=CELL_WIDTH;

    var max=curForm.elements.length-1;
    while (sourceIndex<max)
    {
       sourceIndex++;

       curElement=curForm.elements[sourceIndex];
       if (!isEditableTextField(curElement)) continue;

       curTop=findOffsetTop(curElement);
       if (curTop<=top) continue;
       
       curLeft=findOffsetLeft(curElement);
       curWidth=findOffsetWidth(curElement);
 
       deltay=(top-curTop)*scaleY;

       deltax=((curLeft+curWidth)-cursorLoc)*scaleX;
       dist=Math.sqrt(deltax*deltax+deltay*deltay);
       if (dist<shortestDistance) 
       {
          shortestDistance=dist;
          shortestDistanceIndex=sourceIndex;
       }
       
       deltax=(curLeft-cursorLoc)*scaleX;
       dist=Math.sqrt(deltax*deltax+deltay*deltay);
       if (dist<shortestDistance) 
       {
          shortestDistance=dist;
          shortestDistanceIndex=sourceIndex;
       }
    }
    
    if (shortestDistanceIndex>=0)
    {
       focusOnEditableFieldIndex(curForm, shortestDistanceIndex);
       return true;
    }

    return false;   
}

var justAutoTabbed = true; // Flag to prevent more than one autotab at a time
function handleAutoTab(sourceForm,sourceElement)
{
    // Auto tab to next field if conditions are met
    if (typeof(sourceElement.maxLength)=='number')
    {
       if (sourceElement.value.length >= sourceElement.maxLength) 
       {
          if (typeof(sourceElement.selectionStart)!='undefined')
          {
              if ((sourceElement.selectionStart!=sourceElement.selectionEnd)||(sourceElement.selectionEnd!=sourceElement.maxLength)) return;
          }
          else if ((typeof(document.selection)!='undefined') && document.selection.createRange)
          {
              if (-document.selection.createRange().move("character",-0x7FFFFFFF)!=sourceElement.maxLength) return;
          }
          
          var sourceIndex=getElementIndex(sourceForm,sourceElement.name);
          focusOnEditableFieldIndex(sourceForm, sourceIndex+1);
          justAutoTabbed = true;
       }
    }
}

function isPrintable(keyChar)
{
    return (keyChar >= '\u0020' && keyChar <= '\u007e');
}

function disableEventPropagation(evt,keyCodeIsReadOnly)
{
    if (!keyCodeIsReadOnly) evt.keyCode = 0;
    if (typeof(evt.returnValue)=='boolean') evt.returnValue = false;
    if (typeof(evt.cancelBubble)=='boolean') evt.cancelBubble = true;
    if (evt.preventDefault) evt.preventDefault();                        
    if (evt.stopPropagation) evt.stopPropagation();                                        
}

function getKeyMapIndex(keyCode, shift, ctrl, alt) 
{
    for (var i = 0; i < keyMap.length; i++)
    {
       if ((keyMap[i].keyCode==keyCode) && (keyMap[i].enabled))
       {
          if ((keyMap[i].shift==shift)&&(keyMap[i].ctrl==ctrl)&&(keyMap[i].alt==alt))
              return i;
       }
    }
    return -1;
}

function handleKeyEvent(evtType, evt)
{
    var shift=false;            
    var ctrl=false;
    var alt=false;        
       
    if (!evt)
    {
       evt=window.event;
       if (!evt) return true; // Could not get the event!
    }
    
    if (evt.modifiers) 
    { 
       shift=((evt.modifiers & Event.SHIFT_MASK)==Event.SHIFT_MASK); 
       ctrl=((evt.modifiers & Event.CTRL_MASK)==Event.CTRL_MASK);
       alt=((evt.modifiers & Event.ALT_MASK)==Event.ALT_MASK);          
    }
    
    if (evt.shiftKey) shift=evt.shiftKey;
    if (evt.ctrlKey) ctrl=evt.ctrlKey;
    if (evt.altKey) alt=evt.altKey;
    
    var keyCode=0;
    var keyCodeIsReadOnly=false;
    
    if(typeof(evt.which)=='number')
    {
       //NS 4, NS 6+, Mozilla 0.9+, Opera
       keyCode=evt.which;
       keyCodeIsReadOnly=true;         
    }
    if(typeof(evt.keyCode)=='number')
    {
       //IE, NS 6+, Mozilla 0.9+
       keyCode=evt.keyCode;
    }
 
    var sourceElement;
    if (evt.target) 
       sourceElement=evt.target;
    else if (evt.srcElement)
       sourceElement=window.event.srcElement;
    else
       return true; // we don't know where the event came from!
 
    var sourceForm=sourceElement.form;
    if (typeof(sourceForm)=='undefined')
    {
       if(document.forms.length > 0)
          sourceForm = document.forms[0]; // Use first form in document
       else
          return true;
    }
 
    // var msg="Event type: "+evtType+String.fromCharCode(keyCode)+" (Key code: "+keyCode+"), shift="+shift+", ctrl="+ctrl+", alt="+alt+", sourceForm="+sourceForm.name+", sourceElement="+sourceElement.name;
    // window.status = msg;
    
    var keyMapIndex=getKeyMapIndex(keyCode,shift,ctrl,alt);
    if (keyMapIndex<0)
    {
       if (evtType=="keydown")
       {
          var keyChar = String.fromCharCode(keyCode);
          if (controlKeys.indexOf(keyChar)>=0) return true;
          
          if (!isPrintable(keyChar))
             return true;

          if (!isEditableTextField(sourceElement)) return true;

          handleAutoTab(sourceForm,sourceElement);
          
          return true;
       }
       else if (evtType=="keypress")
       {
          return true;
       }
       else // keyup
       {
          if (justAutoTabbed) { justAutoTabbed=false; return true; }

          var keyChar = String.fromCharCode(keyCode);
          if (controlKeys.indexOf(keyChar)>=0) return true;
                      
          if (!isPrintable(keyChar))
             return true;

          if (!isEditableTextField(sourceElement)) return true;

          handleAutoTab(sourceForm,sourceElement);

          return true;
       }
    }

    var action=keyMap[keyMapIndex].action;
    var index=action.indexOf(':');
    if (index<0) return true; // do nothing
    
    var actionKey=action.substring(0,index);
    var actionValue=action.substring(index+1);

    var actionEventType=keyMap[keyMapIndex].evt;
    var consumeBehavior="fail";
          
    index=actionEventType.indexOf(':');
    if (index>=0)
    {
       consumeBehavior=actionEventType.substring(index+1);
       actionEventType=actionEventType.substring(0,index);
    }

    var eventTypeMatches=(evtType==actionEventType);

    var result=true;
    if ( consumeBehavior=="all" || (eventTypeMatches && consumeBehavior=="this") || (consumeBehavior=="updown" && (evtType=="keyup" || evtType=="keydown")))
    {
       disableEventPropagation(evt,keyCodeIsReadOnly);
       result=false;
    }

    if (!eventTypeMatches) return result;

    if (actionKey=="click")
    {
       if (!doClickAction(sourceForm,actionValue) && result && consumeBehavior=="fail")
       {
          disableEventPropagation(evt,keyCodeIsReadOnly);
          result=false;
       }
    }
    else if (actionKey=="call")
    {
       if (!window[actionValue](sourceForm,sourceElement) && result && consumeBehavior=="fail")
       {
          disableEventPropagation(evt,keyCodeIsReadOnly);
          result=false;
       }
    }
    
    return result;
} 

function handleKeyDown(evt)
{
    return handleKeyEvent("keydown",evt);
}

function handleKeyPress(evt)
{
    return handleKeyEvent("keypress",evt);
}

function handleKeyUp(evt)
{
    return handleKeyEvent("keyup",evt);
}

function findOffsetLeft(curElement)
{
    var curLeft = 0;
    if (curElement.offsetParent)
    {
       while (curElement.offsetParent)
       {
          curLeft+=curElement.offsetLeft;
          curElement=curElement.offsetParent;
       }
    }
    else if (curElement.x)
    {
       curLeft+=curElement.x;
    }

    return curLeft;
}

function findOffsetWidth(curElement)
{
    if (curElement.offsetWidth)
       return curElement.offsetWidth;
    else if (curElement.width) 
       return curElement.width;

    return 0;
}

function findOffsetTop(curElement)
{
    var curTop = 0;
    if (curElement.offsetParent)
    {
       while (curElement.offsetParent)
       {
          curTop+=curElement.offsetTop;
          curElement=curElement.offsetParent;
       }
    }
    else if (curElement.y)
    {
       curTop+=curElement.y;
    }

    return curTop;
}

function isEditableTextField(curElement)
{
    return ((curElement.type != "hidden") && (curElement.type == "text" || curElement.type == "password"));
}

function getElementIndex(curForm, elementName)
{
    var len=curForm.elements.length;
    for (var elementIndex=0; elementIndex<len; elementIndex++)
    {
       if (curForm.elements[elementIndex].name == elementName)
          return elementIndex;
    }
    
    return -1;
}

function focusOnEditableFieldIndex(curForm, elementIndex)
{
    var curElement;
    
    // If the element at elementIndex is not an editable field,
    // advance until we find an editable field
    for (var i=elementIndex; i<curForm.elements.length; i++) 
    {
       curElement=curForm.elements[i];
       if (isEditableTextField(curElement)) 
       {
          curElement.focus();
          curElement.select();
          setCurrentField(curElement);
          return true;
       }
    }
    
    // We have reached the end of the editable fields in the form,
    // so we must wrap around to the first element of the form
    for (var i=0; i<elementIndex; i++) 
    {
       curElement=curForm.elements[i];
       if (isEditableTextField(curElement)) 
       {
          curElement.focus();
          curElement.select();
          setCurrentField(curElement);
          return true;
       }
    }
    return false;
}

function focusOnEditableField(fieldName)
{
    CURR_VALUE=fieldName.value
    if ((typeof(fieldName)=="string")&&(document.forms.length > 0))
    {
       for (var formIndex=0; formIndex<document.forms.length; formIndex++)
       {
          curForm=document.forms[formIndex];
          elementIndex=getElementIndex(curForm,fieldName);
          if (elementIndex>=0) return focusOnEditableFieldIndex(curForm, elementIndex);
       }
    }
    return false;
}

function hasClass(field,className)
{
    if ((typeof(field.className)=="string") && (field.className.indexOf(className)>=0))
       return true;
    return false;
}

function setCurrentField(field)
{
    if (!CURR_VALUE)
        CURR_VALUE=field.value
    // Make sure it is a map field
    if (!hasClass(field,"mapfield")) return;

    // Find the cursor field and update its value to the field name if found
    var elementIndex=getElementIndex(field.form,"DFH_CURSOR");
    if (elementIndex>=0) field.form.elements[elementIndex].value=field.name;
}

function checkCurrentField(field)
{
    // If field has been blanked by mask, restore original value...
    if (!field.value)
        field.value=CURR_VALUE
    CURR_VALUE=''
}

function validateField(field)
{
    // Add field validation code here
    // Note, this is redundant if using the validation framework via BMS
    return true;
}

function isloadingOverlay( event ){
	//don't show overlay if a submit is already in progress
	if( !isLoading ){
		isLoading = true;
		$("input").prop("readonly", true);
		$.isLoading({ text: "Loading" });
	}
}

function allowSubmit(){
	return !isLoading;
}