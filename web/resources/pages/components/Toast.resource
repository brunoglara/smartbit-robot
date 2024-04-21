*** Settings ***
Documentation    Ações e elementos do Componente Toast

Library    Browser

*** Keywords ***
Toast shoud be
    [Arguments]    ${expected_message}

    ${selector}    Set Variable    //div >> text=${expected_message}

     Wait For Elements State    xpath=${selector}
    ...    visible    6
    
    Take Screenshot    selector=${selector}
