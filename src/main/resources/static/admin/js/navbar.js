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




//Lấy dữ liệu trên localStorage Để Login ở navbar-white
const userLogin = JSON.parse(localStorage.getItem("userLogin"));
const userLoginLi = document.getElementById("userLoginLi");
const userLoginElement = document.getElementById("userLogin");
const loginButton = document.getElementById("openLogin");
const registerLink = document.querySelector('a[href="register.html"]').parentElement;

if (userLogin) {
    // Hiện user, ẩn đăng nhập/đăng ký
    userLoginLi.style.display = "flex";
    userLoginElement.querySelector('.username').textContent = userLogin.fullname;
    loginButton.parentElement.style.display = "none";
    registerLink.style.display = "none";
} else {
    // Ẩn user, hiện đăng nhập/đăng ký
    userLoginLi.style.display = "none";
    loginButton.parentElement.style.display = "flex";
    registerLink.style.display = "flex";
}



//Lấy dữ liệu từ localStorage để đăng nhập
document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('userLoginForm');
    const alertError = document.getElementById('alertError');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            // Lấy danh sách users từ localStorage
            const users = JSON.parse(localStorage.getItem('users')) || [];
            // Tìm user phù hợp
            const user = users.find(u => u.username === username && u.password === password);
            if (user) {
                localStorage.setItem('userLogin', JSON.stringify(user));
                document.getElementById('loginModal').style.display = 'none';
                document.getElementById('modalOverlay').style.display = 'none';
                location.reload();
            } else {
                alertError.style.display = 'block';
            }
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

//dropdown menu
document.addEventListener('DOMContentLoaded', function() {
    const userLogin = document.getElementById('userLogin');
    const userDropdown = document.getElementById('userDropdown');
    if(userLogin && userDropdown) {
        userLogin.onclick = function(e) {
            e.stopPropagation();
            userDropdown.style.display = userDropdown.style.display === 'block' ? 'none' : 'block';
        };
        // Ẩn dropdown khi click ra ngoài
        document.addEventListener('click', function() {
            userDropdown.style.display = 'none';
        });
        userDropdown.onclick = function(e) {
            e.stopPropagation();
        };
    }
});




//Xử lý đăng xuất
document.addEventListener('DOMContentLoaded', function() {
    const logoutBtn = document.getElementById('logoutBtn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', function(e) {
            e.preventDefault();
            localStorage.removeItem('userLogin');
            location.href = 'index.html'; 
        });
    }
});