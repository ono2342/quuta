window.onload = function() {
  new Vue({
  el: '#editor',
  data: {
  input: '',
  },
  filters: {
  marked: marked,
  },
  });
  };