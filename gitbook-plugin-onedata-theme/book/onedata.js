window.ONEDATA_DOC_VERSION = null;

(function($) {
  $.fn.changeElementType = function(newType) {
    var attrs = {};

    $.each(this[0].attributes, function(idx, attr) {
        attrs[attr.nodeName] = attr.nodeValue;
    });

    this.replaceWith(function() {
        return $("<" + newType + "/>", attrs).append($(this).contents());
    });
  };
})(jQuery);


function includeGeneratedSwaggerHTML(fun) {
  if ( $(".x-swagger-reference").length ) {
    $.get( $(".x-swagger-reference").attr('x-swagger-reference-html'), function(data) {
     $('.x-swagger-reference').html(data);
     fun();
    });
  }
  else {
    fun();
  }
}

require(["gitbook"], function(gitbook) {
    gitbook.events.bind("page.change", function() {


      includeGeneratedSwaggerHTML(
        function() {

            // apply nanoscroller on left navigation
            $('nav').addClass('nano');
            $('.summary').addClass('nano-content');

            // apply nanoscroller on conent
            // $('.book-body').addClass('nano');
            // $('.body-inner').addClass('nano-content');

            $('.nano').nanoScroller({alwaysVisible: true});


            /// Add a onedata logo before link to index
            // Note: it must exist in a gitbook files
            var headingPath = gitbook.state.bookRoot + '/doc/img/heading.png';
            var indexLink = $('[data-path="index.html"] a');
            indexLink.before('<a href="/" class="header-logo"><img src="'+headingPath+'" /></a>');
            $('.header-logo').on('click', function(e) { e.stopPropagation(); });
            indexLink.html('documentation');

            /// Remove all li's from summary which are not chapters (!)
            $('.summary').find('li:not(.chapter)').remove();

            /// Disable anchors in headings (for remove glossaries)
            var unAnchorize = function() {
              $(this).html($(this)[0].innerHTML.replace(/<a.*?>(.*?)<\/a>/g, '$1'));
            };
            for (var i=1; i<=5; ++i) {
              var headers = $('.page-inner h'+i);
              if (headers) {
                headers.each(unAnchorize);
              }
            }


            /// Remove some top-bar buttons
            $('.font-settings').remove();
            $('.pull-right').remove();

            /// Remove heading in top-bar when hovered
            $('.book-header h1').remove();

            /// Make TOC parent active too - an extension of toggle chapters plugin
            $('.articles .chapter.active').parents('.chapter').addClass('active');

            /// Mark some TOC parents as no-children
            $('.summary .chapter').each(function() {
              if ($(this).find('li').length === 0) {
                $(this).addClass('no-children');
              }

              if ($(this).find('li > a').length === 0) {
                $(this).addClass('no-content-children');
              }
            });

            /// Change span non-existent chapters in TOC to active
            $('.summary .chapter').not('.no-children').find('> span').each(function() {
              var firstChildLink = $(this).parent().find('.chapter > a')[0];
              var href = firstChildLink && $(firstChildLink).attr('href') || '#';
              $(this).attr('href', href);
              $(this).changeElementType('a');
            });

            /// Add doc version string if provided
            if (window.ONEDATA_DOC_VERSION) {
              var summary = $('.summary');
              summary.before('<div class="version-string"><strong>Version:</strong> ' +
                window.ONEDATA_DOC_VERSION + '</div>');
            }


        }
      );



    });

    gitbook.events.bind("exercise.submit", function() {
        // do something
    });
});
