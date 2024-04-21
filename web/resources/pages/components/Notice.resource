*** Settings ***
Documentation    Ações e elementos do componente de caixa de notificação

Library    Browser

*** Keywords ***
Notice shoud be
    [Arguments]    ${target}

    Wait For Elements State    
    ...    xpath=//div[contains(@class, 'notice') and contains(text(), '${target}')]
    ...    visible    5