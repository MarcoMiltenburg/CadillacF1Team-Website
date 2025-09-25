(function () {

	document.addEventListener('keydown', onKeyDown);

	function onKeyDown(e) {

		e = e || window.event;

		// Exit early if a modifier key was also pressed (except Ctrl)
		if (e.shiftKey || e.altKey || e.altKey || e.metaKey)
			return;
		
		// left arrow
		if (e.keyCode == 37 && !e.ctrlKey) { triggerPageNavigation('previouspage'); }
		else if (e.keyCode == 37 && e.ctrlKey) { triggerPageNavigation('previousfast'); }

		// right arrow
		else if (e.keyCode == 39 && !e.ctrlKey) { triggerPageNavigation('nextpage'); }
		else if (e.keyCode == 39 && e.ctrlKey) { triggerPageNavigation('nextfast'); }
	}

	function triggerPageNavigation(direction) {
		
		// Find the first link for the given direction
		var el = document.querySelectorAll('a.' + direction);
		if (el.length && el.item(0)) {
		
			// Skip disabled links
			if (el.item(0).classList.contains('disabled'))
				return;
			
			// Simulate click
			el.item(0).click();
		}
	}
	
})();