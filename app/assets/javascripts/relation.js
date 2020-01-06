$(document).on("turbolinks:load", function() {
  function changeUnfollow(){
    var html = $( `<button class="btn btn-primary btn-block userUnfollowButton_inner btn-xs">
                    フォロー中
                  </button>
                    `);
    $(".userFollowButton").append(html);
  }

  function changeFollow(){
    var html = $( ` <button class="btn btn-default btn-block userFollowButton_inner btn-xs">
                    <i class="i fa fa-user-plus"></i>
                    フォロー
                    </button>`);
    $(".userFollowButton").append(html);
  }
  
  // フォロー時に解除ボタンに切り替え
  $(document).on('click','.userFollowButton_inner', function() {
    var articleUserId = $(".userFollowButton").data("id");
    $.ajax({
      type: "post",
      url: "/relations/follow",
      data: {user_id: articleUserId},
      dataType: "json",
    })
    .done(function(i){ 
      $(".userFollowButton").empty();
      changeUnfollow();
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });

  // 解除時にフォローボタンに切り替え
  $(document).on('click','.userUnfollowButton_inner', function() {
    var articleUserId = $(".userFollowButton").data("id");
    $.ajax({
      type: "post",
      url: "/relations/unfollow",
      data: {user_id: articleUserId},
      dataType: "json",
    })
    .done(function(i){ 
      $(".userFollowButton").empty();
      changeFollow();
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });

  // ボタンホバー時の挙動
  $(document).on("mouseenter", ".btn-primary", function () {
    $(".btn-primary").css('background-color','#c9302c');
    $('.btn-primary').text("解除");
  });
  $(document).on("mouseleave", ".btn-primary", function () {
      $(".btn-primary").text("フォロー中");
      $(".btn-primary").css('background-color','#F4AC5A');
  });

})