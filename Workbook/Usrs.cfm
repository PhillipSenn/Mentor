<cfscript>
if (IsDefined('form.Save')) {
	storedproc datasource='Mentor'
		procedure='ki.[Update]' {
		procparam value=session.Usr.UsrID;
		procparam value=url.KeyID;
		procparam value=form.KeyName;
		procparam value=form.KeyDesc;
		procparam value=form.KeyLink;
	}
	request.msg = 'Saved!'
}
storedproc datasource='Mentor'
	procedure='ki.[get]' {
	procparam value=session.Usr.UsrID;
	procparam value=url.KeyID;
	procresult name='Key';
}

storedproc datasource='Mentor'
	procedure='Usr.WhereKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value=url.KeyID;
	procresult resultset=1 name='Usr';
}
storedproc datasource='Mentor'
	procedure='P.WhereTypeNameKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value='Description';
	procparam value=url.KeyID;
	procresult resultset=1 name='P';
	procresult resultset=2 name='Type';
}


request.navbar = false
</cfscript>

<cfoutput query="Key">
<cfinclude template="/Inc/header.cfm">
<link rel="stylesheet" href="//PhillipSenn.com/1/Inc/1.css">
<form>
	<cfinclude template="/Inc/Save.cfm">
	<label for="KeyDesc">#KeyName#</label>
	<textarea name="KeyDesc" autofocus>#KeyDesc#</textarea>
	<input type="hidden" name="TypeID" value="#Type.TypeID#">
</form>
<p>Who's #KeyName# workbook do you want to follow?</p>
<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Comment</th>
			<th>Date</th>
			<th>Time</th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="Usr">
			<tr>
				<td><a href="WrkUsr.cfm?KeyID=#url.KeyID#&UsrID=#UsrID#">#UsrName#'s #KeyName# workbook</a></td>
				<td>#VoteName#</td>
				<td>#DateFormat(VoteDate,'mm/dd/yyyy')#</td>
				<td>#TimeFormat(VoteDate,'h:mm:ss')#&nbsp;#TimeFormat(VoteDate,'tt')#</td>
			</tr>
		</cfloop>
		<tr>
			<td>
			<a href="WrkUsrs.cfm?KeyID=#url.KeyID#">Everybody combined</a>
			</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
<p>
	<a href="Key.cfm?ParentID=#url.KeyID#">Add a new feature</a>
</p>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>