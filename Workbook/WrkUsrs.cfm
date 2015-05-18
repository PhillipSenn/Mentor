<cfscript>
storedproc datasource='Mentor'
	procedure='Chad.[Where]' {
	procparam value=session.Usr.UsrID;
	procresult resultset=1 name='Chad';
}
</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
<table>
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th>Description</th>
			<cfloop query="Chad" startrow="2">
				<th class="num">#ChadName#</th>
			</cfloop>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="num">1</td>
			<td>
				<a href="LearnThisFirst.cfm">Learn this first</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
		<tr>
			<td class="num">2</td>
			<td>
				<a href="LearnThisSecond.cfm">Learn this second</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
		<tr>
			<td class="num">3</td>
			<td>
				<a href="LearnThisThird.cfm">Learn this third</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
		<tr>
			<td class="num">4</td>
			<td>
				<a href="MoreInfo.cfm">Learn this null</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
		<tr>
			<td class="num">5</td>
			<td>
				<a href="Never.cfm">Learn to not use this</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
		<tr>
			<td class="num">&empty;</td>
			<td>
				<a href="Never.cfm">Not viewed yet</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
		<tr>
			<td class="num">0</td>
			<td>
				<a href="Never.cfm">Viewed but no decision
				</a>
			</td>
			<cfloop query="Chad" startrow="2">
				<td class="num">0</td>
			</cfloop>
		</tr>
	</tbody>
</table>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>