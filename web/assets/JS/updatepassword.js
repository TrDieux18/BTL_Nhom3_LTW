

const newPassword = document.getElementById("newPassword");
        const confirmPassword = document.getElementById("confirmPassword");
        const saveBtn = document.getElementById("saveBtn");
        const strengthBar = document.getElementById("strengthBar");

        function checkPasswordStrength(pw) {
            let strength = 0;
            if (pw.length >= 6) strength++;
            if (/[0-9]/.test(pw)) strength++;
            if (/[!@#$%^&*(),.?":{}|<>]/.test(pw)) strength++;
            return strength;
        }

        function updateFormState() {
            const pw = newPassword.value;
            const confirm = confirmPassword.value;

            // Update strength bar
            const strength = checkPasswordStrength(pw);
            strengthBar.style.width = `${(strength / 3) * 100}%`;
            strengthBar.style.backgroundColor = strength === 3 ? "green" : (strength === 2 ? "orange" : "red");

            // Enable Save button if valid
            const isValid = pw.length >= 6 && pw === confirm && strength >= 2;
            saveBtn.disabled = !isValid;
            saveBtn.classList.toggle("disabled-button", !isValid);
        }

        newPassword.addEventListener("input", updateFormState);
        confirmPassword.addEventListener("input", updateFormState);