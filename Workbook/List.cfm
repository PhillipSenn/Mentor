<cfscript>
if (IsDefined('form.Save')) {
	storedproc datasource='Mentor'
		procedure='ki.[Update]' {
		procparam value=session.Usr.UsrID;
		procparam value=url.ParentID;
		procparam value=form.KeyName;
		procparam value=form.KeyDesc;
		procparam value=form.KeyLink;
	}
	if (form.ChildName != '') {
		storedproc datasource='Mentor'
			procedure='ki.[Merge]' {
			procparam value=session.Usr.UsrID;
			procparam value=form.ChildName;
			procparam value=form.ChildDesc;
			procparam value=form.ChildLink;
			procparam value=url.ParentID;
		}
	}
	request.msg = 'Saved!'
}
storedproc datasource='Mentor'
	procedure='ki.WhereParentID' {
	procparam value=session.Usr.UsrID;
	procparam value=url.ParentID;
	procresult resultset=1 name='Key';
	procresult resultset=2 name='Parent';
}

request.navbar = false
request.jQueryUI = true
</cfscript>

<cfoutput query="Parent">
<cfinclude template="/Inc/header.cfm">
<h1>#KeyName#</h1>
<form>
	<cfinclude template="/Inc/Save.cfm">
	<label for="KeyName">Keyword:</label>
	<input name="KeyName" value="#KeyName#">
	<label for="KeyDesc">Description:</label>
	<textarea name="KeyDesc">#KeyDesc#</textarea>
	<label for="KeyLink">Home Page:</label>
	<input type="url" name="KeyLink" value="#KeyLink#" class="form-control" placeholder="url">
	<table id="children">
		<thead>
			<tr>
				<th>Keyword</th>
				<th>Description</th>
				<th class="num">Keywords</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="Key">
				<tr data-keyid="#KeyID#">
					<td>#HTMLEditFormat(KeyName)#</td>
					<td>
						<cfif KeyLink EQ "">
							#HTMLEditFormat(KeyDesc)#
						<cfelse>
							<a href="#KeyLink#">#HTMLEditFormat(KeyDesc)#</a>
						</cfif>
					</td>
					<td class="num">
						<cfif Val(Children)>
							<a href="List.cfm?ParentID=#KeyID#">#Children#</a>
						<cfelse>
							<a href="List.cfm?ParentID=#KeyID#">Add</a>
						</cfif>
					</td>
				</tr>
			</cfloop>
		</tbody>
		<tfoot>
			<tr>
				<th>
					<input name="ChildName">
				</th>
				<th colspan="2">
					<textarea name="ChildDesc"></textarea>
				</th>
			</tr>
			<tr>
				<th colspan="3">
					<input name="ChildLink" placeholder="url" type="url" class="form-control">
				</th>
			</tr>
		</tfoot>
	</table>
</form>
<cfinclude template="/Inc/foot.cfm">
<script src="//PhillipSenn.com/1/Workbook/List.js"></script>
<cfinclude template="/Inc/End.cfm">

</cfoutput>