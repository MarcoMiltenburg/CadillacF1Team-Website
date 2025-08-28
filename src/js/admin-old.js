
	function toggleDownloadedThumbnails() {

		var downloadedthumbnails = document.getElementById("downloadedthumbnails");
		if (downloadedthumbnails) {
			if (downloadedthumbnails.style.display == "block")
				downloadedthumbnails.style.display = "none";
			else
				downloadedthumbnails.style.display = "block";
			return false;
		}
		return true;

	}
