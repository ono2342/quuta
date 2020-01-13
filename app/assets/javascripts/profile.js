$(document).on("turbolinks:load", function() {
  function changeFavorited(target){
    target.css('background-color','#F4AC5A');
    target.css('border','0.2rem solid #F4AC5A');
    target.css('color','#FFFF01');
    target.addClass('article-favorited');
    target.removeClass('article-favorite');
  }
  
  function changeUnfavorite(target){
    target.css('background-color','#777');
    target.css('border','0.2rem solid #777');
    target.css('color','#FFF');
    target.addClass('article-favorite');
    target.removeClass('article-favorited');
  }
  
  // お気に入り時に解除ボタンに切り替え
  $(document).off('click','.article-favorite')
  $(document).on('click','.article-favorite', function() {
    var target = $(this);
    var articleId = target.data("id");
    $.ajax({
      type: "post",
      url: "/favorites/favorite",
      data: {article_id: articleId},
      dataType: "json",
    })
    .done(function(i){
      changeFavorited(target);
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });

  // 解除時にいいねボタンに切り替え
  $(document).off('click','.article-favorited')
  $(document).on('click','.article-favorited', function() {
    var target = $(this);
    var articleId = target.data("id");
    $.ajax({
      type: "post",
      url: "/favorites/unfavorite",
      data: {article_id: articleId},
      dataType: "json",
    })
    .done(function(i){ 
      changeUnfavorite(target);
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });
})