*** Settings ***
Documentation    Ações e elementos da página de Login

Library     Browser

*** Keywords ***
Go to login page
    Go To    http://localhost:3000/login

Submit login form
    [Arguments]    ${email}    ${password}

    Fill Text    id=email        ${email}
    Fill Text    id=password     ${password}

    Click        css=button >> text=Entrar

