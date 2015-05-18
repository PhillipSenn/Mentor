<cfscript>
if (IsDefined('form.Save')) { // Save the paragraph
	storedproc datasource='Mentor'
		procedure='Type.WhereTypeName' {
		procparam value=session.Usr.UsrID;
		procparam value='Description';
		procresult resultset=1 name='Type';
	}
	storedproc datasource='Mentor'
		procedure='P.[Merge]' { // Merge does an insert if necessary followed by an update.
		procparam value=session.Usr.UsrID;
		procparam value=url.KeyID;
		procparam value=Type.TypeID;
		procparam value=form.PName;
	}
	request.msg = 'Saved!'
} else if (IsDefined('url.ChadID')) { // The user is voting.
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
	procedure='Usr.[get]' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procresult resultset=1 name='Usr';
}

storedproc datasource='Mentor'
	procedure='ki.[get]' {
	procparam value=session.Usr.UsrID;
	procparam value=url.KeyID;
	procresult resultset=1 name='Key';
}

storedproc datasource='Mentor'
	procedure='Chad.WhereChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.ChadSort;
	procresult resultset=1 name='Chad';
}
SaveChadID = Chad.ChadID
SaveChadName = Chad.ChadName

storedproc datasource='Mentor'
	procedure='Vote.WhereUsrParentID' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procresult resultset=1 name='Vote';
}
storedproc datasource='Mentor'
	procedure='P.WhereTypeNameKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value='Description';
	procparam value=url.KeyID;
	procresult resultset=1 name='P';
}


storedproc datasource='Mentor'
	procedure='Chad.[Where]' {
	procparam value=session.Usr.UsrID;
	procresult resultset=1 name='Chad';
}
if (url.ChadSort == 1) {
	ChadDesc = 'Learn this first'
} else if (url.ChadSort == 2) {
	ChadDesc = 'Learn this second'
} else if (url.ChadSort == 3) {
	ChadDesc = 'Learn this third'
} else if (url.ChadSort == 4) {
	ChadDesc = Usr.FirstName & ' has decided that he doesn''t understand this.'
} else if (url.ChadSort == 5) {
	ChadDesc = Usr.FirstName & ' says: don''t use this.'
} else if (url.ChadSort == 0) {
	ChadDesc = Usr.FirstName & ' has viewed but hasn''t made a decision yet.'
} else {
	ChadDesc = 'Logic error.'
}
</cfscript>

<cfoutput query="Key">
<cfinclude template="/Inc/header.cfm">
<link rel="stylesheet" href="//PhillipSenn.com/1/Inc/1.css">
<div class="text-right">
	<div class="btn-group" role="group">
		<cfloop query="Chad" startrow="2">
			<cfif Key.ChadID EQ ChadID>
				<cfset myClass="btn-primary">
			<cfelse>
				<cfset myClass = "btn-default">
			</cfif>
			<!---
			ChadSort is what they are viewing.
			ChadID is what they are voting.
			--->
			<a href="TopLevel.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=#url.ChadSort#&ChadID=#ChadID#" class="btn #myClass#">#ChadName#</a>
		</cfloop>
	</div>
</div>
<h1>#ChadDesc#</h1>
<table id="children">
	<thead>
		<tr>
			<th>Keyword</th>
			<th>Description</th>
			<th class="num">Keywords</th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="Vote">
			<cfset myClass = ChadID>
			<cfif ChadID NEQ SaveChadID>
				<cfset myClass &= " hidden">
			</cfif>
			<tr class="#myClass#">
				<td><a href="LearnThis.cfm?UsrID=#url.UsrID#&KeyID=#KeyID#&ChadSort=#url.ChadSort#">#HTMLEditFormat(KeyName)#</a></td>
				<td>#HTMLEditFormat(KeyDesc)#</td>
				<td class="num">#GrandChildren#</td>
			</tr>
		</cfloop>
	</tbody>
</table>
If you know all this stuff already, you can 
<a href="Vote.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=#url.ChadSort#">vote on all these keywords on one screen</a>.
<cfinclude template="/Inc/footer.cfm">
</cfoutput>