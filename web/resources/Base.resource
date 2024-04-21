*** Settings ***
Documentation    Arquibo principal do projeto Robot

Library    Browser 
Library    ../../libs/Account.py
Library    ../../libs/Database.py
Library    JSONLibrary

Resource     pages/Landing.resource
Resource    pages/Welcome.resource
Resource     pages/Login.resource
Resource     pages/Clients.resource
Resource     pages/Memberships.resource

Resource    pages/components/Toast.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Modal.resource

*** Variables ***
${data_login}

*** Keywords ***
Start Session
    New Browser    browser=chromium    #headless=False
    Set Browser Timeout    15
    New Page    http://localhost:3000/

    ${data_login}     Get Json fixture    login    data_login

    Set Global Variable    ${data_login}

    
Get Json fixture
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    RETURN    ${data}[${scenario}]


Signin admin
    [Arguments]    ${username}    ${password}
    Go to login page
    Submit login form    ${username}    ${password}
    User is logged in    ${username}