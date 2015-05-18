(function() {
	$(document).on('change','[name=filterBy]',change)
	function change() {
		var filterBy = $(this).val()
		filterBy = parseInt(filterBy,10)
		if (filterBy) {
			$('#children').find('tr').addClass('hidden')
			$('#children').find('tr.' + filterBy).removeClass('hidden')
		} else {
			$('#children').find('.hidden').removeClass('hidden')
		}
	}
})();

