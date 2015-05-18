<cfscript>
storedproc dataSource='Mentor'
	procedure='Folder.[Merge]' {
	procparam value=session.Usr.UsrID;
	procparam value=form.FolderName;
	procparam value=form.ParentID;
	procresult name='Folder';
}
WriteOutput(SerializeJSON(Folder))
</cfscript>
