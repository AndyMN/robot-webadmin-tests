*** Settings ***
Library  Selenium2Library
Suite Setup     WEBPAGE SHOULD BE REACHABLE     http://prometheus.desy.de:2288/webadmin     dCache Overview

*** Test Cases ***
FIRST TEST
    OPEN BROWSER    https://www.google.be/      phantomjs
    TITLE SHOULD BE  Google
    CLOSE BROWSER



*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]      ${URL}     ${EXPECTED TITLE}	${BROWSER}=phantomjs
    OPEN BROWSER    ${URL}      ${BROWSER}
    TITLE SHOULD BE  ${EXPECTED TITLE}
    CLOSE BROWSER
