$(document).on("turbolinks:load", function() {
  $('#article-destroy-modal').click(function(){  //投稿記事の削除
    if(!confirm('本当に削除しますか？')){
      return false;
    }else{
      $('#article-destroy-trigger')[0].click();
    };
  });
  
  $('#comment-destroy-modal').click(function(){  //コメントの削除
    if(!confirm('本当に削除しますか？')){
      return false;
    }else{
      $('#comment-destroy-trigger')[0].click();
    };
  });
});