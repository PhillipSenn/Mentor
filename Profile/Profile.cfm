<cfscript>
if (IsDefined('form.Save')) {
	storedproc
		procedure='Usr.[Update]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.UsrName; 
		procparam value=form.FirstName; 
		procparam value=form.Email; 
		procparam value=form.UsrPass; 
		procparam value=form.FolderID; 
		procresult resultset=1 name='session.Usr';
	}
	request.msg = 'Saved!'
}
request.navbar = false
</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
<form>
	<cfinclude template="/Inc/Save.cfm">
	<label for="UsrName">Name:</label>
	<input name="UsrName" value="#session.Usr.UsrName#" autofocus>
	<label for="FirstName">First Name:</label>
	<input name="FirstName" value="#session.Usr.FirstName#">
	<label for="Email">Email:</label>
	<input name="Email" value="#session.Usr.Email#">
	<label for="UsrPass">Password:</label>
	<input name="UsrPass">
	<label for="FolderID">FolderID:</label>
	<input name="FolderID" value="#session.Folder.FolderID#">
</form>
todo: I'm not sure what to do about the folderid.
<cfinclude template="/Inc/footer.cfm">
</cfoutput>