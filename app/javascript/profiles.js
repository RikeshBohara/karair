window.previewPhoto = function(inputId, previewId) {
  const input = document.getElementById(inputId);
  const preview = document.getElementById(previewId);
  
  if (input && preview && input.files && input.files[0]) {
    const reader = new FileReader();
    
    reader.onload = function(e) {
      preview.innerHTML = `<img src="${e.target.result}" alt="Profile Photo Preview" class="w-32 h-32 rounded-full object-cover transition-opacity group-hover:opacity-75" style="display: block;" />`;
    };
    
    reader.readAsDataURL(input.files[0]);
  }
}

