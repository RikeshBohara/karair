// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Auto-hide flash messages after 2 seconds
document.addEventListener("DOMContentLoaded", function() {
  const flashMessages = document.querySelectorAll(".flash-message");
  
  flashMessages.forEach(function(message) {
    setTimeout(function() {
      message.style.transition = "opacity 0.2s ease-out";
      message.style.opacity = "0";
      setTimeout(function() {
        message.remove();
      }, 200);
    }, 2000);
  });
});

// Also handle Turbo events for dynamic content
document.addEventListener("turbo:load", function() {
  const flashMessages = document.querySelectorAll(".flash-message");
  
  flashMessages.forEach(function(message) {
    setTimeout(function() {
      message.style.transition = "opacity 0.2s ease-out";
      message.style.opacity = "0";
      setTimeout(function() {
        message.remove();
      }, 200);
    }, 2000);
  });
});
