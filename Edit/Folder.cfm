<cfscript>
if (IsDefined('form.Delete')) {
	storedproc datasource='Mentor'
		procedure='Folder.[delete]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.Delete;
		procresult name='Folder';
		procresult name='Parent';
	}
	location('Folder.cfm?FolderID=' & Parent.FolderID,false)
} else if (IsDefined('form.Save')) {
	if (form.FolderID) {
		try {
			storedproc datasource='Mentor'
				returncode=true result='response'
				procedure='Folder.[Update]' {
				procparam value=session.Usr.UsrID;
				procparam value=form.FolderID;
				procparam value=form.FolderName;
				procresult name='Error';
			}
		} catch (any Error) {
			request.msg = Error.Detail
			request.mod = 'label-warning'
		}
		if (NOT IsDefined('response')) {
		} else if (response.StatusCode) {
			request.msg = Error.Msg
			request.mod = 'label-danger'
		} else {
			session.msg = 'Saved!'
			location('Folder.cfm?FolderID=' & form.FolderID,false) // Every page load must be a Ctrl+D reload.
		}
	} else {
		storedproc datasource='Mentor'
			procedure='Folder.[Merge]' {
			procparam value=session.Usr.UsrID;
			procparam value=form.FolderName;
			procparam value=form.ParentID;
		}
		session.msg = 'Added!'
		location('Folder.cfm?FolderID=' & form.ParentID,false)
		// Discretionary. I just thought I'd be taken back to the parent page again.
	}
}
if (StructKeyExists(session,'Usr')) {
	if (NOT IsDefined('form.FolderID') AND NOT IsDefined('url.ParentID')) {
		form.FolderID = session.Folder.FolderID // default
	}
	if (IsDefined('form.Save')) {
	} else if (IsDefined('form.FolderID')) {
		storedproc datasource='Mentor'
			procedure='Folder.[get]' {
			procparam value=session.Usr.UsrID;
			procparam value=form.FolderID;
			procresult resultset=1 name='Folder';
			procresult resultset=2 name='Parent';
		}
		form.FolderName = Folder.FolderName
		if (IsDefined('Parent')) {
			form.ParentID = Parent.FolderID
		} else {
			form.ParentID = 0
		}
	} else if (IsDefined('url.ParentID')) { // Creating a new Folder
		form.FolderID = 0
		form.FolderName = ''
	}
	storedproc datasource='Mentor'
		procedure='Folder.WhereParentID' {
		procparam value=session.Usr.UsrID;
		procparam value=form.FolderID; // Everybody whose parent is this guy.
		procresult resultset=1 name='Children';
	}
	storedproc datasource='Mentor'
		procedure='Exercise.WhereFolderID' {
		procparam value=session.Usr.UsrID;
		procparam value=form.FolderID;
		procresult resultset=1 name='Exercise';
	}
	request.navbar = false
}
</cfscript>

<cfoutput>
<cfinclude template="/Inc/header.cfm">
<cfif StructKeyExists(session,'Usr')>
	<form action="Folder.cfm">
		<cfinclude template="/Inc/Save.cfm">
		<cfif NOT form.ParentID>
			<!--- root --->
			<input type="hidden" name="FolderName" value="#form.FolderName#">
		<cfelseif form.FolderID>
			<div class="row">
				<div class="col-sm-11">
					<label for="FolderName">Folder Name:</label>
					<input name="FolderName" value="#form.FolderName#" autofocus>
				</div>
				<div class="col-sm-1">
					<button name="Delete" value="#form.FolderID#">Delete</button>
				</div>
			</div>
		<cfelse>
			<label for="FolderName">Folder Name:</label>
			<input name="FolderName" value="#form.FolderName#" autofocus>
		</cfif>
		<input type="hidden" name="ParentID" value="#form.ParentID#">
		<input type="hidden" name="FolderID" value="#form.FolderID#">
	</form>
	<cfif form.FolderID>
		<table>
			<thead>
				<tr>
					<th>
						<span class="glyphicon glyphicon-folder-close"></span>
					</th>
					<th>
						Folders
					</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="Children">
					<tr>
						<td>
							<span class="glyphicon glyphicon-folder-close"></span>
						</td>
						<td><a href="Folder.cfm?ID=#session.Usr.ID#&FolderID=#FolderID#">#FolderName#</a></td>
					</tr>
				</cfloop>
			</tbody>
			<tfoot>
				<tr>
					<td>
					</td>
					<td>
						<input name="newFolderName">
					</td>
				</tr>
			</tfoot>
		</table>
		<cfif form.ParentID>
			<table>
				<thead>
					<tr>
						<th>
							<span class="glyphicon glyphicon-file"></span>
						</th>
						<th>Programs</th>
					</tr>
				</thead>
				<tbody>
					<cfloop query="Exercise">
						<tr>
							<td>
								<span class="glyphicon glyphicon-file"></span>
							</td>
							<td><a href="Edit.cfm?ID=#session.Usr.ID#&ExerciseID=#ExerciseID#">#ExerciseName#</a></td>
						</tr>
					</cfloop>
				</tbody>
				<tfoot>
					<tr>
						<td>
						</td>
						<td>
							<a href="Edit.cfm?FolderID=#form.FolderID#">New</a>
						</td>
					</tr>
				</tfoot>
			</table>
		<cfelse>
			<img src="//PhillipSenn.com/1/Edit/CityStateDivision.fw.png">
		</cfif>
	</cfif>
<cfelse>
	You must be logged in to use this program.
</cfif>
<!--- 
TODO: 
Delete doesn't recurse.
Delete doesn't delete the folders.
<script src="//PhillipSenn.com/1/Edit/getURL.js"></script>
--->
<script src="//PhillipSenn.com/1/Edit/Folder.js"></script>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>