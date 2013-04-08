$(function() {
	$(".dialog").dialog();

	$(".new").click(function() {
		$(".note").append("<div class='dialog' contenteditable='true'> </div>")
		$(".dialog").dialog();
	});

	$(".dialog").keyup(function() {
		alert("dkd");
	});
});