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
				new Note($.extend(data, { new: 1 }));
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
				// new Note(data);
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

	var get_other_folders = function() {

		var get_folders = function(callback) {
			
		};

		var x = get_folders( function(data) {
			return data;
		});
	};

	var move_note = function(id, new_folder_id) {


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

			var changeFolder = function(id, folder_id) {
				$.post("/folders/<%= @folder.id %>/move_folder", {
						note_id: id,
						new_folder_id: folder_id
					},
					function(data) {
					$("#dialog" + id).remove();
				});

			};

			var moveNote = function(id) {
				$.get("/folders/<%= @folder.id %>/get_other_folders", {}
					, function(data) {
						var len = data.length;

						var s = "<label> Folder name: </label>";
						s += "<select data-placeholder='Choose a folder...' id='folder-select' class='chzn-select'>";
						for (var i = 0; i < len; i++) {
							s += "<option value=" + data[i].id + ">" + data[i].name + "</option>";
						};
						s += "</select>";

						$("#dialog-select").append(s);
						//$("select").chosen();

						$("#dialog-select").dialog({
							modal: true,
							zIndex: 998,	
							width: 350,
							height: 200,
							buttons: {
								Move: function() {changeFolder(note_id, $("#folder-select").val()); $(this).dialog("close")},
								Cancel: function() {$(this).dialog("close");}
							},
							close: function() {
							$("#dialog-select").text("");
							}
						});
					}
				);

			};

			var viewMode = function() {
				note.attr('contenteditable', false);
				note.dialog("option", "buttons", [
					{text: "Move to", click: function() {moveNote(note_id);}},
					{text: "Edit", click: editMode }
				]);
			};

			var editMode = function() {
				note.attr('contenteditable', true).focus();
				note.dialog("option", "buttons", [
					{text: "Save", click: function() {edit_note($.extend({text: note.text()}, pos()));
					viewMode(); }},	
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
				height: spec.height,
				title: "Note " + spec.created_at
			});

			if (spec.new || note.prop('contenteditable') === true) {
				editMode();
			} else {
				viewMode();
			}
		}
	}
	process(spec);
};

</script>