*** Settings ***
#Library    Selenium2Library
Library    SeleniumLibrary
Library    String
Library    Collections
Library    OperatingSystem 

Test Setup   Test_setup

#Suite Teardown    Close All Browsers



*** Keywords ***
Test_setup
     ${chrome options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome options}   add_argument    ignore-certificate-errors
    Call Method    ${chrome options}   add_argument    window-size\=1024,768
    Call Method    ${chrome options}   add_argument    headless
    Call Method    ${chrome options}   add_argument    disable-gpu
    Call Method    ${chrome options}   add_argument    no-sandbox
    #Call Method    ${chrome options}   add_argument    window-size\=1024,768
    #${options}=     Call Method     ${chrome_options}    to_capabilities      
    ${preferences}=  Create Dictionary    setAcceptUntrustedCertificates=True       setAssumeUntrustedCertificateIssuer=True
    Create Webdriver    Chrome   crm_alias      chrome_options=${chrome options}   desired_capabilities=${preferences}

Wait for element
    [arguments]  ${element}=init  ${time}=60s
    Wait Until Page Contains Element  ${element}  ${time}
    Wait Until Element Is Visible  ${element}  ${time}
    Wait Until Element Is Enabled  ${element}  ${time}
    execute javascript  document.evaluate("${element}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView();


*** Test Cases ***
Headless Chrome - Create Webdriver
    [Tags]  webui
   # Maximize Browser Window

    Go to     https://edition.cnn.com/
    Capture Page Screenshot    
    maximize browser window
    click element    (//span[text()='Edition'])[1]
	Capture Page Screenshot
    