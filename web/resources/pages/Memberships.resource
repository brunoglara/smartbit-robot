*** Settings ***
Documentation    Ações e elementos da página de Matrículas

Library     Browser
Resource    components/Toast.resource
Resource    components/Modal.resource

*** Keywords ***
Go to memberships page
    Click    xpath=//a[normalize-space()='Matrículas']

    Wait For Elements State    xpath=//h1[normalize-space()='Matrículas']
    ...    visible    5
    
Go to new membership
    Click    css=a[href="/memberships/new"]

    Wait For Elements State    css=h1 >> text=Nova matrícula

Create new membership
    [Arguments]    ${account}    ${card}    ${plan}
    
    Go to memberships page
    Go to new membership

    # Preencher Nome do Aluno
    Select Account    ${account}[name]    ${account}[cpf]

    # Preencher Tipo de Plano
    Select Plan    ${plan}[name]

    # Preencher Dados de Pagamento
    Fill payment details   
    ...    ${card}[number]   
    ...    ${account}[name]    
    ...    ${card}[month]   
    ...    ${card}[year]
    ...    ${card}[cvv]

    Click    css=button >> text=Cadastrar

Verify successful membershipment
    Toast shoud be    Matrícula cadastrada com sucesso.


Select Account
    [Arguments]    ${name}    ${cpf}

    Fill Text    css=input[aria-label='select_account']    ${name}
    Click    css=[data-testid='${cpf}']

Select Plan
    [Arguments]    ${plan_name}
    
    Fill Text    css=input[aria-label='select_plan']    ${plan_name}
    Click    xpath=//div[contains(@id,'option')] >> text=${plan_name}

Fill payment details
    [Arguments]    ${card_number}    ${card_holder}    ${month}    ${year}    ${cvv}

    Fill Text    css=#card_number    ${card_number}
    Fill Text    css=#card_holder    ${card_holder}
    Fill Text    css=#card_month    ${month}
    Fill Text    css=#card_year     ${year}
    Fill Text    css=#card_cvv      ${cvv}

Fill search box 
    [Arguments]    ${name}

    Fill Text    css=input[placeholder^='Busque']    ${name}  

    Wait For Elements State    css=strong >> text=Total: 1    
    ...    visible    5
  
    
Should search result by name
    [Arguments]    ${name}

    Wait For Elements State    xpath=//td[normalize-space()='${name}']
    ...    visible    5

Request removal member
    [Arguments]    ${name}
    
    
    Click    xpath=//td[contains(text(),'${name}')]/..//button

    
Membership should not be visible
    [Arguments]    ${name}
    
    Clear Text    css=input[placeholder^='Busque']
    Fill Text    css=input[placeholder^='Busque']    ${name}
    Wait For Elements State    css=div >> text=Nenhum registro encontrado.
    