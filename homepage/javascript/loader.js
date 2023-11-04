// Script to load the templates (Footer / Header)

document.addEventListener('DOMContentLoaded', function () {
    let xhrHeader = new XMLHttpRequest();
    xhrHeader.open('GET', 'header.html', true);
    xhrHeader.onreadystatechange = function () {
        if (xhrHeader.readyState === 4 && xhrHeader.status === 200) {
            let header = document.getElementById('header');
            header.innerHTML = xhrHeader.responseText;
        }
    };

    xhrHeader.send();

    let xhrFooter = new XMLHttpRequest();
    xhrFooter.open('GET', 'footer.html', true);
    xhrFooter.onreadystatechange = function () {
        if (xhrFooter.readyState === 4 && xhrFooter.status === 200) {
            let footer = document.getElementById('footer');
            footer.innerHTML = xhrFooter.responseText;
        }
    };

    xhrFooter.send();
});
