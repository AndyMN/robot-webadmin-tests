*** Settings ***
Library		Selenium2Library
Library		Collections
Resource	Keywords.robot
Resource	Variables.robot
Variables	auth_vars.py
Variables	Variables.py
Suite Setup	ABLE TO LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
Suite Teardown	CLOSE ALL BROWSERS


*** Variables ***
${PAGE_NAME}	Home



*** Test Cases ***
LOGOUT WHEN ALREADY LOGGED OUT
	[Documentation]		Tests what happens when we click the logout symbol on the Home page when already logged out
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	GO TO PAGE	${PAGE_NAME}
	CLICK ELEMENT	home.logout
	ELEMENT TEXT SHOULD BE	home.feedback	Can't log out - You are not logged in!
	CLOSE BROWSER
