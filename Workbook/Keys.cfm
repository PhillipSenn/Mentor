<cfscript>
param name='url.ParentID' default=0;
if (IsDefined('form.Save')) {
	storedproc datasource='Mentor'
		procedure='ki.[Merge]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.KeyName;
		procparam value=form.KeyDesc;
		procparam value=url.ParentID;
	}
	request.msg = 'Saved!'
}
storedproc datasource='Mentor'
	procedure='ki.WhereParentID' {
	procparam value=session.Usr.UsrID;
	procparam value=url.ParentID;
	procresult resultset=1 name='Key';
}

request.navbar = false
</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
What do you want to learn?
<form>
	<cfinclude template="/Inc/Save.cfm">
	<table>
		<thead>
			<tr>
				<th>Keyword</th>
				<th>Description</th>
				<th colspan="2">View</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="Key">
				<tr>
					<td>#HTMLEditFormat(KeyName)#</a></td>
					<td>
						<cfif KeyLink EQ "">
							#HTMLEditFormat(KeyDesc)#
						<cfelse>
							<a href="#KeyLink#">#HTMLEditFormat(KeyDesc)#</a>
						</cfif>
					</td>
					<td><a href="Usrs.cfm?KeyID=#KeyID#">Workbook</a></td>
					<td><a href="List.cfm?ParentID=#KeyID#">List</a></td>
				</tr>
			</cfloop>
		</tbody>
		<tfoot>
			<tr>
				<th>
					<input name="KeyName">
				</th>
				<th colspan="3">
					<input name="KeyDesc">
				</th>
			</tr>
		</tfoot>
	</table>
</form>	
<cfinclude template="/Inc/footer.cfm">
</cfoutput>