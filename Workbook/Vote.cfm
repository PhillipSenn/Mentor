<cfscript>
if (IsDefined('url.ChadID')) { // This is when they _vote for_ this KeyID
	storedproc datasource='Mentor'
		procedure='Vote.UpdateWhereKeyID' {
		procparam value=session.Usr.UsrID;
		procparam value=url.KeyID;
		procparam value=url.ChadID;
	}
} else {
	storedproc datasource='Mentor'
		procedure='Vote.InsertDefault' {
		procparam value=session.Usr.UsrID;
		procparam value=url.KeyID;
	}
}
storedproc datasource='Mentor'
	procedure='ki.[get]' {
	procparam value=session.Usr.UsrID;
	procparam value=url.KeyID;
	procresult resultset=1 name='Parent';
}
storedproc datasource='Mentor'
	procedure='Usr.[get]' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procresult resultset=1 name='Usr';
}


if (IsDefined('url.ChadSort')) {
	// All the keywords under this ParentID where Usr.UsrID has voted url.ChadSort regardless of how you've voted.
	storedproc datasource='Mentor'
		procedure='Vote.ChildrenWhereUsrKeyChadSort' { // All the keys for this parent
		procparam value=session.Usr.UsrID;
		procparam value=Usr.UsrID; // Phillip Senn's workbook
		procparam value=url.KeyID;
		procparam value=url.ChadSort;
		procresult resultset=1 name='Key';
	}
} else {
	// You are initialzing this list of keywords
	storedproc datasource='Mentor'
		procedure='ki.WhereUsrIsNullForParentID' { // All the keys for this parent
		procparam value=session.Usr.UsrID;
		procparam value=session.Usr.UsrID; // that you have not voted on.
		procparam value=url.KeyID;
		procresult resultset=1 name='Key';
	}
}
storedproc datasource='Mentor'
	procedure='Chad.[Where]' {
	procparam value=session.Usr.UsrID;
	procresult resultset=1 name='Chad';
}
storedproc datasource='Mentor'
	procedure='P.WhereTypeNameKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value='Description';
	procparam value=url.KeyID;
	procresult resultset=1 name='P';
}

request.navbar = false
</cfscript>

<cfoutput query="Parent">
<cfinclude template="/Inc/header.cfm">
<form>
	<cfinclude template="/Inc/Save.cfm">
	<cfif IsDefined('url.ChadSort')>
		<div class="text-right">
			<div class="btn-group" role="group">
				<cfloop query="Chad" startrow="2">
					<a href="LearnThis.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=#url.ChadSort#&ChadID=#ChadID#" class="btn btn-default">#ChadName#</a>
				</cfloop>
			</div>
		</div>
	</cfif>
</form>
<table>
	<thead>
		<tr>
			<th>#Parent.KeyName#</th>
			<th>How say you?</th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="Key">
			<tr>
				<td>
					<cfif IsDefined('url.ChadSort')>
						<a href="LearnThis.cfm?UsrID=#url.UsrID#&KeyID=#KeyID#&ChadSort=#url.ChadSort#">#HTMLEditFormat(KeyName)#</a>
					<cfelse>
						<a href="LearnThis.cfm?UsrID=#url.UsrID#&KeyID=#KeyID#">#HTMLEditFormat(KeyName)#</a>
					</cfif>
				</td>
				<td class="btn-group" role="group">
					<cfloop query="Chad" startrow="2">
						<cfif NOT IsDefined('url.ChadSort')>
							<cfset myClass = "btn-default">
						<cfelseif Key.myChadID EQ ChadID>
							<cfset myClass = "btn-primary">
						<cfelse>
							<cfset myClass = "btn-default">
						</cfif>
						<a data-keyid="#KeyID#" data-chadid="#ChadID#" class="vote btn #myClass#">#ChadName#</a>
					</cfloop>
				</td>
			</tr>
		</cfloop>
	</tbody>
</table>
<script src="//PhillipSenn.com/1/Workbook/Vote.js"></script>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>