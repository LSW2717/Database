$(document).ready(function () {
    const display = $("#js-result");
    const range = $("#js-range");
    const rangeValue = $("#max");
    const guessInput = $("#num");

    function generateRandomNumber(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    range.on("input", function () {
        rangeValue.text(range.val());
    });

    $("#js-guess").submit(function (e) {
        e.preventDefault();
        const userGuess = parseInt(guessInput.val());
        const computerGuess = generateRandomNumber(0, parseInt(range.val()));

        let resultMessage = "";
        resultMessage = `You chose: ${userGuess}, the machine chose: ${computerGuess}.`;
        if (userGuess === computerGuess) {
            resultMessage += "<br><strong>You win!</strong>";
        } else {
            resultMessage += "<br><strong>You lose!</strong>";
        }
        display.find("span").html(resultMessage);
    });
});