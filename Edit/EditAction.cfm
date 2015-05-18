<cfscript>
storedproc datasource='Mentor'
	procedure='Folder.Ancestry' {
	procparam value=session.Usr.UsrID;
	procparam value=form.FolderID;
	procresult resultset=1 name='Ancestry';
}
fileName = request.home & '/'
loop query=Ancestry {
	fileName &= FolderName
	if (NOT DirectoryExists(fileName)) {
		directory action='create' directory=fileName;
	}
	fileName &= '/'
}
if (form.ExerciseName == '') {
	form.ExerciseName = 'HelloWorld'
}
fileName &= Trim(form.ExerciseName) // fileName cannot have .cfm because it has to also have .css and .js

param name='form.Options' default='';
if (form.ExerciseID) {
	storedproc datasource='Mentor'
		procedure='Exercise.[Update]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procparam value=form.ExerciseName;
	}
	Updating = true
} else {
	storedproc datasource='Mentor' 
		procedure='Exercise.[Merge]' {
		procparam value=session.Usr.UsrID;
		procparam value=form.FolderID;
		procparam value=form.ExerciseName;
		procresult name='Exercise';
	}
	form.ExerciseID = Exercise.ExerciseID
	Updating = false
}
if (Updating OR Len(form.HTMLCode) > 0) {
	storedproc datasource='Mentor'
		procedure='Pgm.SaveWhereTypeName' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procparam value='HTMLCode';
		procparam value=form.HTMLCode;
	}
}
if (Updating OR Len(form.CSSCode) > 0) {
	storedproc datasource='Mentor'
		procedure='Pgm.SaveWhereTypeName' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procparam value='CSSCode';
		procparam value=form.CSSCode;
	}
}
if (Updating OR Len(form.JavaScriptCode) > 0) {
	storedproc datasource='Mentor'
		procedure='Pgm.SaveWhereTypeName' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procparam value='JavaScriptCode';
		procparam value=form.JavaScriptCode;
	}
}
if (Updating OR Len(form.SQLCode) > 0) {
	storedproc datasource='Mentor'
		procedure='Pgm.SaveWhereTypeName' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procparam value='SQLCode';
		procparam value=form.SQLCode;
	}
}
if (Updating OR Len(form.cfscriptCode) > 0) {
	storedproc datasource='Mentor'
		procedure='Pgm.SaveWhereTypeName' {
		procparam value=session.Usr.UsrID;
		procparam value=form.ExerciseID;
		procparam value='cfscriptCode';
		procparam value=form.cfscriptCode;
	}
}

// todo: If they're all checked, then don't save it.
storedproc datasource='Mentor'
	procedure='Pgm.SaveWhereTypeName' {
	procparam value=session.Usr.UsrID;
	procparam value=form.ExerciseID;
	procparam value='Options';
	procparam value=form.Options;
}

I = FindNoCase('CREATE PROC ',form.SQLCode)
if (I) {
	I = I + 12
	CRLF = Find(Chr(13),form.SQLCode,I)
	LeftParenthesis = Find('(',form.SQLCode,I)
	if (CRLF < LeftParenthesis) {
		L = CRLF
	} else {
		L = LeftParenthesis
	}
	WriteOutput('LeftParenthesis: ' & LeftParenthesis & '<br>')
	if (LeftParenthesis == 0 OR LeftParenthesis > 30) {
		L = Find(' AS',form.SQLCode,I)
		WriteOutput('Finding ' & L & ' instead.')
	}
	WriteOutput(I & '<br>')
	WriteOutput(L & '<br>')
	WriteOutput(L-I & '<br>')
	SprocName = Mid(form.SQLCode,I,L-I)
	WriteOutput(SprocName & '<br>')
	DropProc = "IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'" & SprocName & "') AND type in (N'P', N'PC'))"
	DropProc &= " DROP PROC " & SprocName
	WriteOutput('<pre>' & DropProc & '</pre>')
	queryExecute(DropProc)
}
if (form.SQLCode != '') {
	queryExecute(form.SQLCode)
}
Pgm = ''
if (form.cfscriptCode != '') {
	Pgm &= '<cfscript>' & request.LF
	Pgm &= form.cfscriptCode & request.LF
	Pgm &= '</cfscript>' & request.LF & request.LF
}
Pgm &= '<cfoutput>' & request.LF
Pgm &= '<!doctype html>' & request.LF
Pgm &= '<html>' & request.LF
Pgm &= '<head>' & request.LF
// Pgm &= '<meta charset="utf-8">' & request.LF
// Pgm &= '<meta content="' & session.Usr.UsrName & '" name="author">' & request.LF
// Pgm &= '<meta content="no-cache, no-store, must-revalidate" http-equiv="Cache-Control">' & request.LF
// Pgm &= '<meta content="no-cache" http-equiv="Pragma">' & request.LF
// Pgm &= '<meta content="0" http-equiv="Expires">' & request.LF
if (ListFindNoCase(form.Options,'Bootstrap')) {
	Pgm &= '<link rel="stylesheet" href="//cdn.jsdelivr.net/bootstrap/latest/css/bootstrap.css">' & request.LF
	Pgm &= '<link rel="stylesheet" href="//cdn.jsdelivr.net/bootstrap/latest/css/bootstrap-theme.css">' & request.LF
}
if (ListFindNoCase(form.Options,'CSS')) {
	Pgm &= '<link rel="stylesheet" href="#request.home#/Inc/PhillipSenn.css">' & request.LF
}
if (form.CSSCode != '') {
	fileWrite(fileName & '.css', form.CSSCode);
	Pgm &= '<link rel="stylesheet" href="' & form.ExerciseName & '.css?cacheBuster=#DateFormat(now(),'yymmdd')##TimeFormat(Now(),'HHmmss')#">' & request.LF
}
if (ListFindNoCase(form.Options,'jQuery')) {
	Pgm &= '<script src="//cdn.jsdelivr.net/jquery/latest/jquery.js"></script>' & request.LF
}
Pgm &= '</head>' & request.LF
Pgm &= '<body>' & request.LF
if (ListFindNoCase(form.Options,'Bootstrap')) {
	if (ListFindNoCase(form.Options,"container")) {
		Pgm &= '<main class="container">' & request.LF
	} else {
		Pgm &= '<main class="container-fluid">' & request.LF
	}
}
Pgm &= form.HTMLCode & request.LF
if (ListFindNoCase(form.Options,'Bootstrap')) {
	Pgm &= '</main>' & request.LF
	Pgm &= '<script src="//cdn.jsdelivr.net/bootstrap/latest/js/bootstrap.js"></script>' & request.LF
}
if (form.JavaScriptCode != '') {
	fileWrite(fileName & '.js', form.JavaScriptCode);
	Pgm &= '<script src="' & form.ExerciseName & '.js?cacheBuster=#DateFormat(now(),'yymmdd')##TimeFormat(Now(),'HHmmss')#"></script>' & request.LF
}
Pgm &= '</body>' & request.LF
Pgm &= '</html>' & request.LF
Pgm &= '</cfoutput>' & request.LF

fileWrite(fileName & '.cfm', Pgm);
location('Edit.cfm?ID=#session.Usr.ID#&ExerciseID=' & form.ExerciseID,false)
</cfscript>
