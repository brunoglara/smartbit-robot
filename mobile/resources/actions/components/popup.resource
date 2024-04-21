** Settings ***

Documentation    Actions and elements of account screen

Library     AppiumLibrary


*** Keywords ***
Popup has text
    [Arguments]    ${messageText}

    ${element}    Set Variable    xpath=//android.widget.TextView[@resource-id='android:id/message']

    Wait Until Element Is Visible    ${element}    10
        
    Element Should Contain Text   ${element}    ${messageText}

Click ok button
    
    Click Element    xpath=//android.widget.Button[@resource-id='android:id/button1']