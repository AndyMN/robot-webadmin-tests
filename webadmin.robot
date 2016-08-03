# BASE_URL, BASE_TITLE and BROWSER are passed on by Jenkins via Environment Variable

*** Settings ***
Library  Selenium2Library
Library  Collections
Variables	Variables.py
Suite Setup     WEBPAGE SHOULD BE REACHABLE     %{BASE_URL}     %{BASE_TITLE}     %{BROWSER}



*** Test Cases ***
NAVIGATION
	:FOR	${ELEM_ID}	IN	@{ElemID_Title_dict}
	\	${EXPECTED_TITLE}=	GET FROM DICTIONARY	${ElemID_Title_dict}	${ELEM_ID}
	\	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	\	CLICK ELEMENT	${ELEM_ID}
	\	TITLE SHOULD BE		${EXPECTED_TITLE}
	\	CLOSE BROWSER


*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]         ${URL}      ${EXPECTED TITLE}	${BROWSER}
    OPEN BROWSER        ${URL}      ${BROWSER}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER

