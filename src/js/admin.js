    $(document).ready(function() {

        $('a.exclusivegroup').click(function(e) {

            e.preventDefault();

            var link = $(this).data('href');
            if (link != '') {

                $.ajax({
                    type: 'POST',
                    url: link + '&xml=yes',
                    dataType: 'xml',
                    context: this,
                    success: function (xml) {
                        var status = $(xml).find('status').text();
                        if (status == 'enabled') {
                            $(this).addClass('enabled');
                        }
                        if (status == 'disabled') {
                            $(this).removeClass('enabled');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
                    }
                });

            }

            return false;
        });

        $('a.togglepicturestatus').click(function(e) {

            e.preventDefault();

            var link = $(this).data('href');
            if (link != '') {

                $.ajax({
                    type: 'POST',
                    url: link + '?xml=yes',
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

    });
