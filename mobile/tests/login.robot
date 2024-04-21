*** Settings ***

Documentation    Suite login tests

Resource    ../resources//Base.resource

Test Setup        Start Session
Test Teardown     Finish Session


*** Test Cases ***
Should login with valid CPF and IP
    ${data_account}    Get Json fixture    data    login

    Insert Membership    ${data_account}
    
    Signin with document    ${data_account}[account][cpf]

    User is logged in

Should not login with unsubscribed CPF
    ${data_account}    Get Json fixture    data    unsubscribed

    Delete Account By Email    ${data_account}[account][email]
    
    Signin with document    ${data_account}[account][cpf]

    Popup has text            Acesso não autorizado

    #9:41

Should not login with wrong format CPF

    Signin with document      00000000000

    Popup has text            CPF inválido

Should not accept login with empty CPF

    Signin with CPF empty    

    Popup has text            Informe o número do seu CPF