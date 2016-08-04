
*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
    [Arguments]         ${URL}      ${EXPECTED TITLE}	${BROWSER}
    OPEN BROWSER        ${URL}      ${BROWSER}
    TITLE SHOULD BE     ${EXPECTED TITLE}
    CLOSE BROWSER

SUBMIT CREDENTIALS
    [Arguments]     ${USERNAME}     ${PASSWORD}
    INPUT TEXT      login.username      ${USERNAME}
    INPUT PASSWORD  login.password      ${PASSWORD}

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
