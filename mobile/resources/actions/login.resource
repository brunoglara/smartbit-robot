*** Settings ***

Documentation    Actions and elements of login screen

Library     AppiumLibrary


*** Keywords ***

Signin with document
    [Arguments]    ${cpf}

    Input Text    xpath=//android.widget.EditText[@text='IP da API']    192.168.1.20
    Input Text    xpath=//android.widget.EditText[@text='Numero do cpf']   text=${cpf}
    
    Click Element     xpath=//android.view.ViewGroup[@resource-id='btnLogin']

Signin with CPF empty

    Input Text    xpath=//android.widget.EditText[@text='IP da API']    192.168.1.20
    
    Click Element     xpath=//android.view.ViewGroup[@resource-id='btnLogin']
