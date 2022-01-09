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

    eventClick: function(info) {
      // alert('hoge');
      console.log(info.id);
      $.ajax('/meals/' + info.id + '.json')
        .done(function(data){
          console.log(data)
          $('#event > #title').text(data.title);
          $('#event > #date').text(data.date);
          $('#event > #mealtime').text(data.mealtime);
        })
        .fail(function() {
          alert('ERROR');
        })
    }
  });


});