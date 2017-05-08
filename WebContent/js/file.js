
(function($) {       
	$.imageFileVisible = function(options) {     
		var defaults = {    
			wrapSelector: null,    
			//<input type=file />
  			fileSelector:  null ,
  			width : '100%',
  			height: 'auto',
  			errorMessage: "This is not a image file."
 		};    
 		// Extend our default options with those provided.    
 		var opts = $.extend(defaults, options);     
 		$(document).on("change",opts.fileSelector,function(){
			var file = this.files[0];
			var imageType = /image.*/;
			if (file.type.match(imageType)) {
						
				var reader = new FileReader();
				reader.onload = function(){
					var img = new Image();
					img.src = reader.result;
					$(img).width( opts.width);
					$(img).height( opts.height);
					$( opts.wrapSelector ).empty();
					$( opts.wrapSelector ).css("background","none");
					$( opts.wrapSelector ).append(img);
					$( opts.wrapSelector ).siblings("input").attr("disabled","disabled");
					
					var oP = "<p style='background-image:url(images/Dustbin.png); background-position:center center; cursor:pointer; background-repeat:no-repeat; position:absolute; width:100%; height:33px; background-color:rgba(0,0,0,.5); bottom:0;'></p>"
					$( opts.wrapSelector ).append(oP);
					
				};
				reader.readAsDataURL(file);
			}
			else
			{
				alert(opts.errorMessage);
			}
		});
	};     
})(jQuery); 

//(function($){
//	$.fileVisible = function(option) {
//		var default1 = {
//			wrapSelector1 : null,
//			fileSelector1 : null,
//			width : '100%',
//			height : 'auto',
//			errorMessage : 'This is not a installation package.'

//		};
//		var opt = $.$.extend(default1, option);
//		$(document).on("change",opt.fileSelector1, function(){
//			var file1 = this.files[0];
//			var pageType = / .*/;
//			if (file1.type.match(pageType)) {
//				var reader1 = new FileReader();
//				reader1.onload = function(){
//					//
//				}
//			}
//		})
//		
//	}
//})
