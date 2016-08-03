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
	\	CLICKING ELEMENT SHOULD GIVE PAGE TITLE		${ELEM_ID}	${EXPECTED_TITLE}


*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]         ${URL}      ${EXPECTED TITLE}	${BROWSER}
    OPEN BROWSER        ${URL}      ${BROWSER}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER

CLICKING ELEMENT SHOULD GIVE PAGE TITLE
    [Arguments]         ${ELEMENT ID}   ${EXPECTED TITLE}
    OPEN BROWSER        %{BASE_URL}     %{BROWSER}
    TITLE SHOULD BE     %{BASE_TITLE}
    CLICK ELEMENT       ${ELEMENT ID}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER

