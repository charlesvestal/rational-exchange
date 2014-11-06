// Website Scripts

$(document).ready(function(){

	// google play and app store button hovers
$("a.appstore_button, a.google_play_button, .footer_social_icons a, .team_member_social_icons a").fadeTo("fast", 1.0); 
$("a.appstore_button, a.google_play_button, .footer_social_icons a, .team_member_social_icons a").hover(function(){
$(this).fadeTo("fast", 0.6); 
},function(){
$(this).fadeTo("fast", 1.0); 
});



$(".section_one_iphone_one, .section_one_iphone_two, .section_one_iphone_three").hover(
function () {
$(this).animate({
marginTop: '0px',
height:'462px'
}, 500, function() {
}); 
},
function () {
$(this).animate({
marginTop: '40px',
height:'422px'
}, 500, function() {
});  
});

});


// fade in headers

$(window).bind("load", function() {

$(".loading_screen").fadeOut(0);


// setTimeout(function(){
//
// $(".iphone_hand").show().addClass('animated fadeInUpBig');
// }, 1100);
//
// setTimeout(function(){
// $(".header_right_column").show().addClass('animated fadeInUpBig');
//
// }, 200);

});




