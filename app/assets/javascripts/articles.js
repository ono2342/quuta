window.onload = function() {
  new Vue({
    el: '#editor',
    data: {
    input: '',
    },
    filters: {
    marked: marked,
    },
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
};