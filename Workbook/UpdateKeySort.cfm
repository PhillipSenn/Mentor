<cfscript>
storedproc datasource='Mentor'
	procedure='ki.[UpdateKeySort]' {
	procparam value=session.Usr.UsrID;
	procparam value=form.KeyID;
	procparam value=form.KeySort;
}
</cfscript>
