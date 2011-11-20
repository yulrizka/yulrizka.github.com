
  $(function() {
    var tag, tagObj, _i, _len, _ref, _results;
    _ref = $('.highlight pre code');
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      tag = _ref[_i];
      tagObj = $(tag);
      if (tagObj.hasClass('ruby')) {
        _results.push(tagObj.parents('.highlight').addClass('ruby'));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  });
