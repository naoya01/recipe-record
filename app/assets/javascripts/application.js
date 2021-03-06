// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require Chart.min
//= require rails-ujs
//= require cocoon
//= require activestorage
//= require turbolinks
//= require moment
//= require fullcalendar
//= require_tree .


  $(document).on('turbolinks:load', function () {

    $(".l-nav_btn").on("click", function () {
      $(".l-nav_btn_bar").toggleClass("open");
      $(".l-nav").toggleClass("show");
      $(".l-nav_btn").toggleClass("show_btn");
      $("#calendar").fadeToggle();
    });

    $(".top-btn").on("click", function () {
      let header = $("body").offset().top;
      $("html,body").animate({ scrollTop: header });
    });
    let topBtn = $(".top-btn");
    topBtn.hide();
    $(window).scroll(function () {
      if ($(this).scrollTop() > 300) {
        topBtn.fadeIn();
      } else {
        topBtn.fadeOut();
      }
      return false;
    });

    $(".usage-container_title").on("click",function(){
      $(this).next().slideToggle();
    });

    //一覧の並び方
    let $grid = $(".cooking_list"),
      emptyCells = [],
      i;
    // 子パネル (li.cell) の数だけ空の子パネル (li.cell.is-empty) を追加する。
    for (i = 0; i < $grid.find(".cooking_list_item").length; i++) {
      emptyCells.push($("<li>", { class: "cooking_list_item is-empty" }));
    }
    $grid.append(emptyCells);

    var url = location.href;
    // メディアクエリ
    media();
    $(window).on("resize", function () {
      media();
    });

    var url = location.href;
    // メディアクエリ
    function media() {
      // 横幅を取得
      let width = $(window).width();
      if (width > 771) {
        let beforePos = 0; //スクロールの値の比較用の設定
        $(".l-nav_btn_bar").removeClass("open");
        $(".l-nav").removeClass("show");
        $(".l-nav_btn").removeClass("show_btn");

        //スクロール途中でヘッダーが消え、上にスクロールすると復活する設定を関数にまとめる
        function ScrollAnime() {
          let scroll = $(window).scrollTop();
          let nav_height = $(".l-header").outerHeight();
          //ヘッダーの出し入れをする
          // $("html").css("padding-top", nav_height);

          if (scroll < 1) {
            //ヘッダーが一番上の時
            $(".l-header").removeClass("DownMove"); //.l-headerにDownMoveというクラス名を除き
            $(".l-header").removeClass("UpMove"); //.l-headerにDownMoveというクラス名を除き
          } else if (0 < scroll - beforePos) {
            //下にスクロールした時ヘッダーが上に消える
            $(".l-header").removeClass("DownMove"); //.l-headerにDownMoveというクラス名を除き
            $(".l-header").addClass("UpMove"); //.l-headerにUpMoveのクラス名を追加
          } else {
            // 上にスクロールした時ヘッダーが上から出現
            $(".l-header").removeClass("UpMove"); //.l-headerにUpMoveというクラス名を除き
            $(".l-header").addClass("DownMove"); //.l-headerにDownMoveのクラス名を追加
            $(".l-header").removeClass("inv");
          }

          beforePos = scroll; //現在のスクロール値を比較用のbeforePosに格納
        }
        // 画面をスクロールをしたら動かしたい場合の記述
        $(window).scroll(function () {
          ScrollAnime(); //スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ
        });

        // ページが読み込まれたらすぐに動かしたい場合の記述
        $(window).on("load", function () {
          ScrollAnime(); //スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ

          $(".top-visual_btn_login").hover(
            function () {
              $(".top-visual_btn_register").addClass("top-btn_remove");
              $(".top-visual_btn_login").addClass("top-btn_add");
              $(".l-header,.l-footer").addClass("top-change_bar_login");
            },
            function () {
              setTimeout(function () {
                if ($(".top-visual_btn_login").hasClass("top-btn_add") == false) {
                  $(".top-visual_btn_register").removeClass("top-btn_remove");
                }
              }, 400);
              $(".top-visual_btn_login").removeClass("top-btn_add");
              $(".l-header,.l-footer").removeClass("top-change_bar_login");
            }
          );

          $(".top-visual_btn_register").hover(
            function () {
              $(".top-visual_btn_login").addClass("top-btn_remove");
              $(".top-visual_btn_register").addClass("top-btn_add");
              $(".l-header,.l-footer").addClass("top-change_bar_register");
            },
            function () {
              setTimeout(function () {
                if (
                  $(".top-visual_btn_register").hasClass("top-btn_add") == false
                ) {
                  $(".top-visual_btn_login").removeClass("top-btn_remove");
                }
              }, 400);
              $(".top-visual_btn_register").removeClass("top-btn_add");
              $(".l-header,.l-footer").removeClass("top-change_bar_register");
            }
          );
        });
      } else if (width <= 770) {
        $(".l-header").removeClass("inv");

        let beforePos = 0; //スクロールの値の比較用の設定

        //スクロール途中でヘッダーが消え、上にスクロールすると復活する設定を関数にまとめる
        function ScrollAnime() {
          let scroll = $(window).scrollTop();
          let nav_height = $(".l-header").outerHeight();

          if (scroll < nav_height) {
            $(".l-header").removeClass("inv");
            $(".l-header").removeClass("DownMove"); //.l-headerにDownMoveというクラス名を除き
            $(".l-header").removeClass("UpMove"); //.l-headerにUpMoveというクラス名を除き
            //IE11対策で処理を入れない
          } else if (0 < scroll - beforePos) {
            //下にスクロールした時ヘッダーが上に消える

              $(".l-header").removeClass("DownMove"); //.l-headerにDownMoveというクラス名を除き
              $(".l-header").removeClass("UpMove"); //.l-headerにUpMoveというクラス名を除き

          }

          beforePos = scroll; //現在のスクロール値を比較用のbeforePosに格納
        }
        // 画面をスクロールをしたら動かしたい場合の記述
        $(window).scroll(function () {
          ScrollAnime(); //スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ
        });

        // ページが読み込まれたらすぐに動かしたい場合の記述
        $(window).on("load", function () {
          ScrollAnime(); //スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ
        });
      }
    }

    $(".top-visual").slick({
      autoplay: true,
      fade: true,
    });

    $(".rank-list").slick({
      infinite: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      autoplay: true,
    });

    $(".mealtime_conversion").each(function () {
      let text = $(this).html();
      $(this).html(
        text
          .replace(/breakfast/g, "朝")
          .replace(/lunch/g, "昼")
          .replace(/dinner/g, "夜")
      );
    });

    $(".meals-show_container_row_url").each(function (i, e) {
      if ($(e).attr("href")) {
        $(e).css("color", "crimson");
      } else {
        $(e).removeAttr("href");
        $(e).css("color", "#000");
        $(e).html("URLがありません");
      }
    });

    $(".users-show_favorite_block_content_title").each(function (i, e) {
      if ($(e).attr("target")) {
        $(e).css("color", "crimson");
      } else {
        $(e).removeAttr("href");
        $(e).css("color", "#000");
      }
    });
  });

