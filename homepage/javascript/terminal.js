document.addEventListener('DOMContentLoaded', function() {

    const currentURL = window.location.href;

    const indexURL = "index.html";
    const projectsURL = "projects.html";
    const contactURL = "contact.html";
    const skillsURL = "skills.html";

    let string = "";

    if (currentURL.includes(indexURL) === true) {
        string = "$  This is CS50-2023, Lab 8!\n$  I created this webpage as a way for people to showcase personal projects! (https://github.com/sorin373)\n$  Enter: /help for additional information!";
    }
    else if (currentURL.includes(contactURL) === true) {
        string = "$  Contact-related services!\n$  Enter: /help for additional information!\n";
    }
    else if (currentURL.includes(projectsURL) === true) {
        string = "$  Sharing my work :D\n$  Enter: /help for additional information!\n"
    }
    else if (currentURL.includes(skillsURL) === true) {
        string = "$  Skills I have developed over time!\n$  Enter: /help for additional information!\n";
    }

    const speed = 50;   //ms
    const delay = 1000; // 1000ms = 1 second

    const textElement = document.getElementById('typing-text');
    const cursor = document.getElementById('typing-cursor');
    const terminalSection = document.getElementById('terminal');
    const terminalOutput = document.getElementById('terminal-output');
    const terminalInput = document.getElementById('terminal-input');

    let index = 0;

    function typeNextCharacter() {
        if (index < string.length) {
            textElement.textContent += string[index];
            index++;
            setTimeout(typeNextCharacter, speed);
        } else {
            cursor.style.display = "none";
            // call terminal
            terminalSection.style.display = "block";
            terminal();
        }
    }

    function help() {
        if (currentURL.includes(indexURL) === true) {
            terminalOutput.innerHTML += "$  Usage:\n/clear    - to clear the console window\n/projects - to view personal projects\n/contact  - to get in touch\n/skills   - to see skills and expertise\n";
        }
        else if (currentURL.includes(contactURL) === true) {
            terminalOutput.innerHTML += "$  Usage:\n/clear    - to clear the console window\n/home     - return to homepage\n/projects - to view personal projects\n/skills   - to see skills and expertise\n";
        }
        else if (currentURL.includes(projectsURL) === true) {
            terminalOutput.innerHTML += "$  Usage:\n/clear   - to clear the console window\n/home    - return to homepage\n/contact - to get in touch\n/skills  - to see skills and expertise\n";
        }
        else if (currentURL.includes(skillsURL) === true) {
            terminalOutput.innerHTML += "$  Usage:\n/clear    - to clear the console window\n/home     - return to homepage\n/projects - to view personal projects\n/contact  - to get in touch\n";
        }
    }

    function clear() {
        terminalOutput.innerHTML = ''; // Clear the terminal output
        terminalInput.value = '';
    }

    function redirect(webpage) {
        terminalOutput.innerHTML += "$  GET /" + webpage + ".html   ...\n";
        window.location.href = webpage + ".html";
    }

    function errorHandler() {
        terminalOutput.innerHTML += "$  Invalid command! Enter: /help for additional information!\n";
    }

    function terminal() {
        terminalInput.focus();

        let commandHistory = [];
        let cmdCount = 0;

        terminalInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault(); // prevent submit

                const cmd = terminalInput.value.trim();
                terminalInput.value = '';

                terminalOutput.innerHTML += '$  ' + cmd + '\n';

                // homepage cmds
                if (currentURL.includes(indexURL) === true) {
                    switch (cmd) {
                        case '/help':
                            help();
                            break;
                        case '/clear':
                            clear();
                            break;
                        case '/projects':
                            redirect('projects');
                            break;
                        case '/contact':
                            redirect('contact');
                            break;
                        case '/skills':
                            redirect('skills');
                            break;
                        default:
                            errorHandler();
                            break;
                    }
                }
                else if (currentURL.includes(contactURL) === true) {
                     // contact cmds
                    switch (cmd) {
                        case '/help':
                            help();
                            break;
                        case '/clear':
                            clear();
                            break;
                        case '/home':
                            redirect('index');
                            break;
                        case '/projects':
                            redirect('projects');
                            break;
                        case '/skills':
                            redirect('skills');
                            break;
                        default:
                            errorHandler();
                            break;
                    }
                }
                else if (currentURL.includes(projectsURL) === true) {
                    // projects cmds
                    switch (cmd) {
                        case '/help':
                            help();
                            break;
                        case '/clear':
                            clear();
                            break;
                        case '/home':
                            redirect('index');
                            break;
                        case '/contact':
                            redirect('contact');
                            break;
                        case '/skills':
                            redirect('skills');
                            break;
                        default:
                            errorHandler();
                            break;
                    }
                }
                else if (currentURL.includes(skillsURL) === true) {
                    // skills cmds
                    switch (cmd) {
                        case '/help':
                            help();
                            break;
                        case '/clear':
                            clear();
                            break;
                        case '/home':
                            redirect('index');
                            break;
                        case '/projects':
                            redirect('projects');
                            break;
                        case '/contact':
                            redirect('contact');
                            break;
                        default:
                            errorHandler();
                            break;
                    }
                }

                commandHistory.push(command);
                cmdCount = commandHistory.length;

                terminalOutput.scrollTop = terminalOutput.scrollHeight;
            }
        });
    }

    // Hide the cursor initially
    cursor.style.display = "none";
    terminalSection.style.display = "none";

    //add a delay before starting the typing animation
    setTimeout(function() {
        cursor.style.display = "inline-block";
        typeNextCharacter();
    }, delay);
});
