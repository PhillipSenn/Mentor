<cfscript>
if (IsDefined('form.Save')) { // Save the paragraph
	storedproc datasource='Mentor'
		procedure='ki.[Update]' {
		procparam value=session.Usr.UsrID;
		procparam value=url.KeyID;
		procparam value=form.KeyName;
		procparam value=form.KeyDesc;
		procparam value=form.KeyLink;
	}
	storedproc datasource='Mentor'
		procedure='p.MergeTypeNameKeyID' {
		procparam value=session.Usr.UsrID;
		procparam value='HTMLCode';
		procparam value=url.KeyID;
		procparam value=form.HTMLCode;
	}
	storedproc datasource='Mentor'
		procedure='p.MergeTypeNameKeyID' {
		procparam value=session.Usr.UsrID;
		procparam value='CSSCode';
		procparam value=url.KeyID;
		procparam value=form.CSSCode;
	}
	storedproc datasource='Mentor'
		procedure='p.MergeTypeNameKeyID' {
		procparam value=session.Usr.UsrID;
		procparam value='JavaScriptCode';
		procparam value=url.KeyID;
		procparam value=form.JavaScriptCode;
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
	procresult resultset=1 name='Usr'; // FirstName
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
	procedure='Chad.[Where]' {
	procparam value=session.Usr.UsrID;
	procresult resultset=1 name='Chad';
}

storedproc datasource='Mentor'
	procedure='p.WhereTypeNameKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value='HTMLCode';
	procparam value=url.KeyID;
	procresult resultset=1 name='p';
}
HTMLCode = p.PName
storedproc datasource='Mentor'
	procedure='p.WhereTypeNameKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value='CSSCode';
	procparam value=url.KeyID;
	procresult resultset=1 name='p';
}
CSSCode = p.PName

storedproc datasource='Mentor'
	procedure='p.WhereTypeNameKeyID' {
	procparam value=session.Usr.UsrID;
	procparam value='JavaScriptCode';
	procparam value=url.KeyID;
	procresult resultset=1 name='p';
}
JavaScriptCode = p.PName
request.navbar = false
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
			Using url.KeyID in a loop here might not be the utmost efficient, but it keeps the parameters together
			and doesn't require an added getURL function. We're only looping over about 5 chads.
			--->
			<a class="vote btn #myClass#" data-keyid="#url.KeyID#" data-chadid="#ChadID#">#ChadName#</a>
		</cfloop>
	</div>
</div>
<h1>#HTMLEditFormat(KeyName)#</h1>
<form>
	<cfinclude template="/Inc/Save.cfm">
	<div role="tabpanel">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a id="DescTab" href="#request.hashTag#KeyDescTabContent" aria-controls="Description" role="tab" data-toggle="tab">Description</a>
			</li>
			<li role="presentation">
				<a id="HTMLTab" href="#request.hashTag#HTMLTabContent" aria-controls="HTML" role="tab" data-toggle="tab">HTML</a>
			</li>
			<li role="presentation">
				<a id="CSSTab" href="#request.hashTag#CSSTabContent" aria-controls="CSS" role="tab" data-toggle="tab">CSS</a>
			</li>
			<li role="presentation">
				<a id="JavaScriptTab" href="#request.hashTag#JavaScriptTabContent" aria-controls="JavaScript" role="tab" data-toggle="tab">JavaScript</a>
			</li>

			<li role="presentation">
				<a id="ChildTab" href="#request.hashTag#ChildTabContent" aria-controls="Child" role="tab" data-toggle="tab">Keywords</a>
			</li>
		</ul>
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="KeyDescTabContent"> 
				<textarea name="KeyDesc" rows="10">#KeyDesc#</textarea>
			</div>
			<div role="tabpanel" class="tab-pane" id="HTMLTabContent"> 
				<textarea name="HTMLCode" rows="10" spellcheck="false">#HTMLCode#</textarea>
			</div>
			<div role="tabpanel" class="tab-pane" id="CSSTabContent"> 
				<textarea name="CSSCode" rows="10" spellcheck="false">#CSSCode#</textarea>
			</div>
			<div role="tabpanel" class="tab-pane" id="JavaScriptTabContent"> 
				<textarea name="JavaScriptCode" rows="10" spellcheck="false">#JavaScriptCode#</textarea>
			</div>
			<div role="tabpanel" class="tab-pane" id="ChildTabContent"> 
				<table id="children">
					<thead>
						<tr>
							<th>Description</th>
							<th>Rating</th>
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
								<td>#ChadName#</td>
								<td class="num">#GrandChildren#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
				<div class="row p">
					<div class="col-sm-6">
						<a href="Vote.cfm?UsrID=#url.UsrID#&KeyID=#url.KeyID#">Click here to vote on all the keywords on one screen</a>.
					</div>
					<div class="col-sm-6">
						<label for="filterBy">Show me the ones #Usr.FirstName# rated as:</label>
						<select name="filterBy">
							<cfloop query="Chad" startrow="2">
								<option value="#ChadID#">#ChadName#</option>
							</cfloop>
							<option value="0">All combined</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script src="//PhillipSenn.com/1/Workbook/Vote.js"></script>
<script src="//PhillipSenn.com/1/Workbook/LearnThis.js"></script>
<!--- ?cacheBuster=#DateFormat(now(),'yymmdd')##TimeFormat(Now(),'HHmmss')#" --->
<cfinclude template="/Inc/footer.cfm">
</cfoutput>