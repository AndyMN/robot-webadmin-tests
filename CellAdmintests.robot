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
${DOMAINS_LIST_ELEMID}	celladmin.command.domain
${CELLS_LIST_ELEMID}	celladmin.command.cell

*** Test Cases ***
DOMAINS CHECK
	[Documentation]		Checks if there is more than 1 entry in the domains list ("Choose One" counts as 1 entry)
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	PAGE SHOULD CONTAIN LIST	${DOMAINS_LIST_ELEMID}
	${DOMAINS_LIST}=		GET LIST ITEMS	${DOMAINS_LIST_ELEMID}
	${NUMBER_Of_DOMAINS}=	GET LENGTH	${DOMAINS_LIST}	
	SHOULD BE TRUE	${NUMBER_OF_DOMAINS} > 1
	CLOSE BROWSER

CELLS CHECK
	[Documentation]		Checks if the cells list only has 1 entry, the "Choose One" entry, when no domain is slected
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	PAGE SHOULD CONTAIN LIST	${CELLS_LIST_ELEMID}
	${CELLS_LIST}=		GET LIST ITEMS	${CELLS_LIST_ELEMID}
	${NUMBER_Of_CELLS}=	GET LENGTH	${CELLS_LIST}
	SHOULD_BE_TRUE	${NUMBER_OF_CELLS}==1
	LIST SHOULD CONTAIN VALUE	${CELLS_LIST}	Choose One
	CLOSE BROWSER





