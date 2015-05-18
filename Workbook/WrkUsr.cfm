<cfscript>
storedproc datasource='Mentor'
	procedure='Vote.ChildrenWhereUsrKeyChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procparam value=0;
	procresult resultset=1 name='Vote0';
}
storedproc datasource='Mentor'
	procedure='Vote.ChildrenWhereUsrKeyChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procparam value=1;
	procresult resultset=1 name='Vote1';
}
storedproc datasource='Mentor'
	procedure='Vote.ChildrenWhereUsrKeyChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procparam value=2;
	procresult resultset=1 name='Vote2';
}
storedproc datasource='Mentor'
	procedure='Vote.ChildrenWhereUsrKeyChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procparam value=3;
	procresult resultset=1 name='Vote3';
}
storedproc datasource='Mentor'
	procedure='Vote.ChildrenWhereUsrKeyChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procparam value=4;
	procresult resultset=1 name='Vote4';
}
storedproc datasource='Mentor'
	procedure='Vote.ChildrenWhereUsrKeyChadSort' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procparam value=5;
	procresult resultset=1 name='Vote5';
}

storedproc datasource='Mentor'
	procedure='ki.WhereUsrIsNullForParentID' {
	procparam value=session.Usr.UsrID;
	procparam value=url.UsrID;
	procparam value=url.KeyID;
	procresult resultset=1 name='KeyNull';
	procresult resultset=2 name='Usr';
}
</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
<table>
	<thead>
		<tr>
			<th>#Usr.FirstName# says to:</th>
			<th class="num">Count</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<a href="TopLevel.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=1">Learn this first</a>
			</td>
			<td class="num">#Vote1.recordCount#</td>
		</tr>
		<tr>
			<td>
				<a href="TopLevel.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=2">Learn this second</a>
			</td>
			<td class="num">#Vote2.recordCount#</td>
		</tr>
		<tr>
			<td>
				<a href="TopLevel.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=3">Learn this third</a>
			</td>
			<td class="num">#Vote3.recordCount#</td>
		</tr>
		<tr>
			<td>
				<a href="MoreInfo.cfm">#Usr.FirstName# has decided that he doesn't understand this.</a>
			</td>
			<td class="num">#Vote4.recordCount#</td>
		</tr>
		<tr>
			<td>
				<a href="Never.cfm">#Usr.FirstName# says: don't use this.</a>
			</td>
			<td class="num">#Vote5.recordCount#</td>
		</tr>
		<tr>
			<td>
				<a href="Vote.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#">#Usr.FirstName# hasn't even viewed yet</a> 
			</td>
			<td class="num">#KeyNull.recordCount#</td>
		</tr>
		<tr>
			<td>
				<a href="TopLevel.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#&ChadSort=0">#Usr.FirstName# has viewed but hasn't made a decision yet</a>
			</td>
			<td class="num">#Vote0.recordCount#</td>
		</tr>
	</tbody>
</table>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>
