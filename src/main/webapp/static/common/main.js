
$(".checkAll").change(function(){
	if ($(this).prop("checked")) {
		$(".checkSub:not(:checked)").attr("checked", "checked");
	} else {
		$(".checkSub").removeAttr("checked");
	}
});

$(".checkSub").change(function(){
	if ($(".checkSub:not(:checked)").length == 0 && !$(".checkAll").prop("checked")) {
		$(".checkAll").attr("checked", "checked");
	}
	if ($(".checkSub:checked").length == 0 && $(".checkAll").prop("checked")) {
		$(".checkAll").removeAttr("checked");
	}
});