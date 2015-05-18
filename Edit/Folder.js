(function() {
	var Variables = {}
	
	$(document).on('change','[name=newFolderName]',change)
	function change() {
		var local = {}
		local.url = 'newFolder.cfm'
		local.type = 'post'
		local.dataType = 'json'
		local.data = {}
		local.data.FolderName = $(this).val()
		local.data.ParentID = $('[name=FolderID]').val() // getURL('FolderID')
		local.context = this;
		result = $.ajax(local)
		result.fail(dom.fail)
		result.done(done)
	}
	function done(response) {
		var td1 = '<td><span class="glyphicon glyphicon-folder-close"></span></td>'
		var td2 = '<td><a href="Folder.cfm?FolderID=' + response.DATA[0][0] + '">' + $(this).val() + '</a></td>'
		$(this).closest('table').find('tbody').append('<tr>' + td1 + td2 + '</tr>')
		$(this).val('')
	}
})()