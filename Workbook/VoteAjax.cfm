<cfscript>
storedproc dataSource='Mentor'
	procedure='Vote.[Merge]' {
	procparam value=session.Usr.UsrID;
	procparam value=form.KeyID;
	procparam value=form.ChadID;
//	procresult resultset=1 name='Vote';
}
// WriteOutput(SerializeJSON(Vote))
</cfscript>
