const loginForm = document.getElementById("loginForm");
const usernameElement = document.getElementById("username");
const passwordElement = document.getElementById("password");
const alertError = document.getElementById("alertError");

loginForm.addEventListener("submit", function(event) {
    // Ngăn chặn sự kiện mặc định của form
    event.preventDefault();


    const userLocal = JSON.parse(localStorage.getItem("users")) || [];
    
    const findUser = userLocal.find(user => user.username === usernameElement.value 
        && user.password === passwordElement.value);
        if(!findUser){
            alertError.style.display = "block";
        }else{
            window.location.href = "index.html";

        //Lưu thông tin người dùng vào localStorage
        localStorage.setItem("userLogin",JSON.stringify(findUser));
        }
});
