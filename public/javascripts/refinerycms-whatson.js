$(document).ready(function(){
  $('#show_whatson_post').height($('#show_whatson_post').height());
  
  $('#next_prev_article a:not(".home")').live('click', function(){
    url = this.href + ".js";
    $('#show_whatson_post > *').fadeOut();
    $.ajax({
      url: url,
      success: function(data) {
        $('#show_whatson_post').html(data);
        new_height = 0;
        $('#show_whatson_post > *').each(function(){
          new_height += $(this).height()
        });
        $('#show_whatson_post').animate({
          height: new_height
        });
      }
    });
    $('html, body').animate({
      scrollTop: $('body').offset().top
    }, 2000);
    return false;
  })
})