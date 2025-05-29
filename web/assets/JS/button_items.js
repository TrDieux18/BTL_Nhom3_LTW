
document.addEventListener('DOMContentLoaded', function() {
    const inlandFlights = document.querySelectorAll('.flight-item_inland');
    const toggleBtn = document.getElementById('toggleBtn');
    let inlandVisibleCount = 6;
    const inlandStep = 6; 

    function hideExtraInlandFlights() {
        inlandFlights.forEach((flight, index) => {
            if (index >= inlandVisibleCount) {
                flight.style.display = 'none';
            } else {
                flight.style.display = 'block';
            }
        });
        
        // Cập nhật text của button
        if (inlandVisibleCount >= inlandFlights.length) {
            toggleBtn.textContent = 'Ẩn bớt';
        } else {
            toggleBtn.textContent = 'Hiện thêm';
        }

        if (inlandFlights.length <= 6) {
            toggleBtn.style.display = 'none';
        }
    }

    hideExtraInlandFlights();

    if (toggleBtn) {
        toggleBtn.addEventListener('click', function() {
            if (inlandVisibleCount >= inlandFlights.length) {
                inlandVisibleCount = 6;
            } else {
                inlandVisibleCount = Math.min(inlandVisibleCount + inlandStep, inlandFlights.length);
            }
            hideExtraInlandFlights();
        });
    }

    const internationalFlights = document.querySelectorAll('.flight-item_international');
    const toggleBtnInternational = document.getElementById('toggleBtn_international');
    let internationalVisibleCount = 6; 
    const internationalStep = 6; 

    function hideExtraInternationalFlights() {
        internationalFlights.forEach((flight, index) => {
            if (index >= internationalVisibleCount) {
                flight.style.display = 'none';
            } else {
                flight.style.display = 'block';
            }
        });
        
        // Cập nhật text của button
        if (internationalVisibleCount >= internationalFlights.length) {
            toggleBtnInternational.textContent = 'Ẩn bớt';
        } else {
            toggleBtnInternational.textContent = 'Hiện thêm';
        }
        
        if (internationalFlights.length <= 6) {           
            toggleBtnInternational.style.display = 'none';
        }
    }
    

    hideExtraInternationalFlights();
    if (toggleBtnInternational) {
        toggleBtnInternational.addEventListener('click', function() {
            if (internationalVisibleCount >= internationalFlights.length) {
                internationalVisibleCount = 6;
            } else {
                internationalVisibleCount = Math.min(internationalVisibleCount + internationalStep, internationalFlights.length);
            }
            hideExtraInternationalFlights();
        });
    }
});

function toggleFaq(button) {
            const answer = button.nextElementSibling;
            const isActive = button.classList.contains('active');
            
            // Đóng tất cả FAQ khác
            document.querySelectorAll('.faq-question').forEach(q => {
                q.classList.remove('active');
                q.nextElementSibling.classList.remove('show');
            });
            
            // Toggle FAQ hiện tại
            if (!isActive) {
                button.classList.add('active');
                answer.classList.add('show');
            }
}