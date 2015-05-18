<cfscript>
jQueryChecked = 'checked'
BootstrapChecked = 'checked'
CSSChecked = 'checked'
containerChecked = 'checked'
form.HTMLCode = ''
form.CSSCode = ''
form.JavaScriptCode = ''
form.SQLCode = ''
form.cfscriptCode = ''
form.SourceCode = ''
if (IsDefined('form.ExerciseID')) {
	storedproc datasource='Mentor'
		procedure='Pgm.WhereExerciseID' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procresult resultset=1 name='Pgm';
		procresult resultset=2 name='Exercise';
		procresult resultset=3 name='Folder';
	}
	form.ExerciseName = Exercise.ExerciseName
	loop query=Pgm {
		if (TypeName == 'HTMLCode') {
			form.HTMLCode = PgmCode
		} else if (TypeName == 'CSSCode') {
			form.CSSCode = PgmCode
		} else if (TypeName == 'JavaScriptCode') {
			form.JavaScriptCode = PgmCode
		} else if (TypeName == 'SQLCode') {
			form.SQLCode = PgmCode
		} else if (TypeName == 'cfscriptCode') {
			form.cfscriptCode = PgmCode
		} else if (TypeName == 'Options') {
			if (NOT ListFindNoCase(PgmCode,'jQuery')) {
				jQueryChecked = ''
			}
			if (NOT ListFindNoCase(PgmCode,'Bootstrap')) {
				BootstrapChecked = ''
			}
			if (NOT ListFindNoCase(PgmCode,'CSS')) {
				CSSChecked = ''
			}
			if (NOT ListFindNoCase(PgmCode,'container')) {
				containerChecked = ''
			}
		}
	}
	
	form.FolderID = Folder.FolderID
	storedproc datasource='Mentor'
		procedure='Folder.Ancestry' {
		procparam value=session.Usr.UsrID;
		procparam value=form.FolderID;
		procresult resultset=1 name='Ancestry';
	}
	
	fileName = request.home & '/'
	loop query=Ancestry {
		fileName &= FolderName & '/'
	}
	fileName &= Exercise.ExerciseName & '.cfm'
	try {
		form.SourceCode = fileRead(fileName)
	} catch (any Exception) {
	}
} else {
	form.ExerciseID = 0
	form.ExerciseName = ''
	form.HTMLCode = ''
	form.CSSCode = ''
	form.JavaScriptCode = ''
	form.SQLCode = ''
	form.cfscriptCode = ''
}
request.navbar = false
</cfscript>

<cfoutput>
<cfinclude template="/Inc/html.cfm">
<link rel="stylesheet" href="//PhillipSenn.com/1/Edit/Edit.css">
<cfinclude template="/Inc/body.cfm">
<form action="EditAction.cfm">
	<cfinclude template="/Inc/Save.cfm">
	<div class="row">
		<div class="col-sm-11">
			<label for="ExerciseName">Program Name:</label>
			<input name="ExerciseName" value="#form.ExerciseName#" autofocus placeholder="HelloWorld">
		</div>
	</div>
	<div role="tabpanel">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a id="HTMLTab" href="#request.hashTag#HTMLTabPane" aria-controls="HTML" role="tab" data-toggle="tab">HTML</a>
			</li>
			<li role="presentation">
				<a id="CSSTab" href="#request.hashTag#CSSTabPane" aria-controls="CSS" role="tab" data-toggle="tab">CSS</a>
			</li>
			<li role="presentation">
				<a id="JavaScriptTab" href="#request.hashTag#JavaScriptTabPane" aria-controls="JavaScript" role="tab" data-toggle="tab">JavaScript</a>
			</li>
			<li role="presentation">
				<a id="SQLTab" href="#request.hashTag#SQLTabPane" aria-controls="SQL" role="tab" data-toggle="tab">SQL</a>
			</li>
			<li role="presentation">
				<a id="CFScriptTab" href="#request.hashTag#CFScriptTabPane" aria-controls="CFScript" role="tab" data-toggle="tab">cfscript</a>
			</li>
			<li role="presentation">
				<a id="OptionsTab" href="#request.hashTag#OptionsTabPane" aria-controls="Options" role="tab" data-toggle="tab">Options</a>
			</li>
			<cfif IsDefined('fileName')>
				<li role="presentation">
					<a id="SourceTab" href="#request.hashTag#SourceTabPane" aria-controls="Source" role="tab" data-toggle="tab">#fileName#</a>
				</li>
			</cfif>
		</ul>
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="HTMLTabPane"> 
				<div class="row">
					<div class="col-sm-11">
						<textarea name="HTMLCode" rows="10" spellcheck="false">#form.HTMLCode#</textarea>
					</div>
					<div class="col-sm-1 text-right">
						<a title="<table></table>" class="paste btn glyphicon glyphicon-paste"></a>
					</div>
					<pre class="pasteValue"><h1>Test</h1>
