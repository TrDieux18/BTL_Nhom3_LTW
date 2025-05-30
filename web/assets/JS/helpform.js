//Thanks
    let timeLeft = 5;
    const countdownEl = document.getElementById('countdown');

    const timer = setInterval(() => {
      timeLeft--;
      countdownEl.textContent = timeLeft;

      if (timeLeft <= 0) {
        clearInterval(timer);
        window.location.href = "home"; 
      }
    }, 1000);
    
//help
    function updateForm() {
      const category = document.getElementById('yeucau').value;
      const fullnameField = document.getElementById('fullnameField');
      const emailField = document.getElementById('emailField');
      const phoneField = document.getElementById('phoneField');
      const titleField = document.getElementById('titleField');
      const messageField = document.getElementById('messageField');
      const aircodeField = document.getElementById('aircodeField');
      const hotelcodeField = document.getElementById('hotelcodeField');
      const imagesField = document.getElementById('imagesField');
      
      fullnameField.style.display = 'none';
      emailField.style.display = 'none';
      phoneField.style.display = 'none';
      titleField.style.display = 'none';
      messageField.style.display = 'none';
      aircodeField.style.display = 'none';
      hotelcodeField.style.display = 'none';
      imagesField.style.display = 'none';

      if (category === 'Vấn đề về vé máy bay') {
        aircodeField.style.display = 'block';
        fullnameField.style.display = 'block';
        emailField.style.display = 'block';
        phoneField.style.display = 'block';
        messageField.style.display = 'block';
        imagesField.style.display = 'block';
        } else if(category === 'Vấn đề về khách sạn') {
        hotelcodeField.style.display = 'block';
        fullnameField.style.display = 'block';
        emailField.style.display = 'block';
        phoneField.style.display = 'block';
        messageField.style.display = 'block';
        imagesField.style.display = 'block';
        } else if (category === 'Báo cáo lỗi') {
        titleField.style.display = 'block';
        messageField.style.display = 'block';
        imagesField.style.display = 'block';
        } else {
        fullnameField.style.display = 'block';
        emailField.style.display = 'block';
        phoneField.style.display = 'block';
        titleField.style.display = 'block';
        messageField.style.display = 'block';
        imagesField.style.display = 'block';
      }
    }
    const form = document.getElementById('myForm');
    form.addEventListener('submit', function (e) {
    const inputs = form.querySelectorAll('input[name], textarea[name]');
    inputs.forEach(input => {
      if (!input.value.trim()) {
        input.removeAttribute('name');
      }
    });
  });
