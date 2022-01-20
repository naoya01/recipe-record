$(function() {
  function eventCalendar() {
    return $('#calendar').fullCalendar({});
  }

  function clearCalendar() {
    $('#calendar').html('');
  }


  $('#calendar').fullCalendar({
    events: '/meals.json',

    titleFormat: 'YYYY年 M月',
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],

    header: {
      left: '',
      center: 'title',
      right: 'today prev,next',
    },

    defaultTimedEventDuration: '03:00:00',
    buttonText: {
      prev: '前',
      next: '次',
      prevYear: '前年',
      nextYear: '翌年',
      today: '今日',
      month: '月',
      week: '週',
      day: '日',
    },
    timeFormat: 'HH:mm',
    // eventColor: '#63ceef',
    eventTextColor: '#000000',

    //eventClickとdayclickでは取得できるものに違いがあるため2つ記述してある。それぞれ別の方法で日付を取得している。
    eventClick: function(info) {
      // console.log(info.start._i);
      dayMealEvent(info.start._i);
    },

    dayClick: function dayEvent (date, jsEvent, view) {
      // console.log(`${date._d.getFullYear()}-${date._d.getMonth() + 1}-${date._d.getDate()}`);  「``」で式を出力できる
      var params = `${date._d.getFullYear()}-${date._d.getMonth() + 1}-${date._d.getDate()}`;
      dayMealEvent(params);
    }
  });
});

function dayMealEvent(params) {
  $.ajax('/meals/day?day=' + params)
      .done(function(data){
        console.log(data);
        $('.meals-index_event-container').css('display','block');
        $('#meals-index_event_breakfast_content').empty();
        $('#meals-index_event_lunch_content').empty();
        $('#meals-index_event_dinner_content').empty();
        $('.meals-index_mealtime_breakfast_show').empty();
        $('.meals-index_mealtime_lunch_show').empty();
        $('.meals-index_mealtime_dinner_show').empty();

        data.forEach((event) => {
          console.log(event);
          $('.meals-index_mealtime_breakfast_show').append(`<a class="${event.mealtime}_show" href="/meals/${event.id}">詳細</a>`)
          $('.meals-index_mealtime_lunch_show').append(`<a class="${event.mealtime}_show" href="/meals/${event.id}">詳細</a>`)
          $('.meals-index_mealtime_dinner_show').append(`<a class="${event.mealtime}_show" href="/meals/${event.id}">詳細</a>`)


          $('#meals-index_event_breakfast_content').append(
            ` <div class="meals-index_ivents ${event.mealtime}">
                <ul class="meals-index_ivents_container_list">
                  <li class="meals-index_ivents_container_list_item">
                  <a class="meals-index_ivents_container_list_item_anchor" href="${event.url}">${event.cooking_name}</a>
                  </li>
                </ul>
             </div>`
            );

          $('#meals-index_event_lunch_content').append(
            ` <div class="meals-index_ivents ${event.mealtime}">
                <ul class="meals-index_ivents_container_list">
                  <li class="meals-index_ivents_container_list_item"><a class="meals-index_ivents_container_list_item_anchor" href="${event.url}">${event.cooking_name}</a></li>
                </ul>
             </div>`
            );

          $('#meals-index_event_dinner_content').append(
            ` <div class="meals-index_ivents ${event.mealtime}">
                <ul class="meals-index_ivents_container_list">
                  <li class="meals-index_ivents_container_list_item"><a class="meals-index_ivents_container_list_item_anchor" href="${event.url}">${event.cooking_name}</a></li>
                </ul>
             </div>`
            );

          $('.meals-index_ivents_container_list_item_anchor').each(function(i,e){
            if ($(e).attr('href')){
              $(e).css('color','#0ac');
            } else {
              $(e).removeAttr("href");
              $(e).css('color','#000');
            }
          });

          // カレンダーの日付をクリックした際に
      		$('.meals-index_mealtime_breakfast_show').children().remove('.lunch_show , .dinner_show');
      		$('.meals-index_mealtime_lunch_show').children().remove('.breakfast_show,.dinner_show');
      		$('.meals-index_mealtime_dinner_show').children().remove('.lunch_show,.breakfast_show');

          if ($('.meals-index_ivents_container_title_breakfast_item').text() == "breakfast" ){

             $('.meals-index_ivents_container_title_breakfast').text("朝")
          }
          else if ($('.meals-index_ivents_container_title_lunch_item').text() == "lunch" ){
             $('.meals-index_ivents_container_title_lunch').text("昼")

          }
          else if ($('.meals-index_ivents_container_title_dinner_item').text() == "dinner" ){
             $('.meals-index_ivents_container_title_dinner').text("夜")
          }
        })
      })
      .fail(function() {
        alert('ERROR');
      })
}

