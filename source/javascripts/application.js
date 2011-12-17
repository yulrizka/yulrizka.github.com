
  $(function() {
    var tag, tagObj, _i, _len, _ref;
    _ref = $('.highlight pre code');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      tag = _ref[_i];
      tagObj = $(tag);
      if (tagObj.hasClass('ruby')) tagObj.parents('.highlight').addClass('ruby');
    }
    this.sidebar = false;
    return $('a.brand').click(function() {
      var content, drop_pane, sidebar;
      sidebar = $('.container > .row > .sidebar');
      content = $('.container > .row > .content');
      drop_pane = $('#drop-pane');
      if (!this.sidebar) {
        sidebar.show();
        content.addClass('span11');
        drop_pane.slideDown('slow');
      } else {
        drop_pane.slideUp('slow', function() {
          sidebar.hide();
          return content.removeClass('span11');
        });
      }
      this.sidebar = !this.sidebar;
      return false;
    });
  });

  $(function() {
    var changeHeader;
    changeHeader = function(i) {
      var current, to;
      current = $('#banner li.active');
      to = $('#banner li').eq(i);
      console.log(current);
      console.log(to);
      if (current.index() !== to.index()) {
        $('.nav li').removeClass('banner');
        $('.nav li').eq(i).addClass('banner');
        current.stop(true, true).fadeOut('fast', function() {
          current.removeClass('active');
          return to.fadeIn('fast', function() {
            return to.addClass('active');
          });
        });
        return console.log('change');
      }
    };
    return $('.nav li').mouseenter(function() {
      return changeHeader($(this).index());
    });
  });


