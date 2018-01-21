var socket;
var new_uri;
var termId;
var contextRoot;
//$(document).ready(init);

function init() {
	isloadingOverlay();
	var loc = window.location;
	var pathArray = loc.pathname.split( '/' );
	
	if (loc.protocol === "https:") {
	    new_uri = "wss:";
	} else {
	    new_uri = "ws:";
	}
	new_uri += "//" + loc.host;
	contextRoot = pathArray[1];
	new_uri += "/" + contextRoot;
	new_uri += "/terminalwebsocket";
	
	connect();
}

function connect(){
	try{
		socket = new WebSocket(new_uri);

        socket.onopen = function(){
        	socket.send(termId);
        }

        socket.onmessage = function(event){
        	socket.close();
        	// similar behavior as an HTTP redirect
        	window.location.replace("/" + contextRoot + event.data);
        }
        socket.onclose = function(){
       		 //message('<p class="event">Socket Status: '+socket.readyState+' (Closed)');
        }			

    } catch(exception){
    	console.log(exception);
    }
}
