$(document).on('click','#HTMLTab',HTMLTabClicked)
function HTMLTabClicked() {
	$('[name=HTML]').focus()
}
$(document).on('click','#CSSTab',CSSTabClicked)
function CSSTabClicked() {
	$('[name=CSS]').focus()
}
$(document).on('click','#JavaScriptTab',JavaScriptTabClicked)
function JavaScriptTabClicked() {
	$('[name=JavaScript]').focus()
}
$(document).on('click','#SQLTab',SQLTabClicked)
function SQLTabClicked() {
	$('[name=SQL]').focus()
}
$(document).on('click','#CFScriptTab',CFScriptTabClicked)
function CFScriptTabClicked() {
	$('[name=CFScript]').focus()
}

$(document).on('click','.paste',pasteClicked)
function pasteClicked() {
	var PasteValue = $(this).closest('.tab-pane').find('.pasteValue').html()
	PasteValue = PasteValue.replace('<!-- cfloop -->','<cfloop query="State">')
	PasteValue = PasteValue.replace('<!-- /cfloop -->','</cfloop>')
	PasteValue = PasteValue.replace(/\t/g,'   ')
	$(this).closest('.row').find('textarea').val(PasteValue)
}
