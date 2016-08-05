
*** Keywords ***
WEBPAGE SHOULD BE REACHABLE
	[Arguments]         ${URL}      ${EXPECTED TITLE}	${BROWSER}
    	OPEN BROWSER        ${URL}      ${BROWSER}
    	TITLE SHOULD BE     ${EXPECTED TITLE}
    	CLOSE BROWSER

ABLE TO LOGIN TO PAGE
	[Arguments]	${PAGE_NAME}	${USERNAME}	${PASSWORD}
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	TITLE SHOULD BE		%{BASE_TITLE}
	LOGIN TO PAGE	${PAGE_NAME}	${USERNAME}	${PASSWORD}
	CLOSE BROWSER

GO TO PAGE
	[Arguments]	${PAGE_NAME}
	${ELEM_ID}=	GET FROM DICTIONARY	${PageName_ElemId_dict}	${PAGE_NAME}
	${WE_ARE_LOGGED_OUT}=	RUN KEYWORD AND RETURN STATUS	ELEMENT SHOULD NOT BE VISIBLE	userpannel.username
	CLICK ELEMENT	${ELEM_ID}
	${EXPECTED_TITLE}=	RUN KEYWORD IF	${WE_ARE_LOGGED_OUT}	GET FROM DICTIONARY	${ElemID_Title_nologin}	${ELEM_ID}
	...	ELSE	GET FROM DICTIONARY	${ElemID_Title_admin}	${ELEM_ID}
	TITLE SHOULD BE		${EXPECTED_TITLE}

LOGIN TO PAGE
	[Arguments]	${PAGE_NAME}	${USERNAME}	${PASSWORD}
	${ELEM_ID}=	GET FROM DICTIONARY	${PageName_ElemID_dict}	${PAGE_NAME}
	${WE_ARE_LOGGED_OUT}=	RUN KEYWORD AND RETURN STATUS	ELEMENT SHOULD NOT BE VISIBLE	userpannel.username
	RUN KEYWORD IF	${WE_ARE_LOGGED_OUT}	LOGIN	${USERNAME}	${PASSWORD}
	CLICK ELEMENT	${ELEM_ID}
	${EXPECTED_TITLE}=	GET FROM DICTIONARY	${ElemID_Title_admin}	${ELEM_ID}
	TITLE SHOULD BE		${EXPECTED_TITLE}
	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${USERNAME}

LOGIN
	[Arguments]	${USERNAME}	${PASSWORD}
	CLICK ELEMENT	userpannel.action
	SUBMIT CREDENTIALS	${USERNAME}	${PASSWORD}
	CLICK ELEMENT	login.submit


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


