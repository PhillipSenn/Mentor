<cfscript>
if (IsDefined('form.Save')) {
	storedproc datasource='Mentor'
		procedure='Folder.[Merge]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.FolderName;
		procparam value=0;
	}
	request.msg = 'Saved!'
}
storedproc datasource='Mentor'
	procedure='Folder.WhereParentID' {
	procparam value=session.Usr.UsrID;
	procparam value=0;
	procresult resultset=1 name='Folder';
}
request.navbar = false

</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
<form>
	<cfinclude template="/Inc/Save.cfm">
	<label for="FolderName">Folder:</label>
	<input name="FolderName" autofocus>
</form>
<table>
	<thead>
		<tr>
			<th class="num">ID</th>
			<th>Folder Name</th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="Folder">
			<tr>
				<td class="num">#FolderID#</td>
				<td>#FolderName#</td>
			</tr>
		</cfloop>
	</tbody>
</table>

<cfinclude template="/Inc/footer.cfm">
</cfoutput>