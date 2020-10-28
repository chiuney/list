'use strict';

let dropDown = function () {
  document.addEventListener('turbolinks:load', function() {
    const btn = document.getElementById('dropdown-btn');
    if(btn) {
      btn.addEventListener('click', function(){
        this.classList.toggle('is-open');
      });
    }
  });
}();

window.dropDown = dropDown;