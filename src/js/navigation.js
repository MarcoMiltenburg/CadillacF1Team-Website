(function () {
	
	function hideMenu() {
		$('#navtoggle').each(function() {
			if (this.checked) {
				$(this).click();
			}
		});
	}

	function showOverlay() {
		$('#overlay').css({ opacity: 0, display: 'block' });
		setTimeout(function() {
			$('#overlay').css({ opacity: 0.4 });
		}, 1);
		$.scrollLock(true);
	}
	
	function hideOverlay() {
		$('#overlay').css({ opacity: 0 });
		setTimeout(function() {
			$('#overlay').css({ display: 'none' });
		}, 500);
		$.scrollLock(false);
	}

	$(document).ready(function() {

		// Atach a click handler to the overlay to hide menu when clicked
		$('#overlay').on('click', function() {
			hideMenu();
		});

		// Atach a touchend handler to the overlay to hide menu when touched
		$('#overlay').on('touchend', function() {
			hideMenu();
		});
		
		// Attach a click handler to the menu to show/hide overlay
		$('#navtoggle').on('click', function(e) {
			if (this.checked) {
				showOverlay();
			} else {
				hideOverlay();
			}
		});

		// Atach a click handler to all navigation links to hide menu when clicked
		$('nav a').on('click', function() {
			hideMenu();
		});
		
	});

    $(document).on('keyup', function(e) {
        if (e.key == "Escape")
            hideMenu();
    });

})();