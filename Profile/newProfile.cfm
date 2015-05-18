<cfscript>
if (IsDefined('form.Save')) {
	storedproc datasource='Mentor'
		procedure='Usr.[Merge]' { // Insert if necessary and then update
		procparam value=session.Usr.UsrID;
		procparam value=form.UsrName; 
		procparam value=form.FirstName; 
		procparam value=form.Email; 
		procparam value=form.UsrPass; 
		procparam value=form.FolderID; 
		procresult resultset=1 name='Usr';
	}
	request.msg = Usr.ID & ' created!'
}
request.navbar = false
</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
<form>
	<cfinclude template="/Inc/Save.cfm">
	<label for="FolderID">FolderID:</label>
	<input name="FolderID">
	<label for="UsrName">Name:</label>
	<input name="UsrName" autofocus>
	<label for="FirstName">First Name:</label>
	<input name="FirstName">
	<label for="Email">Email:</label>
	<input name="Email" >
	<label for="UsrPass">Password:</label>
	<input name="UsrPass">
</form>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>