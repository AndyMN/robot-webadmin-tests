*** Settings ***
Resource	Keywords.robot
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
	SHOULD BE TRUE	${NUMBER_OF_CELLS}==1
	LIST SHOULD CONTAIN VALUE	${CELLS_LIST}	Choose One
	CLOSE BROWSER

CELLS WHEN DOMAIN IS SELECTED
	[Documentation]		Checks if there are more than 1 cell when a domain is selected
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	${DOMAINS_LIST}=	GET LIST ITEMS	${DOMAINS_LIST_ELEMID}
	${DOMAIN}=	GET FROM LIST	${DOMAINS_LIST}		-1
	SHOULD NOT BE EQUAL	${DOMAIN}	Choose One
	SELECT FROM LIST BY LABEL	${DOMAINS_LIST_ELEMID}	${DOMAIN}
	# Selecting a domain triggers an AJAX event. By refreshing the page we remove the need to have delays or waits in the test
	RELOAD PAGE
	${CELLS_LIST}=	GET LIST ITEMS	${CELLS_LIST_ELEMID}	
	${NUMBER_Of_CELLS}=	GET LENGTH	${CELLS_LIST}
	SHOULD BE TRUE		${NUMBER_OF_CELLS} > 1
	CLOSE BROWSER

PING COMMAND RESPONSE
	[Documentation]		Checks that the response of command xyzzy is "Nothing happens."
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	${DOMAINS_LIST}=	GET LIST ITEMS	${DOMAINS_LIST_ELEMID}
	${DOMAIN}=	GET FROM LIST	${DOMAINS_LIST}		-1
	SHOULD NOT BE EQUAL	${DOMAIN}	Choose One
	SELECT FROM LIST BY LABEL	${DOMAINS_LIST_ELEMID}	${DOMAIN}
	RELOAD PAGE
	${CELLS_LIST}=	GET LIST ITEMS	${CELLS_LIST_ELEMID}
	${CELL}=	GET FROM LIST	${CELLS_LIST}		-1
	SHOULD NOT BE EQUAL	${CELL}		Choose One
	SELECT FROM LIST BY LABEL	${CELLS_LIST_ELEMID}	${CELL}
	INPUT TEXT	celladmin.command.text	xyzzy
	CLICK ELEMENT	celladmin.command.submit
	ELEMENT TEXT SHOULD BE	celladmin.command.response	Nothing happens.
	CLOSE BROWSER	

PING COMMAND LABEL
	[Documentation]		Checks that if we send a command the label of the receiver is correct CELL@DOMAIN
	OPEN BROWSER	%{BASE_URL}	%{BROWSER}
	LOGIN TO PAGE	${PAGE_NAME}	${ADMIN_USERNAME}	${ADMIN_PASSWORD}
	${DOMAINS_LIST}=	GET LIST ITEMS	${DOMAINS_LIST_ELEMID}
	${DOMAIN}=	GET FROM LIST	${DOMAINS_LIST}		-1
	SHOULD NOT BE EQUAL	${DOMAIN}	Choose One
	SELECT FROM LIST BY LABEL	${DOMAINS_LIST_ELEMID}	${DOMAIN}
	RELOAD PAGE
	${CELLS_LIST}=	GET LIST ITEMS	${CELLS_LIST_ELEMID}
	${CELL}=	GET FROM LIST	${CELLS_LIST}	-1
	SHOULD NOT BE EQUAL	${CELL}		Choose One
	SELECT FROM LIST BY LABEL	${CELLS_LIST_ELEMID}	${CELL}
	INPUT TEXT	celladmin.command.text	xyzzy
	CLICK ELEMENT	celladmin.command.submit
	ELEMENT TEXT SHOULD BE	celladmin.command.receiver	Response of ${CELL}@${DOMAIN}
	CLOSE BROWSER
