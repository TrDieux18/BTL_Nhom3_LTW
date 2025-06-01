//Lấy ra elements của trang

const registerForm = document.getElementById("registerForm");
const fullnameElement = document.getElementById("fullname");
const emailElement = document.getElementById("email");
const phoneElement = document.getElementById("phone");
const usernameElement = document.getElementById("username");
const passwordElement = document.getElementById("password");
const addressElement = document.getElementById("address");



//Lấy ra các thông báo lỗi
const fullnameError = document.getElementById("fullnameError");
const emailError = document.getElementById("emailError");
const phoneError = document.getElementById("phoneError");
const usernameError = document.getElementById("usernameError");
const passwordError = document.getElementById("passwordError");
const addressError = document.getElementById("addressError");

//Lấy dữ liệu từ localStorage
const userLocal = JSON.parse(localStorage.getItem("users")) || [];

/**
 *  Validate địa chỉ email
 * @param {*} email : chuỗi email người dùng nhập vào
 * @returns : true nếu email hợp lệ, false nếu không hợp lệ
 */
function validateEmail (email){
    return String(email)
      .toLowerCase()
      .match(
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      );
  };
/**
 * Validate số điện thoại
 * @param {string} phone : chuỗi số điện thoại người dùng nhập vào
 * @returns : true nếu số điện thoại hợp lệ, false nếu không hợp lệ
 */
function validatePhone(phone) {
    return phone.match(/^0\d{9}$/);
}
/**
 * Validate username
 * @param {string} username : chuỗi tên tài khoản người dùng nhập vào
 * @returns : true nếu username hợp lệ, false nếu không hợp lệ
 */
function validateUsername(username) {
    // Chỉ cho phép chữ cái, số và dấu gạch dưới
    return username.match(/^[a-zA-Z0-9_]+$/);
}

//Lắng nghe sự kiện submtit đăng ký
registerForm.addEventListener("submit", function (e){
    //Ngăn chặn sự kiện mặc định của form
    e.preventDefault();
    //varlidate dữ liệu
    if(!fullnameElement.value){
        //Nếu không có tên thì thông báo lỗi
        fullnameError.style.display = "block";
    }else {
        //Nếu có tên thì ẩn thông báo lỗi
        fullnameError.style.display = "none";
    }
    if(!emailElement.value){
        emailError.style.display = "block";
    }
    else {
        emailError.style.display = "none";
        //Kiểm tra email có hợp lệ không
        if(!validateEmail(emailElement.value)){
            emailError.style.display = "block";
            emailError.innerHTML = "Email không hợp lệ";
        }
    }       
    if(!phoneElement.value){
        phoneError.style.display = "block";
    }
    else {
        phoneError.style.display = "none";
        if(!validatePhone(phoneElement.value)){
            phoneError.style.display = "block";
            phoneError.innerHTML = "Số điện thoại không hợp lệ";
        }
    }
    if(!usernameElement.value){
        usernameError.style.display = "block";
    }
    else {
        usernameError.style.display = "none";
        if(!validateUsername(usernameElement.value)){
            usernameError.style.display = "block";
            usernameError.innerHTML = "Tên tài khoản chỉ được chứa chữ cái, số và dấu gạch dưới";
        }
    }
    if(!passwordElement.value){
        passwordError.style.display = "block";
    }
    else {
        passwordError.style.display = "none";
    }
    if(!addressElement.value){      
        addressError.style.display = "block";
    }
    else {
        addressError.style.display = "none";
    }

    if(fullnameElement.value && 
        emailElement.value && 
        phoneElement.value && 
        usernameElement.value && 
        passwordElement.value && 
        addressElement.value &&
        validateEmail(emailElement.value) &&
        validatePhone(phoneElement.value) &&
        validateUsername(usernameElement.value))
    {
        const user = {
            userId: Math.ceil(Math.random() * 1000000000),
            fullname: fullnameElement.value,
            email: emailElement.value,
            phone: phoneElement.value,
            username: usernameElement.value,
            password: passwordElement.value,
            address: addressElement.value
        };
        //Push user vào trong mảng localStorage
        userLocal.push(user);


        //Lưu trư dữ liệu lên localStorage
        localStorage.setItem("users", JSON.stringify(userLocal));
        //Chuyển hướng về trang đăng nhập
        setTimeout(function(){
            window.location.href = "login.html";
        }, 1200);
    }
});
