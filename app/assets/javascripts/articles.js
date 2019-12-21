$(document).on("turbolinks:load", function() {
  var old = ""
  var v = ""

  function Load() {
    if(document.URL.match("articles/new")) {
      var el = $("#article_text")[0];
      replaceMarkdown(el);

    }
  }
  function replaceMarkdown(elm) {
    var v = elm.value;
    if (old != (v = elm.value)) {
      old = v;
      str = $("#article_text").val();
      $("#marked-area").html(marked(str));
    }
  }
  $("#article_text").on("keyup",function () {
    replaceMarkdown(this);
  });
  
  $(function(){
    $('#article_text').inlineattachment({
      urlText: '![]({filename})\n',
      uploadUrl: "/articles/image",
      uploadFieldName: "images[image]",
      allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
      extraHeaders: {"X-CSRF-Token": $("meta[name=csrf-token]").attr("content")},
    });
  });
  setInterval(Load, 1000);
});