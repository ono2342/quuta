$(document).on("turbolinks:load", function() {
  function changeLiked(){
    $(".article-like-button-text").text("いいね済み");
    $(".article-like-button").css('background-color','#F4AC5A');
    $(".article-like-button").css('color','#FFF');
    $('.article-like-button').addClass('article-unlike-button');
    $('.article-like-button').removeClass('article-like-button');
  }

  function changeUnlike(){
    $(".article-like-button-text").text("いいね");
    $(".article-unlike-button").css('background-color','#FFF');
    $(".article-unlike-button").css('color','#F4AC5A');
    $('.article-unlike-button').addClass('article-like-button');
    $('.article-unlike-button').removeClass('article-unlike-button');
  }
  
  // いいね時に解除ボタンに切り替え
  $(document).on('click','.article-like-button', function() {
    var articleId = $(".articles").data("id");
    $.ajax({
      type: "post",
      url: "/likes/like",
      data: {article_id: articleId},
      dataType: "json",
    })
    .done(function(i){ 
      changeLiked();
      var likes = $(".likes-count").data("like");
      likes += 1;
      $(".likes-count").data("like",likes);
      $(".likes-count").text(likes);
    })
    .fail(function(){
      alert("いいねに失敗しました");
    })
  });

  // 解除時にいいねボタンに切り替え
  $(document).on('click','.article-unlike-button', function() {
    var articleId = $(".articles").data("id");
    $.ajax({
      type: "post",
      url: "/likes/unlike",
      data: {article_id: articleId},
      dataType: "json",
    })
    .done(function(i){ 
      changeUnlike();
      var likes = $(".likes-count").data("like");
      likes -= 1;
      $(".likes-count").data("like",likes);
      $(".likes-count").text(likes);
    })
    .fail(function(){
      alert("解除に失敗しました");
    })
  });

})