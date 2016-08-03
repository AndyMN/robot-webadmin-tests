# BASE_URL, BASE_TITLE and BROWSER are passed on by Jenkins via Environment Variable
# USERNAME and PASSWORD are provided in the auth_vars.py file for security reasons

*** Settings ***
Library  Selenium2Library
Library  Collections
Variables	Variables.py
Variables	auth_vars.py
Suite Setup     WEBPAGE SHOULD BE REACHABLE     %{BASE_URL}     %{BASE_TITLE}     %{BROWSER}



*** Test Cases ***
NAVIGATION
	:FOR	${ELEM_ID}	IN	@{ElemID_Title_dict}
	\	${EXPECTED_TITLE}=	GET FROM DICTIONARY	${ElemID_Title_dict}	${ELEM_ID}
	\	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	\	CLICK ELEMENT	${ELEM_ID}
	\	TITLE SHOULD BE		${EXPECTED_TITLE}
	\	CLOSE BROWSER

LOGIN WITH CORRECT CREDENTIALS
	LOGIN WITH CREDENTIALS	${USERNAME}	${PASSWORD}
	ELEMENT SHOULD BE VISIBLE	userpannel.username
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
