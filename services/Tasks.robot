*** Settings ***
Documentation    file to test API

Resource    ./Service.resource


*** Tasks ***
API testing

    Set user token
    Get account by name    measure test mobile