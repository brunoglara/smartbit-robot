*** Settings ***
Documentation    Ações e elementos da página de Login

Library     Browser

*** Keywords ***
User is logged in
    [Arguments]    ${email}

    ${element}    Set Variable    css=.logged-user >> text=${email}

    Wait For Elements State    ${element}    visible    5