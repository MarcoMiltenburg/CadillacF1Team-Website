(function () {

	$(document).ready(function() {

		// Attach a change handler to the switch season selector to submit form when changes
		$('#switchseason').on('change', function() {
            $(this).closest('form').submit();
		});
    });

})();