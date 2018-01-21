/* *********************************************** */
/* Keyboard Mapping                                */
/* *********************************************** */   

// The Key Map
//
// action property:
//    call:<method name>
//        -> Calls a method with form and formElement as parameters
//    click:<button name>
//        -> Simulates a button click on a particular key event
//
// evt property:        
//    <event>:<consume>
//        -> Specifies the key event that handles the action as well as the
//           event consume behavior
//           <event> is keydown, keyup, or keypress
//           <consume> is all, this, or fail where:
//               all   = Consume all key events
//               updown= Consume keyup and keydown only
//               this  = Consume only the event that causes the action to
//                       happen
//               fail =  Consume only the event that causes the action to
//                       fail (call:<method name> returned false)

var keyMap = [
{ keyCode:0x09, shift:false, ctrl:false, alt:false, evt:"keydown:fail",    action:"call:doTabForward",  enabled:true  }, // Tab to next field if there are no validation errors
{ keyCode:0x09, shift:true,  ctrl:false, alt:false, evt:"keydown:fail",    action:"call:doTabBackward", enabled:true  }, // Backtab to previous field if there are no validation errors
{ keyCode:0x0D, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_ENTER",    enabled:true  }, // Enter key
{ keyCode:0x24, shift:false, ctrl:true,  alt:false, evt:"keydown:this",    action:"call:doCursorHome",  enabled:true  }, // Ctrl Home (Cursor to the first input capable field if there are no validation errors)
{ keyCode:0x26, shift:false, ctrl:false, alt:false, evt:"keydown:this",    action:"call:doCursorUp",    enabled:true  }, // Cursor Up (Cursor to the input capable field above if there are no validation errors)
{ keyCode:0x28, shift:false, ctrl:false, alt:false, evt:"keydown:this",    action:"call:doCursorDown",  enabled:true  }, // Cursor Down (Cursor to the input capable field below if there are no validation errors)
{ keyCode:0x70, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF1",      enabled:true  }, // F1
{ keyCode:0x71, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF2",      enabled:true  }, // F2
{ keyCode:0x72, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF3",      enabled:true  }, // F3
{ keyCode:0x73, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF4",      enabled:true  }, // F4
{ keyCode:0x74, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF5",      enabled:true  }, // F5
{ keyCode:0x75, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF6",      enabled:true  }, // F6
{ keyCode:0x76, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF7",      enabled:true  }, // F7
{ keyCode:0x77, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF8",      enabled:true  }, // F8
{ keyCode:0x78, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF9",      enabled:true  }, // F9
{ keyCode:0x79, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF10",     enabled:true  }, // F10
{ keyCode:0x7A, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF11",     enabled:true  }, // F11
{ keyCode:0x7B, shift:false, ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF12",     enabled:true  }, // F12
{ keyCode:0x70, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF13",     enabled:true  }, // Shift F1
{ keyCode:0x71, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF14",     enabled:true  }, // Shift F2
{ keyCode:0x72, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF15",     enabled:true  }, // Shift F3
{ keyCode:0x73, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF16",     enabled:true  }, // Shift F4
{ keyCode:0x74, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF17",     enabled:true  }, // Shift F5
{ keyCode:0x75, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF18",     enabled:true  }, // Shift F6
{ keyCode:0x76, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF19",     enabled:true  }, // Shift F7
{ keyCode:0x77, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF20",     enabled:true  }, // Shift F8
{ keyCode:0x78, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF21",     enabled:true  }, // Shift F9
{ keyCode:0x79, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF22",     enabled:true  }, // Shift F10
{ keyCode:0x7A, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF23",     enabled:true  }, // Shift F11
{ keyCode:0x7B, shift:true,  ctrl:false, alt:false, evt:"keydown:updown",  action:"click:DFH_PF24",     enabled:true  }, // Shift F12
{ keyCode:0x70, shift:false, ctrl:true,  alt:false, evt:"keydown:updown",  action:"click:DFH_PA1",      enabled:true  }, // Ctrl F1
{ keyCode:0x71, shift:false, ctrl:true,  alt:false, evt:"keydown:updown",  action:"click:DFH_PA2",      enabled:true  }, // Ctrl F2
{ keyCode:0x72, shift:false, ctrl:true,  alt:false, evt:"keydown:updown",  action:"click:DFH_PA3",      enabled:true  }, // Ctrl F3
{ keyCode:0x43, shift:false, ctrl:true,  alt:false, evt:"keydown:updown",  action:"click:DFH_CLEAR",    enabled:true  }  // Ctrl C
];

var controlKeys = "\x00\x08\x09\x0d\x10\x11\x12\x13\x14\x1b\x21\x22\x23\x24\x25\x26\x27\x28\x2d\x2e\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x90\x91\xba";
