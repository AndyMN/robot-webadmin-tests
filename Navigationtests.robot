*** Settings ***
Library		Selenium2Library
Library		Collections
Resource	Keywords.robot
Variables	auth_vars.py
Variables	Variables.py
Suite Setup	WEBPAGE SHOULD BE REACHABLE	%{BASE_URL}	%{BASE_TITLE}	%{BROWSER}
Suite Teardown	CLOSE ALL BROWSERS

*** Variables ***
${USERNAME_ON_SITE}	xpath=//span[@id='userpannel.username']


*** Test Cases ***
NAVIGATION WITHOUT LOGIN
	[Documentation]	Clicks on each page NOT LOGGED IN and checks if it goes to the correct page
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	NAVIGATE THROUGH DICT	${ElemID_Title_nologin}
	CLOSE BROWSER

NAVIGATION AS ADMIN
	[Documentation]	Clicks on each page button AS AN ADMIN and checks if it goes to the correct page.
	LOGIN WITH CREDENTIALS		${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${ADMIN_USERNAME}
	NAVIGATE THROUGH DICT	${ElemID_Title_admin}
	CLOSE BROWSER

USER ACTION FROM EACH PAGE
	[Documentation]	Clicks on the login button in the user panel starting from every page. \n After login it should redirect to the page from where we clicked on the login button
	:FOR	${ELEM_ID}	IN	@{ElemID_Title_admin}
	\	${EXPECTED_TITLE}=	GET FROM DICTIONARY	${ElemID_Title_admin}	${ELEM_ID}
	\	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	\	CLICK ELEMENT	${ELEM_ID}
	\	CLICK ELEMENT	userpannel.action
	\	TITLE SHOULD BE		Login
	\	SUBMIT CREDENTIALS	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	\	CLICK BUTTON	login.submit
	\	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${ADMIN_USERNAME}
	\	TITLE SHOULD BE		${EXPECTED_TITLE}
	\	CLOSE BROWSER

