*** Settings ***
Documentation    Suite de testes de matriculas de planos

Resource    ../resources/Base.resource
Resource    ../resources/pages/Memberships.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

Library    Process



*** Test Cases ***
Should perform a new enroll
    ${data_account}    Get Json fixture    memberships    create

    Delete Account By Email    ${data_account}[account][email]
    Insert Account    ${data_account}[account]

    Signin admin    ${data_login}[username]    ${data_login}[password]

    Go to memberships page
    Go to new membership

    Create new membership    ${data_account}[account]    ${data_account}[card_details]    ${data_account}[plan]

    Verify successful membershipment

Should not perform duplicate enrollment
    [Tags]    duplicate

    ${data_account}    Get Json fixture    memberships    duplicate

    Insert Membership    ${data_account}

    Signin admin    ${data_login}[username]   ${data_login}[password]

    Go to memberships page
    Go to new membership

    Create new membership    ${data_account}[account]    ${data_account}[card_details]    ${data_account}[plan]

    Toast shoud be    O usuário já possui matrícula.

Should find member by name
    [Tags]    search

    ${data_account}    Get Json fixture    memberships    search
    ${search}    Set Variable    ${data_account}[account][name]

    Insert Membership    ${data_account}

    Signin admin    ${data_login}[username]    ${data_login}[password]

    Go to memberships page
    Fill search box    ${search}
    Should search result by name    ${search}

Remove member
    [Tags]    remove

    ${data_account}    Get Json fixture    memberships    remove
    ${name_membership}    Set Variable    ${data_account}[account][name]

    Insert Membership    ${data_account}

    Signin admin    ${data_login}[username]    ${data_login}[password]

    Go to memberships page

    Request removal member    ${name_membership}
    Confirm removal
    Membership should not be visible    ${name_membership}

    
