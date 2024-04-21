*** Settings ***

Documentation    Main file automation test project

Library    AppiumLibrary
Library    ../../libs/Account.py
Library    ../../libs/Database.py
Library    JSONLibrary

Resource    ./actions/login.resource
Resource    ./actions/account.resource
Resource    ./actions/mybody.resource

Resource    ./actions/components/menu.resource
Resource    ./actions/components/popup.resource

Resource    ../../services/Service.resource


*** Keywords ***
Start Session
    
    Open Application    http://localhost:4723
    ...    platformName=Android    
    ...    automationName=UIAutomator2    
    ...    deviceName=dm2q    
    ...    udid=RQCW204450J    
    ...    app=${EXECDIR}/app/smartbit-beta.apk
    ...    platformVersion=14
    ...    autoGrantPermissions=true

    Wait Until Page Contains    IP da API    30

Get Json fixture
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    RETURN    ${data}[${scenario}]


Finish Session
    
    Capture Page Screenshot
    Close Application

