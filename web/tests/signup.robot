*** Settings ***

Documentation   Cenários de testes de pré-cadastro de clientes

Library    Collections

Resource    ../resources/Base.resource

# Ganchos - Esse Exemplo executa algo antes de todos os testes e depois de todos os testes
Test Setup  Start Session  
Test Teardown    Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke
    # ${account}    Get Fake Account  #Estratégia com o Faker
    ${account}    Create Dictionary
    ...    name=Bruno Lara
    ...    email=teste@teste.com
    ...    cpf=06097411871
   
   
    Delete Account By Email    ${account}[email]

    Submit signup form    ${account}
    
    Verify welcome message

    Sleep    2

Campos de pré-cadastro obrigatórios
    [Template]      Attempt signup mandatory
    name       Por favor informe o seu nome completo
    email      Por favor, informe o seu melhor e-mail
    cpf        Por favor, informe o seu CPF

Campos de pré-cadastro no formato errado
    [Template]  Attempt signup wrong formato      
    email     Oops! O email informado é inválido
    cpf       Oops! O CPF informado é inválido


*** Keywords ***
 Attempt signup mandatory
     [Arguments]    ${attribute}    ${output_message}

    ${account}    Get Fake Account

    #"Sobrescrever" o objeto account
    Set To Dictionary    ${account}    ${attribute}=${EMPTY}
  
    Submit signup form    ${account}

    Notice shoud be    ${output_message}

Attempt signup wrong formato
     [Arguments]    ${attribute}    ${output_message}

      ${account}    Get Fake Account

    #"Sobrescrever" o objeto account
    Set To Dictionary    ${account}   ${attribute}=${account}[incorrect_cpf]

    Submit signup form    ${account}

    Notice shoud be    ${output_message}