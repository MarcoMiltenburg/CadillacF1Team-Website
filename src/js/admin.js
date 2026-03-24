    $(document).ready(function() {

		document.addEventListener('keydown', onKeyDown);

		function onKeyDown(e) {

			e = e || window.event;

			// Exit early if a modifier key was also pressed
			if (e.shiftKey || e.altKey || e.altKey || e.metaKey || e.ctrlKey)
				return;
			
			// escape
			if (e.keyCode == 27) { hidePartnersSelector(); }
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
			
			// Get the ID of the picture and save it
			var pictureid = $(this).data('pictureid');
			$('#partnerselector-pictureid').val(pictureid);

			// Clear all existing statusses in the popup
			$('#partnersselector a.partnerstoggle').removeClass('enabled');
			
			// Get the status link and update selected partners
			var statushref = $(this).data('statushref');
			updatePartners(statushref);
			
			showPartnersSelector();
            return false;
        });
		
		$('#partnersselector button.close, #overlay2').click(function(e) {
			e.preventDefault();
			hidePartnersSelector();
            return false;
		});
		
		$('#partnersselector a.partnerstoggle').click(function(e) {
			
			e.preventDefault();
			
			var basehref = $('#partnerselector-basehref').val();
			var group = $(this).data('group');
			if ((basehref != '') && (group != '')) {
				var link = addOrReplaceQueryStringParam(basehref, 'group', group);
				toggleExclusiveGroup(link, $(this));
			}
			
			return false;
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
						updatePartnerButtonState(true);
					}
					if (status == 'disabled') {
						el.removeClass('enabled');
						updatePartnerButtonState(false);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
				}
			});
		}
		
		function updatePartners(link) {
			
			$.ajax({
				type: 'POST',
				url: link,
				context: this,
				success: function (result) {
					
					if (result && result != '') {
						
						var partners = result.split(',');
						
						$('#partnersselector a.partnerstoggle').each(function() {
							var group = $(this).data('group');
							if (partners.includes(group)) {
								$(this).addClass('enabled');
							}
						});
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
				}
			});
		}
		
		function updatePartnerButtonState(atLeastOneEnabled)
		{
			// If we are not sure if one is enabled, check it
			if (!atLeastOneEnabled)
			{
				atLeastOneEnabled = $('#partnersselector .partnerstoggle').hasClass('enabled');
			}
			
			var pictureid = $('#partnerselector-pictureid').val();
			var buttonEl = $('#partnersselector-' + pictureid);
			
			if (atLeastOneEnabled)
			{
				buttonEl.addClass('enabled');
			} else {
				buttonEl.removeClass('enabled');
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
			$('#partnersselector').show();
		}
		
		function hidePartnersSelector() {
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
