


function swapPlaceholders() {
    let fromInput = document.getElementById("from");
    let toInput = document.getElementById("to");

    let tempPlaceholder = fromInput.value;
    fromInput.value = toInput.value;
    toInput.value = tempPlaceholder;
}

// Gán sự kiện vào nút sau khi DOM đã tải xong
document.addEventListener("DOMContentLoaded", function () {
    let swapButton = document.querySelector(".but-ref");
    if (swapButton) {
        swapButton.addEventListener("click", swapPlaceholders);
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const flightTab = document.getElementById('flight-tab');
    const hotelTab = document.getElementById('hotel-tab');
    const flightForm = document.getElementById('flight-form');
    const hotelForm = document.getElementById('hotel-form');

    flightTab.addEventListener('click', () => {
        flightTab.classList.add('active');
        hotelTab.classList.remove('active');
        flightForm.classList.add('show', 'active');
        hotelForm.classList.remove('show', 'active');
    });

    hotelTab.addEventListener('click', () => {
        hotelTab.classList.add('active');
        flightTab.classList.remove('active');
        hotelForm.classList.add('show', 'active');
        flightForm.classList.remove('show', 'active');
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const tripTypeSelect = document.getElementById('tripTypeBtn');
    const returnDateCol = document.getElementById('returnDateCol');
    const departureDateCol = document.getElementById('departureDateCol');

    function toggleFormByTripType() {
        const selectedOption = tripTypeSelect.options[tripTypeSelect.selectedIndex];
        const type = selectedOption.getAttribute('data-type');

        if (type === 'oneway') {
            returnDateCol.classList.add('d-none'); // ẩn ô "Về"
            departureDateCol.classList.add('mx-between'); // dịch ô "Khởi hành" qua giữa
        } else {
            returnDateCol.classList.remove('d-none'); // hiện lại ô "Về"
            departureDateCol.classList.remove('mx-between'); // trả lại vị trí cũ
        }
    }

    toggleFormByTripType();
    tripTypeSelect.addEventListener('change', toggleFormByTripType);
});

const dropdownBox = document.getElementById('dropdownBox');
const toggleDropdown = document.getElementById('toggleDropdown');
const summaryText = document.getElementById('summaryText');
const finishBtn = document.getElementById('finishBtn');

toggleDropdown.addEventListener('click', () => {
    dropdownBox.classList.toggle('d-none');
});

finishBtn.addEventListener('click', () => {
    const room = parseInt(document.getElementById('room').value);
    const adult = parseInt(document.getElementById('adult').value);
    const child = parseInt(document.getElementById('child').value);

    let text = `${room} Phòng, ${adult} Người lớn`;
    if (child > 0)
        text += `, ${child} Trẻ em`;
    summaryText.textContent = text;

    dropdownBox.classList.add('d-none');
});

document.querySelectorAll('.counter-btn').forEach(btn => {
    btn.addEventListener('click', function () {
        const targetId = this.getAttribute('data-target');
        const action = this.getAttribute('data-action');
        const input = document.getElementById(targetId);
        let value = parseInt(input.value);

        if (action === 'increase') {
            value += 1;
        } else if (action === 'decrease') {
            const min = (targetId === 'adult') ? 1 : 0;
            if (value > min)
                value -= 1;
        }

        input.value = value;
        updateButtonState(targetId);
    });
});

function updateButtonState(targetId) {
    const input = document.getElementById(targetId);
    const value = parseInt(input.value);
    document.querySelectorAll(`[data-target="${targetId}"]`).forEach(btn => {
        if (btn.getAttribute('data-action') === 'decrease') {
            btn.disabled = (targetId === 'adult') ? value <= 1 : value <= 0;
        }
    });
}

// Initialize states
['room', 'adult', 'child'].forEach(updateButtonState);

document.addEventListener('DOMContentLoaded', function () {
    const tripTypeSelect = document.getElementById('tripTypeBtn');
    const returnDateCol = document.getElementById('returnDateCol');
    const departureDateCol = document.getElementById('departureDateCol');

    function toggleFormByTripType() {
        const selectedOption = tripTypeSelect.options[tripTypeSelect.selectedIndex];
        const type = selectedOption.getAttribute('data-type');

        if (type === 'oneway') {
            returnDateCol.classList.add('d-none'); // ẩn ô "Về"
            departureDateCol.classList.add('mx-between'); // dịch ô "Khởi hành" qua giữa
        } else {
            returnDateCol.classList.remove('d-none'); // hiện lại ô "Về"
            departureDateCol.classList.remove('mx-between'); // trả lại vị trí cũ
        }
    }

    toggleFormByTripType();
    tripTypeSelect.addEventListener('change', toggleFormByTripType);
});
