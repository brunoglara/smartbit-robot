*** Settings ***
Documentation    Açõs e elementos da Landing Page

Library    Browser

*** Keywords ***
Submit signup form
    [Arguments]    ${account}

    Get Text   
    ...    xpath=//h2[normalize-space()='Faça seu cadastro e venha para a Smartbit!']    
    ...    equal    
    ...    Faça seu cadastro e venha para a Smartbit!

    # Act
    Fill Text    id=name    ${account}[name]
    Fill Text    id=email    ${account}[email]
    Fill Text    id=cpf    ${account}[cpf]

    Click    css=button >> text=Cadastrar
