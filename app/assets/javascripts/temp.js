/*
 * The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
 * and is licensed under the GNU General Public License, version 3. Some components are 
 * third party components that are licensed under the MIT license or other terms. 
 * See https://github.com/DigitalNZ/supplejack_website for details. 
 * 
 * Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
 * http://digitalnz.org/supplejack
 */


// Add 
$('.toggle-add-panel').click(function() {
   $(this).parent('.add-panel').find('.add-panel-inset').slideToggle();
   $(this).parent('.add-panel').toggleClass('add-panel-active');
});


// Set up ContentTools inline editor
window.addEventListener('load', function() {

    var editor;

	ContentTools.StylePalette.add([
	    new ContentTools.Style('Author', 'author', ['p'])
	]);

	editor = ContentTools.EditorApp.get();
	editor.init('*[data-editable]', 'data-name');

	// SAVING PAGE EDITS
	editor.bind('save', function (regions) {
	    var name, onStateChange, payload, xhr;

	    // Set the editor as busy while we save our changes
	    this.busy(true);

	    // Collect the contents of each region into a FormData instance
	    payload = new FormData();
	   	payload.append('content', JSON.stringify(regions));

	    // Send the update content to the server to be saved
	    onStateChange = function(ev) {
	        // Check if the request is finished
	        if (ev.target.readyState == 4) {
	            editor.busy(false);
	            if (ev.target.status == '200') {
	                // Save was successful, notify the user with a flash
	                new ContentTools.FlashUI('ok');
	            } else {
	                // Save failed, notify the user with a flash
	                new ContentTools.FlashUI('no');
	            }
	        }
	    };

	    xhr = new XMLHttpRequest();
	    xhr.addEventListener('readystatechange', onStateChange);
	    xhr.open('PUT', window.location.pathname);
	    xhr.send(payload);
	});

});

