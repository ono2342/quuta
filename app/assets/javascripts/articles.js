$(document).on("turbolinks:load", function() {
  var old = ""
  var v = ""

  function Load() {       //画像プレビュー
    if(document.URL.match("articles")) {
      var el = $("#article_text")[0];
      replaceMarkdown(el);
    }
  }
  function replaceMarkdown(elm) {      //マークダウンプレビュー
    var v = elm.value;
    if (old != (v = elm.value)) {
      old = v;
      str = $("#article_text").val();
      $("#marked-area").html(marked(str));
    }
  }
  $("#article_text").on("keyup",function () {     //keyupで発火
    replaceMarkdown(this);
  });
  
  $(function(){
    $('#article_text').inlineattachment({      //画像ドラッグドロップ
      urlText: '![]({filename})\n',
      uploadUrl: "/articles/image",
      uploadFieldName: "images[image]",
      allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
      extraHeaders: {"X-CSRF-Token": $("meta[name=csrf-token]").attr("content")},
    });
  });
  setInterval(Load, 1000);

  $(document).on('change','input[type=file]', function() {     //inputタグで画像選択
    var formData = new FormData();
    if ($("input[name='images']").val()!== '') {
      formData.append( "image", $("input[name='images']").prop("files")[0] );
    }
    $.ajax({       //コントローラーに送る
      type: "post",
      url: "/articles/image2",
      processData: false,
      contentType: false,
      data: formData,
      dataType: "json",
    })
    .done(function(image){      //画像データをフォームに反映
      var image = (image.url);
      var textarea = document.querySelector('#article_text');
      var sentence = textarea.value;
      var len      = sentence.length;
      var pos      = textarea.selectionStart;

      var before   = sentence.substr(0, pos);
      var word     = '![](' + image + ')\n';
      var after    = sentence.substr(pos, len);
      textarea.value = before + word + after;
    })
    .fail(function(){       //アラート
      alert("画像の取得に失敗しました");
    })
  });
});