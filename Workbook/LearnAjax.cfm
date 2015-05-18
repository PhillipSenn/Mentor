<cfscript>
storedproc datasource='Mentor'
	procedure='Vote.UpdateWhereKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value=form.KeyID;
	procparam value=form.ChadID;
}
</cfscript>
