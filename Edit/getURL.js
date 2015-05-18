function getURL(argument) {
	var local = {};
	local.result = '';
	
	local.href = location.href;
	local.i = local.href.indexOf('#');
	if (local.i >= 0) { // In case they press refresh while on page 2
		local.href = local.href.substr(0,local.i);
	}
	local.href = local.href.slice(local.href.indexOf('?') + 1);
	local.hashes = local.href.split('&');
	for(local.i = 0; local.i < local.hashes.length; local.i++)	{
		local.hash = local.hashes[local.i].split('=');
		if (local.hash[0].toUpperCase() === argument.toUpperCase()) {
			local.result = local.hash[1]
		}
	}
	return local.result;
}
// Usage: X = getURL('X')
