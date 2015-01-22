function randTitle() {
  var randStr = Math.random().toString(36).replace(/[^a-z]+/g, '');
  $('#post_title').val(randStr);
}
