** Settings ***

Documentation    Actions and elements of mybody screen

Library     AppiumLibrary


*** Keywords ***
User is in the mybody screen

    Wait Until Page Contains    Registre ou atualize suas medidas    10


Fill and send measurements
    [Arguments]    ${weight}    ${height}

    Input Text    xpath=//android.widget.EditText[@resource-id='weight']    ${weight}
    Input Text    xpath=//android.widget.EditText[@resource-id='height']    ${height}

    Click Element    xpath=//android.widget.TextView[@text='Enviar minhas medidas']



