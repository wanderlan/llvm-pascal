function startTwitter() {
  $('.twitterapp').addClass('loading');
  $("<ul/>").addClass('twitterapplist').appendTo('.twitterapp');
  $.getJSON("/twitterfeed.html",
        function(data) {
          $('.twitterapp').removeClass('loading');
          var num = 0;
          $.each(data, function(i, item) {
            if (item.text[0] == "@") return;
            $("<li/>").html(twitterStatus(item)).appendTo(".twitterapplist");
            if (num++ == 5) return false;
          });
          if ($('#content').height() < $('#nav').height()) {
            if (!$('#wrapper').hasClass('wide')) {
              $('#wrapper').css('background', '#fff');
            }
          }
        });


}

function twitterStatus(item) {
  var text = item.text;
  text = text.replace(/(https?:\/\/[^ ,!;?]+)(?:[,.!;\)\]-](\s|$)|$)/g, "<a href='$1'>$1</a>$2");
  text = text.replace(/#([^ ,!;?]+)\b/g, "#<a href='http://search.twitter.com/search?q=%23$1'>$1</a>");
  text = text.replace(/@([^ ,!;?]+)\b/g, "@<a href='http://twitter.com/$1'>$1</a>");
  text = text + " <small>" + twitterSince(item) + " | <a href='http://twitter.com/lsegal/status/" + item.id + "'>link</a></small>";
  return text;
}

function twitterSince(item) {
  var now = new Date();
  var date = Date.parse(item.created_at);
  var diff = parseInt(now.getTime() / 1000) - parseInt(date / 1000);
  var time = "";
  if (diff >= 86400) {
    time = parseInt(diff / 86400.0) + "d";
  }
  else if (diff >= 3600) {
    time = parseInt(diff / 3600.0) + "h";
  }
  else if (diff >= 60) {
    time = parseInt(diff / 60.0) + "m";
  }
  else {
    time = diff + "s";
  }
  return time + " ago";
}

$(startTwitter);
