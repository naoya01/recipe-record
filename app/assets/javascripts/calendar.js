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
    eventColor: '#63ceef',
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
        // console.log(data);
        $('#event').empty();
        data.forEach((event) => {
          // console.log(event);
          $('#event').append(`<li>Titlt : ${event.title}<ul><li>URL : ${event.url}</li><li>Description : ${event.meal_description}</li></ul></li>`);
        })
      })
      .fail(function() {
        alert('ERROR');
      })
}