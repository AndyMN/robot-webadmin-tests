# BASE_URL, BASE_TITLE and BROWSER are passed on by Jenkins via Environment Variable
# ADMIN_USERNAME and ADMIN_PASSWORD are provided in the auth_vars.py file for security reasons
# ElementID:Expected Title dictionaries are provided in Variables.py

*** Settings ***
Library  Selenium2Library
Library  Collections
Variables	Variables.py
Variables	auth_vars.py
Suite Setup     WEBPAGE SHOULD BE REACHABLE     %{BASE_URL}     %{BASE_TITLE}     %{BROWSER}
Suite Teardown	CLOSE ALL BROWSERS



*** Test Cases ***
NAVIGATION NO LOGIN
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	NAVIGATE THROUGH DICT	${ElemID_Title_nologin}
	CLOSE BROWSER

NAVIGATION ADMIN
	LOGIN WITH CREDENTIALS		${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	ELEMENT TEXT SHOULD BE		xpath=//span[@id='userpannel.username']		${ADMIN_USERNAME}
	NAVIGATE THROUGH DICT	${ElemID_Title_admin}
	CLOSE BROWSER
	

LOGIN WITH ADMIN CREDENTIALS
	LOGIN WITH CREDENTIALS	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	ELEMENT TEXT SHOULD BE		xpath=//span[@id='userpannel.username']		${ADMIN_USERNAME}
	CLOSE BROWSER


LOGIN WITH WRONG CREDENTIALS
	LOGIN WITH CREDENTIALS	kermit	thefrog
	ELEMENT SHOULD NOT BE VISIBLE	userpannel.username
	CLOSE BROWSER


*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]         ${URL}      ${EXPECTED TITLE}	${BROWSER}
    OPEN BROWSER        ${URL}      ${BROWSER}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER


LOGIN WITH CREDENTIALS
	[Arguments]	${USERNAME}	${PASSWORD}
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	home.login
	TITLE SHOULD BE		Login
	INPUT TEXT	login.username		${USERNAME}
	INPUT PASSWORD		login.password		${PASSWORD}
	CLICK BUTTON	login.submit

NAVIGATE THROUGH DICT
	[Arguments]	${ElemID_Title_Dict}
	:FOR	${ELEM_ID}	IN	@{ElemID_Title_Dict}
	\	${EXPECTED_TITLE}=	GET FROM DICTIONARY	${ElemID_Title_Dict}	${ELEM_ID}
	\	CLICK ELEMENT	${ELEM_ID}
	\	TITLE SHOULD BE		${EXPECTED_TITLE}
