*** Settings ***
Resource  Keywords.robot
Library     Collections
Library  Selenium2Library
Suite Setup     WEBPAGE SHOULD BE REACHABLE     %{BASE_URL}     %{BASE_TITLE}   %{BROWSER}
Suite Teardown  CLOSE ALL BROWSERS



*** Test Cases ***
LOGIN VIA SYMBOL
    OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	home.login
	TITLE SHOULD BE		Login
	SUBMIT CREDENTIALS  ${ADMIN_USERNAME}   ${ADMIN_PASSWORD}
	CLICK BUTTON	login.submit
	ELEMENT TEXT SHOULD BE		xpath=//span[@id='userpannel.username']		${ADMIN_USERNAME}
