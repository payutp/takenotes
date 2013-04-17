<script type="text/javascript">

$(function() {

	// get all notes for a specified folder and add them
	var url = '/folders/<%= @folder.id %>/get_notes';
	var data = {};
	$.get(url, data, function(data) {
		var len = data.length;
		for (var i = 0; i < len; i++) {
			new Note(data[i]);
		}
	});

	var DEFAULT_WIDTH = 360;
	var DEFAULT_HEIGHT = 300;

	// method for creating a new note
	$("#new-note").click(function() {
		var spec = {
			id: 0,
			text: "",
			x: $(window).width()/2 - DEFAULT_WIDTH/2,
			y: $(window).height()/2 - DEFAULT_HEIGHT/2,
			width: DEFAULT_WIDTH,
			height: DEFAULT_HEIGHT
		};
		new Note(spec);

	}).button();

	$("#delete-folder").click(function() {
		$('<div></div>').appendTo('body')
      .html('<div><h6>Are you sure?</h6></div>')
        .dialog({
          modal: true, title: 'Delete <%= @folder.name %>', zIndex: 10000, autoOpen: true,
          width: 200, resizable: false,
          buttons: {
            Yes: function () {
							$.post(
								"/folders/<%= @folder.id %>/delete", {
																			
								}, function(data) {
								if (data.status === "Default") {
									alert("Can't delete default folder!");
								} else {									
									window.location.replace("/folders");              
								}
								});

								$(this).dialog("close");
            },
              No: function () {
                $(this).dialog("close");
              }
            },
            close: function (event, ui) {
              $(this).remove();
            }
            });					

	}).button();

	$("#back").click(function() {
		window.location.replace("/folders");
	}).button();

});
// confirmation box from http://stackoverflow.com/questions/3519861/yes-or-no-confirm-box-using-jquery
</script>

