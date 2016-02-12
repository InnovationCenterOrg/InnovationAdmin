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
					<div style="margin-top:10px;margin-bottom:90px;">
						<div class="col-md-4">
						</div>
						<div class="col-md-4">
							<h2 id="luckyRandom" align="center"></h2>
						</div>
						<div class="col-md-4">
						</div>
  					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="stopButton" onclick="startStop()">STOP</button>
					<button type="button" class="btn btn-primary" id="gotPrizeButton" onclick="gotPrize()">GOT PRIZE</button>
					<button type="button" class="btn btn-danger" id="noShowButton" onclick="noShow()">NO SHOW</button>
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
			    	 run = setInterval(runRandom, 10);
			    	return;
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
	if(stop){
		$('#stopButton').text("START");
		clearInterval(run);
		run = null;
	}else{
		$('#stopButton').text("STOP");
		run = setInterval(runRandom, 10);
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
		    });
}
</script>