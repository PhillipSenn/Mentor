<cfscript>
if (IsDefined('form.Save')) {
	storedproc datasource='Mentor'
		procedure='ki.[Merge]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.KeyName;
		procparam value=form.KeyDesc;
		procparam value=url.ParentID;
	}
	session.msg = 'Saved!'
}

storedproc datasource='Mentor'
	procedure='ki.[get]' {
	procparam value=session.Usr.UsrID;
	procparam value=url.ParentID;
	procresult resultset=1 name='Key';
}

request.navbar = false
</cfscript>

<cfoutput query="Key">
<cfinclude template="/Inc/header.cfm">
<form>
	<cfinclude template="/Inc/Save.cfm">
	<h1>#KeyName#</h1>
	<label for="KeyName">Keyword:</label>
	<input name="KeyName" autofocus>
	<label for="KeyDesc">Description:</label>
	<textarea name="KeyDesc"></textarea>
</form>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>