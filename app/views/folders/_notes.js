<script type="text/javascript">

var Note = function(spec) {

	var thisNote = this;

	var note_id = spec.id;

	var create_note = function(spec) {
		$.post(
			"/folders/<%= @folder.id %>/create_note", {
				text: spec.text,
				x: spec.x,
				y: spec.y,
				width: spec.width,
				height: spec.height
			},
			function(data){
				new Note(data);
			}
		);
	};

	var edit_note = function(spec) {
		$.post(
			"/folders/<%= @folder.id %>/edit_note", {
				text: spec.text,
				x: spec.x,
				y: spec.y,
				width: spec.width,
				height: spec.height,
				note_id: note_id
			},
			function(data){
				new Note(data);
			}
		);
	};

	var delete_note = function() {
		$.post(
			"/folders/<%= @folder.id %>/delete_note", {
				note_id: note_id
			},
			function(data){

			}
		);
	};


	var process = function(spec) {

		if (note_id === 0) {
			create_note(spec);
		} else {

			if ($("#dialog" + note_id).length === 0) {
				$(".note").append("<div id='dialog" + note_id + "'>" + spec.text + "</div>");
			}
			var note = $('#dialog' + note_id);

			var pos = function() {
				return {
					x: note.dialog("option", "position")[0],
					y: note.dialog("option", "position")[1],
					width: note.dialog("option", "width"),
					height: note.dialog("option", "height")
				}
			};

			var viewMode = function() {
				note.attr('contenteditable', false);
				note.dialog("option", "buttons", [
					{text: "Edit", click: editMode }
				]);
			};

			var editMode = function() {
				note.attr('contenteditable', true).focus();
				note.dialog("option", "buttons", [
					{text: "Submit", click: function() {edit_note($.extend({text: note.text()}, pos())); }},	
					{text: "Cancel", click: viewMode }
				]);
			};

			note.dialog({
				dragStop: function(event, ui) {
					edit_note($.extend({text: note.text()}, pos()));
				},
				resizeStop: function(event, ui) {
					edit_note($.extend({text: note.text()}, pos()));
				},
				beforeClose: function(event, ui) {
					event.preventDefault();
					if (window.confirm("Are you sure?")) {
						note.dialog("destroy");
						delete_note();
					}
				},
				position: [spec.x, spec.y],
				width: spec.width,
				height: spec.height
			});

			viewMode();
		}
	}
	process(spec);
};

</script>