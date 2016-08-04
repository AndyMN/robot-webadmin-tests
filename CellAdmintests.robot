*** Settings ***
Resource	Keywords.robot
Resource	Variables.robot
Variables	auth_vars.py
Variables	Variables.py
Library		Collections
Library		Selenium2Library
Suite Setup	ABLE TO LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
Suite Teardown	CLOSE ALL BROWSERS

*** Variables ***

${PAGE_NAME}	Cell Admin


*** Test Cases ***
DOMAINS CHECK
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	CLOSE BROWSER




