		$('body').on('click', '#content', function() {
			$('#profile-dropdown', window.parent.document).css("display", "none");
			$('.profileInfo a', window.parent.document).removeClass("active");			
			});