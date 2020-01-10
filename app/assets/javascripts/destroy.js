$(document).on("turbolinks:load", function() {
  $('#article-destroy-modal').click(function(){
    if(!confirm('本当に削除しますか？')){
    }else{
      $('#article-destroy-trigger')[0].click();
    };
  });
});