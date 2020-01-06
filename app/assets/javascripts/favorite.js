$(document).on("turbolinks:load", function() {
  function changeFavorited(){
    $(".article-favorite-button-text").text("お気に入り済み");
    $(".article-favorite-button").css('background-color','#F4AC5A');
    $(".article-favorite-button").css('border','0.1rem solid #F4AC5A');
    $(".fa-star").css('color','#FFFF01');
    $('.article-favorite-button').addClass('article-unfavorite-button');
    $('.article-favorite-button').removeClass('article-favorite-button');
  }
  
  function changeUnfavorite(){
    $(".article-favorite-button-text").text("お気に入り");
    $(".article-unfavorite-button").css('background-color','#777');
    $(".article-unfavorite-button").css('border-color','#777');
    $(".fa-star").css('color','#FFF');
    $('.article-unfavorite-button').addClass('article-favorite-button');
    $('.article-unfavorite-button').removeClass('article-unfavorite-button');
  }
  
  // お気に入り時に解除ボタンに切り替え
  $(document).on('click','.article-favorite-button', function() {
    var articleId = $(".articles").data("id");
    $.ajax({
      type: "post",
      url: "/favorites/favorite",
      data: {article_id: articleId},
      dataType: "json",
    })
    .done(function(i){
      changeFavorited();
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });

  // 解除時にいいねボタンに切り替え
  $(document).on('click','.article-unfavorite-button', function() {
    var articleId = $(".articles").data("id");
    $.ajax({
      type: "post",
      url: "/favorites/unfavorite",
      data: {article_id: articleId},
      dataType: "json",
    })
    .done(function(i){ 
      changeUnfavorite();
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });
})