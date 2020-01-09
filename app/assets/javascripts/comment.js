$(document).on("turbolinks:load", function() {
  $(".preview-area").hide();
  
  function replaceMarkdown() {      //マークダウンプレビュー
    str = $("#comment").val();
    $(".preview-area").html(marked(str));
  }
  document.getElementById("comment_preview").onclick = function() {  // プレビューをクリックで発火
    $(".preview-area").show();
    $(".commentForm_area, .commentForm_imageUploader-button, .commentForm_imageUploader-text").hide();
    replaceMarkdown();
  };
  
  $(function(){
    $('#comment').inlineattachment({      //画像ドラッグドロップ
      urlText: '![]({filename})\n',
      uploadUrl: "/articles/image",
      uploadFieldName: "images[image]",
      allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
      extraHeaders: {"X-CSRF-Token": $("meta[name=csrf-token]").attr("content")}
    });
  });

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
      var textarea = document.querySelector('#comment');
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

  document.getElementById("comment_edit").onclick = function() {  // プレビューをクリックで発火
    $(".preview-area").hide();
    $(".commentForm_area, .commentForm_imageUploader-button, .commentForm_imageUploader-text").show();
  };
  
  $(".commentForm_tab").on("click",function(){  //タブ切り替え
    var $th = $(this).index();
    $(".commentForm_tab").removeClass("active");
    $(this).addClass("active");
  });

  $(function () {
    $('.fa-comment').click(function() {  //コメントのアイコンをクリックでスクロール
         var speed = 200;
         var href= $(this).attr("href");
         var target = $(href == "#" || href == "" ? 'html' : href);
         var position = target.offset().top;
         $('body,html').animate({scrollTop:position}, speed, 'swing');
         return false;
    });
 });
});