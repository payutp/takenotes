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

	var DEFAULT_WIDTH = 300;
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
});

</script>