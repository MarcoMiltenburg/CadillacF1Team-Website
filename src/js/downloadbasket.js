(function() {
    
    $(document).ready(function() {

        // Atach a click handler to all 'basket' links
        $('a.addbasket, a.addall').click(function() {

            // Make sure we have a href link
            var link = $(this).attr('href');
            if (link != '') {

                // Call it with ajax by adding '&xml=yes' to it
                $.ajax({
                    type: 'POST',
                    url: link + '&xml=yes',
                    dataType: 'xml',

                    // Success
                    success: function (xml) {

                        var totalpictures = $(xml).find('totalpictures').text();
                        var errormessage = $(xml).find('errormessage').text();
                        var haserror = errormessage && errormessage.length > 0;

                        var el = $('#downloadbasket');
                        flashDownloadBasket(el.find('div'), haserror);

                        var text = totalpictures + ' photo' + (totalpictures !== '1' ? 's' : '');

                        el.attr('data-count', totalpictures);
                        el.find('em').each(function() {
                          $(this).text(text);
                        });
                        
                        if (haserror) {
                            alert(errormessage);
                        }
                    },

                    // Error
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert("Error " + jqXHR.status + ": " + jqXHR.statusText);
                    }

                });

                return false;
            }

        });

    });
    
    function flashDownloadBasket(el, haserror) {
        
        el.removeClass('added').removeClass('error');
        setTimeout(function() {
            
            if (haserror) {
                el.addClass('error');
            } else {
                el.addClass('added');
            }
            
        }, 20);
    }

})();