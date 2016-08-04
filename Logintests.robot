*** Settings ***
Resource	Keywords.robot
Variables	auth_vars.py
Library		Collections
Library  	Selenium2Library
Suite Setup     WEBPAGE SHOULD BE REACHABLE     %{BASE_URL}     %{BASE_TITLE}   %{BROWSER}
Suite Teardown  CLOSE ALL BROWSERS


*** Variables ***
${USERNAME_ON_SITE}	xpath=//span[@id='userpannel.username']


*** Test Cases ***
LOGIN VIA SYMBOL
    	[Documentation]		Login using the symbol on the home page.
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	home.login
	TITLE SHOULD BE		Login
	SUBMIT CREDENTIALS  ${ADMIN_USERNAME}   ${ADMIN_PASSWORD}
	CLICK BUTTON	login.submit
	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${ADMIN_USERNAME}
	CLOSE BROWSER

LOGIN VIA USER ACTION
	[Documentation]		Login using the login button in the user panel.
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	userpannel.action
	TITLE SHOULD BE		Login
	SUBMIT CREDENTIALS	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	CLICK BUTTON	login.submit
	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${ADMIN_USERNAME}
	CLOSE BROWSER

RESET BUTTON
	[Documentation]		Checks if the reset button on the login screen empties the text fields of the login form.
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	userpannel.action
	TITLE SHOULD BE		Login
	SUBMIT CREDENTIALS	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	CLICK BUTTON	login.reset
	ELEMENT TEXT SHOULD BE		login.username		${EMPTY}
	ELEMENT TEXT SHOULD BE		login.password		${EMPTY}
	CLOSE BROWSER
	
LOGIN THEN LOGOUT VIA USER ACTION
	[Documentation]		Login then logout using the button on the user panel
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	userpannel.action
	TITLE SHOULD BE		Login
	SUBMIT CREDENTIALS	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	CLICK BUTTON	login.submit
	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${ADMIN_USERNAME}
	CLICK ELEMENT	userpannel.action
	ELEMENT SHOULD NOT BE VISIBLE	userpannel.username
	CLOSE BROWSER

LOGIN THEN LOGOUT VIA SYMBOL
	[Documentation]		Login then logout using the symbol on the home page
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	CLICK ELEMENT	home.login
	TITLE SHOULD BE		Login
	SUBMIT CREDENTIALS	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	CLICK BUTTON	login.submit
	ELEMENT TEXT SHOULD BE		${USERNAME_ON_SITE}	${ADMIN_USERNAME}
	TITLE SHOULD BE		dCache Overview
	CLICK ELEMENT	home.logout
	ELEMENT SHOULD NOT BE VISIBLE	userpannel.username