<table>
	<thead>
		<tr>
			<th>State Name</th>
			<th class="num">Population</th>
		</tr>
	</thead>
	<tbody>
		<!-- cfloop -->
			<tr>
				<td>#request.hashTag#StateName#request.hashTag#</td>
				<td class="num">#request.hashTag#Population#request.hashTag#</td>
			</tr>
		<!-- /cfloop -->
	</tbody>
</table></pre>
				</div>
				<cfif IsDefined('fileName') AND FileExists(fileName)>
					<div class="row">
						<div class="col-sm-11">
							<iframe width="100%" height="300px" src="#fileName#"></iframe>
						</div>
						<div class="col-sm-1">
							<a title="View Web page" target="_blank" id="zoom" class="btn pull-right" href="#fileName#"><span class="glyphicon glyphicon-modal-window"></span></a>
							<a title="View source" target="_blank" class="btn pull-right" href="view-source:http://#request.host##fileName#"><span class="glyphicon glyphicon-file"></span></a>
						</div>
					</div>
				</cfif>
			</div>
			<div role="tabpanel" class="tab-pane" id="CSSTabPane"> 
				<div class="row">
					<div class="col-sm-11">
						<textarea name="CSSCode" rows="20" spellcheck="false">#form.CSSCode#</textarea>
					</div>
					<div class="col-sm-1 text-right">
						<a title="h1 {" class="paste btn glyphicon glyphicon-paste"></a>
					</div>
				</div>
				<pre class="pasteValue">h1 {
color:cornflowerblue;
}</pre>
			</div>
			<div role="tabpanel" class="tab-pane" id="JavaScriptTabPane"> 
				<div class="row">
					<div class="col-sm-11">
						<textarea name="JavaScriptCode" rows="20" spellcheck="false">#form.JavaScriptCode#</textarea>
					</div>
					<div class="col-sm-1 text-right">
						<a title="console.log(" class="paste btn glyphicon glyphicon-paste"></a>
					</div>
				</div>
				<pre class="pasteValue">console.log($('table')[0])
</pre>
			</div>
			<div role="tabpanel" class="tab-pane" id="SQLTabPane"> 
				<div class="row">
					<div class="col-sm-11">
						<textarea name="SQLCode" rows="20" spellcheck="false">#form.SQLCode#</textarea>
					</div>
					<div class="col-sm-1 text-right">
						<a title="CREATE PROC" class="paste btn glyphicon glyphicon-paste"></a>
					</div>
				</div>
				<pre class="pasteValue">CREATE PROC Test(
   @UsrID Int,
   @DivisionID Int
) AS
SELECT StateName,isState,Statehood,Abbr,Population,StateMap,LastUpdated
FROM State
WHERE State_DivisionID = @DivisionID
exec Division.[get] @UsrID,@DivisionID</pre>
			</div>
			<div role="tabpanel" class="tab-pane" id="CFScriptTabPane"> 
				<div class="row">
					<div class="col-sm-11">
						<textarea name="cfscriptCode" rows="20" spellcheck="false">#form.cfscriptCode#</textarea>
					</div>
					<div class="col-sm-1 text-right">
						<a title="storedproc procedure=''" class="paste btn glyphicon glyphicon-paste"></a>
					</div>
				</div>
				<pre class="pasteValue">storedproc procedure='Test' {
   procparam value=session.Usr.UsrID;
   procparam value=5;
   procresult resultset=1 name='State';
   procresult resultset=2 name='Division';
}</pre>
			</div>
			<div role="tabpanel" class="tab-pane" id="OptionsTabPane"> 
				<div class="checkbox">
					<label>
						<input type="checkbox" name="Options" value="jQuery" #jQueryChecked#>Include jQuery
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" name="Options" value="Bootstrap" #BootstrapChecked#>Include Bootstrap
					</label>
				</div>
				<ul class="list-unstyled">
					<li>
						<div class="checkbox">
							<label>
								<input type="checkbox" name="Options" value="container" #containerChecked#>Include a container
							</label>
						</div>
					</li>
				</ul>
				<div class="checkbox">
					<label>
						<input type="checkbox" name="Options" value="CSS" #CSSChecked#>Include Phillip's default CSS
					</label>
				</div>
			</div>
			<cfif IsDefined('form.SourceCode')>
				<div role="tabpanel" class="tab-pane" id="SourceTabPane"> 
					<textarea name="SourceCode" rows="20" spellcheck="false">#form.SourceCode#</textarea>
					<!---
					I better not do this because it runs the program twice, which might confuse the learner
					if he's expecting certain results from it only being run once (Example: INSERT INTO).
					<cfif IsDefined('fileName') AND FileExists(fileName)>
						<iframe width="100%" height="300px" src="#fileName#"></iframe>
					</cfif>
					--->
				</div>
			</cfif>
		</div>
	</div>
	<input type="hidden" name="FolderID" value="#form.FolderID#">
	<input type="hidden" name="ExerciseID" value="#form.ExerciseID#">
</form>
<cfinclude template="/Inc/foot.cfm">
<script src="//PhillipSenn.com/1/Edit/Edit.js"></script>
<cfinclude template="/Inc/End.cfm">
</cfoutput>