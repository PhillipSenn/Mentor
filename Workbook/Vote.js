(function() {
	$(document).on('click','.vote',vote)
	function vote() {
		var local = {}
		local.url = 'VoteAjax.cfm'
		local.type = 'post'
//		local.dataType = 'json'
		local.data = {}
		local.data.KeyID	= $(this).data('keyid')
		local.data.ChadID = $(this).data('chadid')
		local.context = this
		result = $.ajax(local)
		result.fail(dom.fail)
		result.done(done)
	}
	function done() {
		$(this).parent().find('.btn-primary').removeClass('btn-primary').addClass('btn-default')
		$(this).addClass('btn-primary')
	}
})()