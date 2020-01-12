$(document).on("turbolinks:load", function() {
  function changeUnfollow(target){
    target.text("フォロー中");
    target.css('background-color','#F4AC5A');
    target.css('color','#FFF');
    target.addClass('userUnfollowButton_inner');
    target.removeClass('userFollowButton_inner');
  }

  function changeFollow(target){
    var parent = target.parent();
    parent.empty()
    var html = $(`<button class="btn btn-default btn-block userFollowButton_inner btn-xs">
                  <i class="i fa fa-user-plus"></i>
                  フォロー
                  </button>`);
    parent.append(html);
  }
  
  // フォロー時に解除ボタンに切り替え
  $(document).off('click','.userFollowButton_inner')
  $(document).on('click','.userFollowButton_inner', function() {
    var target = $(this);
    var userId = target.parent().data("id");
    $.ajax({
      type: "post",
      url: "/relations/follow",
      data: {user_id: userId},
      dataType: "json",
    })
    .done(function(i){ 
      changeUnfollow(target);
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });

  // 解除時にフォローボタンに切り替え
  $(document).off('click','.userUnfollowButton_inner')
  $(document).on('click','.userUnfollowButton_inner', function() {
    var target = $(this);
    var userId = target.parent().data("id");
    $.ajax({
      type: "post",
      url: "/relations/unfollow",
      data: {user_id: userId},
      dataType: "json",
    })
    .done(function(i){ 
      changeFollow(target);
    })
    .fail(function(){
      alert("ログインしてください");
      window.location.href = "/login";
    })
  });

  // ボタンホバー時の挙動
  $(document).on("mouseenter", ".userUnfollowButton_inner", function () {
    $(this).css('background-color','#c9302c');
    $(this).text("解除");
  });
  $(document).on("mouseleave", ".userUnfollowButton_inner", function () {
      $(this).text("フォロー中");
      $(this).css('background-color','#F4AC5A');
  });

})