*** Settings ***
Library  Selenium2Library
Suite Setup     WEBPAGE SHOULD BE REACHABLE     prometheus.desy.de:2288     dCache Overview

*** Test Cases ***
FIRST TEST
    OPEN BROWSER    https://www.google.be/      phantomjs
    TITLE SHOULD BE  Google
    CLOSE BROWSER



*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]      ${URL}     ${EXPECTED TITLE}
    OPEN BROWSER    ${URL}      phantomjs
    TITLE SHOULD BE  ${EXPECTED TITLE}
    CLOSE BROWSER