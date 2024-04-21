*** Settings ***

Documentation    Suite measure mobile tests

Resource    ../resources//Base.resource

Test Setup        Start Session
Test Teardown     Finish Session

*** Test Cases ***
Should register user measurements
    [Tags]    temp
    Login and go to mybody screen    update

    Fill and send measurements    ${data_account}[account][weight]     ${data_account}[account][height]
    Popup has text    Seu cadastro foi atualizado com sucesso

    #API validation
    Set user token
    ${api_account}    Get account by name    ${data_account}[account][name]

    Should Be Equal    ${api_account}[weight]    ${data_account}[account][weight]
    Should Be Equal    ${api_account}[height]    ${data_account}[account][height]

Should not register user measurements with empty measures
    [Template]    Attempt send measurements invalid and empty
    ${EMPTY}     ${EMPTY}    Informe seu peso (kg)
    80           ${EMPTY}    Informe sua altura (cm)
    ${EMPTY}     190    Informe seu peso (kg)
    -            190    Não foi possível enviar suas informações
    80           .      Não foi possível enviar suas informações

*** Keywords ***
Login and go to mybody screen
    [Arguments]    ${type_data}
     
    ${data_account}    Get Json fixture    data    ${type_data}

    Set Global Variable    ${data_account}

    Delete Account By Email    ${data_account}[account][email]
    Insert Membership    ${data_account}
    
    Signin with document    ${data_account}[account][cpf]
    User is logged in

    Go to mybody screen
    User is in the mybody screen


Attempt send measurements invalid and empty
    [Arguments]    ${weight}    ${height}    ${output_message}

     ${is_loggedin} =     Run Keyword And Return Status     Element Should Be Visible   xpath=//android.widget.TextView[@resource-id='myBodytTitle'] 
    
    Run Keyword If   ${is_loggedin} == ${False}     Login and go to mybody screen    invalid

    Fill and send measurements    ${weight}    ${height}
    
    Popup has text    ${output_message}

    Capture Page Screenshot

    Click ok button