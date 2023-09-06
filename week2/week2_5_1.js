const display = document.getElementById("js-result");
const number = document.getElementById("js-range");
const guessInput = document.getElementById("num");
const rangeValue = document.getElementById("max");
const range = document.getElementById("js-title");

function generateRandomNumber(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
function updateRangeValue() {
    rangeValue.textContent = number.value;
}
const handlePrint = (e) => {
    e.preventDefault();
    const userGuess = guessInput.value;
    const computerGuess = generateRandomNumber(0, number.value);
    const displaySpan = display.querySelector("span");
    let resultMessage = " ";
    resultMessage = `You chose: ${userGuess}, the machine chose: ${computerGuess}.`;

    if (userGuess === computerGuess) {
        resultMessage += "<br><strong>You win!</strong>";
    } else {
        resultMessage += "<br><strong>You lose!</strong>";
    }
    displaySpan.innerHTML = resultMessage;
};
const printForm = document.getElementById("js-guess")
printForm.addEventListener("submit", handlePrint);
guessInput.addEventLestener("change", updateRangeValue);
