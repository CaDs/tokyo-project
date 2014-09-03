( function( $ ) {

	// Setup variables
	$window = $(window);
	$slide = $('.homeSlide');
	$body = $('body');

    //FadeIn all sections
	$body.imagesLoaded( function() {
		setTimeout(function() {
		      // Resize sections
		      adjustWindow();
		      // Fade in sections
			  $body.removeClass('loading').addClass('loaded');
		}, 800);
	});

	function adjustWindow(){
		// Init Skrollr
		// Get window size
	    winH = $window.height();
	    // Keep minimum height 550
	    if(winH <= 550) {
			winH = 550;
		}
	   // $slide.height(winH);
	}
} )( jQuery );