	$(document).ready(function() {

		document.addEventListener('keydown', onKeyDown);

		var multipleImagesSelected = false;
		var partnersHaveBeenChanged = false;

		function onKeyDown(e) {

			e = e || window.event;

			// Exit early if a modifier key was also pressed
			if (e.shiftKey || e.altKey || e.altKey || e.metaKey || e.ctrlKey)
				return;

			// escape
			if (e.keyCode == 27) { hidePartnersSelector(false); }
		}

		$('a.exclusivegroup').click(function(e) {

			e.preventDefault();

			var link = $(this).data('href');
			if (link != '') {
				toggleExclusiveGroup(link, $(this));
			}

			return false;
		});

		$('a.partnersselector').click(function(e) {

			e.preventDefault();

			// Get the base link for the exclusive group toggle and save it
			var basehref = $(this).data('basehref');
			$('#partnerselector-basehref').val(basehref);

			// Get the set link for setting the exclusive groups and save it
			var setbasehref = $(this).data('setbasehref');
			$('#partnerselector-setbasehref').val(setbasehref);

			// Get the ID of the picture and save it
			var pictureid = $(this).data('pictureid');

			// Check if the user has selected multiple images
			var slide = $('#slide-' + pictureid);
			if (slide.hasClass('selected')) {

				multipleImagesSelected = true;
				partnersHaveBeenChanged = false;

				// Get the ID's of all the selected pictures and save it
				var pictureids = [];
				$('.thumbnails .slide.selected').each(function(index, el) {
					pictureids.push($(this).data('pictureid'));
				});

				var allpictureids = pictureids.join(',');
				$('#partnerselector-pictureid').val(allpictureids);
			}
			else
			{
				multipleImagesSelected = false;
				$('#partnerselector-pictureid').val(pictureid);
			}

			// Clear all existing statusses in the popup
			$('#partnersselector a.partnerstoggle').removeClass('enabled').addClass('disabled');

			// Set buttons in default state
			$('#partnersselector .selectall').show().attr('disabled', true);
			$('#partnersselector .unselectall').hide().attr('disabled', false);

			// Get the status link and update selected partners
			var statushref = $(this).data('statushref');
			updatePartners(statushref);

			showPartnersSelector();
			return false;
		});

		$('#partnersselector button.close, #overlay2').click(function(e) {
			e.preventDefault();
			hidePartnersSelector(true);
			return false;
		});

		$('#partnersselector a.partnerstoggle').click(function(e) {

			e.preventDefault();

			var group = $(this).data('group');

			if (multipleImagesSelected) {

				var enablegroups = [];
				var disablegroups = [];
				$('#partnersselector a.partnerstoggle').each(function(index, el) {
					var elgroup = $(el).data('group');
					if ($(el).hasClass('enabled')) {
						if (elgroup == group) {
							disablegroups.push(elgroup);
						} else {
							enablegroups.push(elgroup);
						}
					} else {
						if (elgroup == group) {
							enablegroups.push(elgroup);
						} else {
							disablegroups.push(elgroup);
						}
					}
				});

				var allenablegroups = enablegroups.join(',');
				var alldisablegroups = disablegroups.join(',');

				var pictureid = $('#partnerselector-pictureid').val();
				var setbasehref = $('#partnerselector-setbasehref').val();
				if ((setbasehref != '') && (pictureid != '') && (allenablegroups != '' || alldisablegroups != '')) {
					setbasehref += pictureid;
					setExclusiveGroups(setbasehref, allenablegroups, alldisablegroups);
					partnersHaveBeenChanged = true;
				}

			} else {

				var basehref = $('#partnerselector-basehref').val();
				if ((basehref != '') && (group != '')) {
					var link = addOrReplaceQueryStringParam(basehref, 'group', group);
					toggleExclusiveGroup(link, $(this));
				}

			}

			return false;
		});

		$('#partnersselector button.selectall').click(function(e) {

			e.preventDefault();

			var groups = [];
			$('#partnersselector a.partnerstoggle').each(function(index, el) {
				groups.push($(el).data('group'));
			});

			var allgroups = groups.join(',');

			var pictureid = $('#partnerselector-pictureid').val();
			var setbasehref = $('#partnerselector-setbasehref').val();
			if ((setbasehref != '') && (pictureid != '') && (allgroups != '')) {
				setbasehref += pictureid;
				setExclusiveGroups(setbasehref, allgroups, '');
			}

			return false;
		});

		$('#partnersselector button.unselectall').click(function(e) {

			e.preventDefault();

			var groups = [];
			$('#partnersselector a.partnerstoggle').each(function(index, el) {
				groups.push($(el).data('group'));
			});

			var allgroups = groups.join(',');

			var pictureid = $('#partnerselector-pictureid').val();
			var setbasehref = $('#partnerselector-setbasehref').val();
			if ((setbasehref != '') && (pictureid != '') && (allgroups != '')) {
				setbasehref += pictureid;
				setExclusiveGroups(setbasehref, '', allgroups);
			}

			return false;
		});

		$('.thumbnails .slide a').click(function(e) {
			if (e.shiftKey) {
				e.preventDefault();
				var parentslide = $(this).parent('.slide');
				if (parentslide.hasClass('selected')) {
					parentslide.removeClass('selected');
				} else {
					parentslide.addClass('selected');
				}
			}
		});

		$('a.togglepicturestatus').click(function(e) {

			e.preventDefault();

			var link = $(this).data('href');
			if (link != '') {

				link = addOrReplaceQueryStringParam(link, 'xml', 'yes');

				$.ajax({
					type: 'POST',
					url: link,
					dataType: 'xml',
					context: this,
					success: function (xml) {
						var status = $(xml).find('online').text();
						var isOnline = (status == 'enabled');
						var pictureid = $(this).data('pictureid');
						if (isOnline) {
							$('img#picture-id-' + pictureid).removeClass('deleted');
							$('li#delete-picture-id-' + pictureid).removeClass('hidden');
							$('li#undelete-picture-id-' + pictureid).addClass('hidden');
						} else {
							$('img#picture-id-' + pictureid).addClass('deleted');
							$('li#delete-picture-id-' + pictureid).addClass('hidden');
							$('li#undelete-picture-id-' + pictureid).removeClass('hidden');
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
					}
				});

			}

			return false;
		});

		function toggleExclusiveGroup(link, el) {

			link = addOrReplaceQueryStringParam(link, 'xml', 'yes');

			$.ajax({
				type: 'POST',
				url: link,
				dataType: 'xml',
				context: this,
				success: function (xml) {
					var status = $(xml).find('status').text();
					if (status == 'enabled') {
						el.addClass('enabled');
						updateSelectUnselectAll(false);
						updatePartnerButtonState(true);
					}
					if (status == 'disabled') {
						el.removeClass('enabled');
						updateSelectUnselectAll(false);
						updatePartnerButtonState(false);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
				}
			});
		}

		function setExclusiveGroups(link, groupson, groupsoff) {

			$.ajax({
				type: 'POST',
				url: link,
				data: { 'groups_on': groupson, 'groups_off': groupsoff },
				context: this,
				success: function (result) {

					if (result && result != '') {

						var partners = result.split(',');
						var allSelected = true;

						$('#partnersselector a.partnerstoggle').each(function() {
							var group = $(this).data('group');
							if (partners.includes(group)) {
								$(this).addClass('enabled');
							} else {
								$(this).removeClass('enabled');
								allSelected = false;
							}
						});

						updateSelectUnselectAll(allSelected);
						updatePartnerButtonState(false);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
				}
			});
		}

		function updatePartners(link) {

			if (multipleImagesSelected) {

				// Enable all partners, but leave them all unselected
				$('#partnersselector a.partnerstoggle').each(function() {
					var group = $(this).removeClass('disabled');
				});

				updateSelectUnselectAll(false);

			} else {

				// Call API to update status for partners
				$.ajax({
					type: 'POST',
					url: link,
					context: this,
					success: function (result) {

						if (result && result != '') {

							var partners = result.split(',');
							var allSelected = true;

							$('#partnersselector a.partnerstoggle').each(function() {
								var group = $(this).removeClass('disabled').data('group');
								if (partners.includes(group)) {
									$(this).addClass('enabled');
								} else {
									allSelected = false;
								}
							});

							updateSelectUnselectAll(allSelected);
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
					}
				});
			}
		}

		function updatePartnerButtonState(atLeastOneEnabled)
		{
			// If we are not sure if one is enabled, check it
			if (!atLeastOneEnabled)
			{
				atLeastOneEnabled = $('#partnersselector .partnerstoggle').hasClass('enabled');
			}

			var pictureid = $('#partnerselector-pictureid').val();
			var pictureids = pictureid.split(',');

			pictureids.forEach((id) => {
				if (atLeastOneEnabled)
				{
					$('#partnersselector-' + id).addClass('enabled');
				} else {
					$('#partnersselector-' + id).removeClass('enabled');
				}
			});
		}

		function updateSelectUnselectAll(allSelected) {

			// If we know all are selected, we can skip the check
			if (!allSelected) {

				allSelected = true;
				$('#partnersselector a.partnerstoggle').each(function(index, el) {
					allSelected &= $(el).hasClass('enabled');
				});
			}

			if (allSelected) {
				$('#partnersselector .selectall').hide();
				$('#partnersselector .unselectall').show();
			} else {
				$('#partnersselector .selectall').show().attr('disabled', false);
				$('#partnersselector .unselectall').hide();
			}
		}

		function showOverlayNonAnimated() {
			$('#overlay2').css({ opacity: 0.4, display: 'block' });
			$.scrollLock(true);
		}

		function hideOverlayNonAnimated() {
			$('#overlay2').css({ opacity: 0, display: 'none' });
			$.scrollLock(false);
		}

		function showPartnersSelector() {
			showOverlayNonAnimated();

			if (multipleImagesSelected) {
				$('#partnersselector .multiple-text').show();
			} else {
				$('#partnersselector .multiple-text').hide();
			}

			$('#partnersselector').show();
		}

		function hidePartnersSelector(unselectMultipleImages) {

			if (unselectMultipleImages && partnersHaveBeenChanged) {

				// Get all the selected pictures and unselect them
				$('.thumbnails .slide.selected').each(function(index, el) {
					$(el).removeClass('selected');
				});
			}

			$('#partnersselector').hide();
			hideOverlayNonAnimated();
		}

		function addOrReplaceQueryStringParam(urlStr, param, value) {

			try {
				var url = new URL(urlStr, window.location.href);
				url.searchParams.set(param, value);
				return url.href;
			}
			catch (err) {
				return urlStr;
			}
		}

	});
