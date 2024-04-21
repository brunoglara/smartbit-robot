*** Settings ***
Documentation    Cenários de testes do Login SAC

Resource    ../resources/Base.resource

Test Setup        Start Session   
Test Teardown     Take Screenshot

*** Test Cases ***
Deve logar como Gestor de Academia

    Signin admin    ${data_login}[username]    ${data_login}[password]

Login com credenciais invalidas
    [Tags]    invalid_credential
    [Template]    Attempt login with invalid credenciais
    sac@smartbit.com    abc123
    404@smartbit.com    pwd123

Login sem preencher campos obrigatórios ou com email no formato incorreto
    [Tags]    mandatory_fields
    [Template]    Login with verify notice
    ${EMPTY}     ${EMPTY}    Os campos email e senha são obrigatórios.
    sac@smartbit.com     ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}             pwd123    Os campos email e senha são obrigatórios.
    sac...com            pwd123    Oops! O email informado é inválido
    sac#.smartbit.com    pwd123    Oops! O email informado é inválido


    
*** Keywords ***
Attempt login with invalid credenciais
    [Arguments]    ${email}    ${password}

    Go to login page
    
    Submit login form     ${email}     ${password}

    Toast shoud be        As credenciais de acesso fornecidas são inválidas.

Login with verify notice
    [Arguments]    ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form    ${email}    ${password}

    Notice shoud be    ${output_message}