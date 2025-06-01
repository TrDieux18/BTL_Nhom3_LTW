//navbar đổi màu khi scroll
window.onload = function() {
  try {
      const navbar = document.querySelector('.navbar');
      if (!navbar) {
          console.error('Navbar element not found!');
          return;
      }
      document.addEventListener('scroll', function() {
          if (window.scrollY > 10) {
              navbar.classList.add('scrolled');
          } else {
              navbar.classList.remove('scrolled');
          }
      });
  } catch (e) {
      console.error('Error in scroll event listener:', e);
  }
};

document.addEventListener("DOMContentLoaded", function() {
    var fullname = document.getElementById("userFullname");
    var dropdown = document.getElementById("userDropdown");
    if(fullname && dropdown) {
        fullname.addEventListener("click", function(e) {
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
            e.stopPropagation();
        });
        // Ẩn dropdown khi click ra ngoài
        document.addEventListener("click", function() {
            dropdown.style.display = "none";
        });
    }
});

//Modal xuất hiện khi nhấn vào nút đăng nhập
document.getElementById('openLogin').onclick = function() {
    document.getElementById('loginModal').style.display = 'flex';
    document.getElementById('modalOverlay').style.display = 'block';
    document.body.classList.add('no-scroll');
};
document.getElementById('closeLogin').onclick = function() {
    document.getElementById('loginModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
    document.body.classList.remove('no-scroll'); 
};
document.getElementById('modalOverlay').onclick = function() {
    document.getElementById('loginModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
    document.body.classList.remove('no-scroll');
};