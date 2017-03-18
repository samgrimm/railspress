function showHideDiv(elementId) {
  if (document.getElementById) {
    var element = $(elementId);
    if (element.is(":visible")) {
      element.css({'display':'none'});
      growMainArea('#mainArea');
      hideNavBar('#cmsNav');
    } else {
      element.css({'display':'block'});
      reduceMainArea('#mainArea');
      showNavBar('#cmsNav');
    }
  }
}

function growMainArea(elementId) {
  if (document.getElementById) {
    var area = $(elementId);
    area.removeClass('col-sm-9 offset-sm-3 col-md-10 offset-md-2');
    area.addClass('col-md-12');
  }
}

function reduceMainArea(elementId) {
  if (document.getElementById) {
    var area = $(elementId);
    area.addClass('col-sm-9 offset-sm-3 col-md-10 offset-md-2');
    area.removeClass('col-md-12');
  }
}

function hideNavBar(navId) {
  if (document.getElementById) {
    var navBar = $(navId);
    navBar.css({'display':'none'});
  }
}


function showNavBar(navId) {
  if (document.getElementById) {
    var navBar = $(navId);
    navBar.css({'display':'block'});
  }
}
