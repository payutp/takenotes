<script type="text/javascript">

$(function() {

	// dialog for a new folder
	var noteDialog = function() {
		$("#new-dialog").dialog({
			buttons: [{ text: "Create", click: function() {
									t = $(this).text();
									if (!t || t.length === 0 || t === " ") {
										alert("Please specify a name!");
									} else {
										create($(this).text());
										$(this).text("");
										$(this).dialog("close");
									}}},
								{ text: "Cancel", click: function() { $(this).dialog("close"); }} ],
			width: 400,
			height: 200,
			title: "Please enter folder name:",
			modal: true,
		});
		
		$("#new-dialog").attr('contenteditable', true).focus();	
	};

	// send new folder request to server
	var create = function(text) {
			$.post(
			"/folders/", {
				name: text
			}, function(data) {
				if (data.status === "duplicated") {
					alert("Duplicated name!")
				} else {
					$("#menu-container ul").append('<li><a href=' + '/folders/' + data.id + '>' + data.name + '</a></li>');
					$("#menu").menu("refresh");
				}
			}
			);
		};

	$("#new-folder").click(function() {noteDialog();}).button();
	$("#menu").menu();
});

</script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/ui-lightness/jquery-ui.css" />