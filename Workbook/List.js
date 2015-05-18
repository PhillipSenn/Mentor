Options = {}
Options.stop = function(myEvent, myUI) {
	keySort = 0
	$(this).closest('tbody').find('tr').each(updateKeySort);
}
function updateKeySort() {
	keySort += 1
	var local = {}
	local.url = 'UpdateKeySort.cfm'
	local.type = 'post'
//	local.dataType = 'json'
	local.data = {}
	local.data.KeyID = $(this).data('keyid')
	local.data.KeySort = keySort
	result = $.ajax(local)
	result.fail(dom.fail)
//	result.done(done)
}
/*
function done(response) {
	debugger
}
*/
$('#children tbody').sortable(Options)
