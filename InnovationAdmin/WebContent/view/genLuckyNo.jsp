<div class="modal fade" id="luckyDrawModal" tabindex="-1" role="dialog"
	aria-labelledby="ModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close" id="btn-close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="ModalLabel">Lucky Draw</h4>
			</div>
				<div class="modal-body">
					<div style="margin-top:100px;margin-bottom:500px;">
						<div class="col-md-2">
						</div>
						<div class="col-md-8">
							<h1 id="luckyRandom" align="center" style="font-size: 15em;"></h1>
						</div>
						<div class="col-md-2">
						</div>
  					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="stopButton" onclick="startStop()">STOP</button>
					<button type="button" class="btn btn-primary" id="gotPrizeButton" onclick="gotPrize()" disabled>GOT PRIZE</button>
					<button type="button" class="btn btn-danger" id="noShowButton" onclick="noShow()" disabled>NO SHOW</button>
				</div>
		</div>
	</div>
</div>

<script type="text/javascript">

var stop = false;
var status = null;
var i= 0;
var luckyList = null;
var run = null;
var eventId = null;

$('#luckyDrawModal').on('show.bs.modal', function(e) {
	
	var button = $(e.relatedTarget) // Button that triggered the modal
	eventId = button.data('event-id');
	// reteive ree
	getLucky();
});

$('#luckyDrawModal').on('hidden.bs.modal', function () {
	clearInterval(run);
	run = null;
	$('#luckyRandom').text('');
})

function getLucky(){
	$.post("${pageContext.request.contextPath}/EventMainAction",
		    {
		        actionType : "getLuckyList",
		        eventId : eventId
		    },
		    function(data){
		    	console.log(data);
		        luckyList = data;
		     // run number
			     if(luckyList.length > 0){
			    	 stop = true;
			    	 document.getElementById("luckyRandom").setAttribute("style", "font-size: 15em;");
			    	 startStop();
			    	 return;
			     }else{
			    	 stop = false;
			    	 document.getElementById("luckyRandom").setAttribute("style", "font-size: 5em;");
			 		 $('#luckyRandom').text('Not have lucky draw.');
			 		 $('#stopButton').disabled = true;	
			 		 $('#gotPrizeButton').disabled = true;	
			 		 $('#noShowButton').disabled = true;	
			     }
			     
		    });
}

function gotPrize(){
	status = 'Y';
	console.log(i);
	postForm(i);
}

function noShow(){
	status = 'N';
	console.log(i);
	postForm(i);
}

function startStop(){
	stop = !stop;
	console.log("Stop = "+stop);
	if(luckyList.length > 0){
		document.getElementById("stopButton").removeAttribute("disabled");
		if(stop){
			$('#stopButton').text("START");
			document.getElementById("gotPrizeButton").removeAttribute("disabled");
			document.getElementById("noShowButton").removeAttribute("disabled");
			clearInterval(run);
			run = null;
		}else{
			$('#stopButton').text("STOP");
			document.getElementById("gotPrizeButton").setAttribute("disabled", "disabled");
			document.getElementById("noShowButton").setAttribute("disabled", "disabled");
			run = setInterval(runRandom, 100);
		}
	}
}

function runRandom(){
	i++;
	if(i >= luckyList.length ){
		i = 0;
	}
	$('#luckyRandom').text(luckyList[i].reeLuckyNo);
	
}

function postForm(i){

	$.post("${pageContext.request.contextPath}/EventMainAction",
		    {
		        actionType : "LuckyDraw",
		        reeId : luckyList[i].reeId,
		        status : status
		    },
		    function(data){
		        console.log(data);
		        luckyList.splice(i, 1);
		        alert('This lucky number is saved successful.');
		    });
}
</script>