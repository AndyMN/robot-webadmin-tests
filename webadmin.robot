*** Settings ***
Library  Selenium2Library
Suite Setup     WEBPAGE SHOULD BE REACHABLE     ${BASE_URL}     ${BASE_TITLE}     ${BROWSER}
Test Template   CLICKING ELEMENT SHOULD GIVE PAGE TITLE



*** Variables ***
${BASE_URL}     http://prometheus.desy.de:2288/webadmin
${BASE_TITLE}   dCache Overview
${BROWSER}      phantomjs

*** Test Cases ***
HOME                nav.home        ${BASE_TITLE}
CELL SERVICES       nav.cells       Services
POOL USAGE          nav.pools       Pool Usage
POOL QUEUES         nav.poolqueues  Pool Request Queues
POOL QUEUE PLOTS    nav.poolqueueplots  Pool Queue Activity Plots
POOLGROUPS          nav.poolgroups  Pool Property Tables
TAPE TRANSFER QUEUE     nav.tapetransfers   dCache Dataset Restore Monitor
ACTIVE TRANSFERS    nav.activetransfers     Active Transfers
BILLING PLOTS       nav.billing     Billing History Plots
POOL SELECTION SETUP    nav.poolselection   PoolManager (Pool SelectionUnit) Configuration





*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]         ${URL}      ${EXPECTED TITLE}	${BROWSER}
    OPEN BROWSER        ${URL}      ${BROWSER}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER

CLICKING ELEMENT SHOULD GIVE PAGE TITLE
    [Arguments]         ${ELEMENT ID}   ${EXPECTED TITLE}
    OPEN BROWSER        ${BASE_URL}     ${BROWSER}
    TITLE SHOULD BE     ${BASE_TITLE}
    CLICK ELEMENT       ${ELEMENT ID}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER

