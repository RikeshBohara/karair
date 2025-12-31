window.toggleDescription = function() {
  const shortDesc = document.getElementById('description-short');
  const fullDesc = document.getElementById('description-full');
  const toggleBtn = document.getElementById('toggle-description');
  
  if (shortDesc && fullDesc && toggleBtn) {
    if (shortDesc.classList.contains('hidden')) {
      shortDesc.classList.remove('hidden');
      fullDesc.classList.add('hidden');
      toggleBtn.textContent = 'Show more';
    } else {
      shortDesc.classList.add('hidden');
      fullDesc.classList.remove('hidden');
      toggleBtn.textContent = 'Show less';
    }
  }
}

function initDescriptionToggle() {
  const shortDesc = document.getElementById('description-short');
  const fullDesc = document.getElementById('description-full');
  const toggleBtn = document.getElementById('toggle-description');
  
  if (shortDesc && fullDesc && toggleBtn) {
    const shortHeight = shortDesc.scrollHeight;
    const fullHeight = fullDesc.scrollHeight;
    
    if (Math.abs(shortHeight - fullHeight) < 5) {
      toggleBtn.style.display = 'none';
    }
  }
}

window.toggleDetails = function(index) {
  const detailsSection = document.getElementById('details-' + index);
  const toggleButton = document.getElementById('toggle-btn-' + index);
  
  if (detailsSection && toggleButton) {
    if (detailsSection.classList.contains('hidden')) {
      detailsSection.classList.remove('hidden');
      toggleButton.textContent = 'Hide Details';
    } else {
      detailsSection.classList.add('hidden');
      toggleButton.textContent = 'View Details';
    }
  }
}

function init() {
  initDescriptionToggle();
}

init();

document.addEventListener('DOMContentLoaded', init);

document.addEventListener('turbo:load', init);
document.addEventListener('turbo:render', init);
