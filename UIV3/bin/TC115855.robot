*** settings ***
documentation  This suite will run the test cases of New UI-V2
Library    Selenium2Library
Library    String
Library    Collections
Library    DateTime
Library    OperatingSystem
Library    ../Library/HttpRobot.py
Resource   ../StepDefinition/Keywords.robot 
Resource   ../Library/variables.robot
Resource   ../Library/Locators.robot
*** variables ***
${loco_id}  166
${cust_id}  IANR
@{param_list}  Cust. ID  Loco ID  Last Communication  Brake_Cylinder_Pressure  DB Notch  EAB Setup  Latitude  Longitude  Locomotive Speed  Fuel Level  Reverser  Throttle Notch
*** test cases ***

TC115855:Login as Non IANR Customer, and verify that IANR specific columns are not visible, user should be able to see the Columns based on the Default Configuration (LIG / SMM Parameters) and the tool tip shows all teh columns as fields
    open browser  ${ui_url}  chrome
    maximize browser window
    wait until page contains element  ${login_button}  300s
    input text  ${user_name_filed}  ianr_admin
    input text  ${password_filed}  G3@dminLive2018
    capture page screenshot
    click element  ${login_button}
    wait until page contains element  ${EdgeLINC_Logo}  60s
    capture page screenshot
    wait until page contains element  ${EdgeLINC_Logo}  20s
    Capture page screenshot
    #Login to ui
    #${event_name}=  set variable  InjectedEventi1Vd
    
    wait until page contains element  //div[@class='container-title'][text()='Dashboard']  20s
    wait until page contains element  //*[@placeholder='Search']  20s
    input text  //*[@placeholder='Search']  ${cust_id}_${loco_id}
    :for  ${x}  in range  1  20
    \    ${count}=  get matching xpath count  //tbody/tr
    \    run keyword if  ${count}==1  exit for loop
    \    sleep  1s
    sleep  4s
    wait until page contains element  //tbody/tr/td  20s
    ${columns}=  get matching xpath count  //table//th
    ${columns}=  evaluate  ${columns}+1
    @{list}=  create list
    :for  ${x}  in range  1  ${columns}
    \    ${value}=  get text  (//table//th)[${x}]
    \    run keyword if  '${value}'==''  append to list  ${list}  ""
    \    ...  ELSE  append to list  ${list}  ${value}
    log  ${list}
    
    lists should be equal   ${list}   ${param_list}
    wait until page contains element  (//img[contains(@src,'assets')])[2]  20s
    click element  (//img[contains(@src,'assets')])[2]
    wait until page contains element  //*[@class='si-close-button']  20s
    ${count}=  get matching xpath count  //div[@class='datails-tooltip']/div
    ${count}=  evaluate  ${count}+1
    @{list2}=  create list
    :for  ${x}  in range  1  ${count}
    \    run keyword if  ${x}==2  append to list  ${list2}  Loco ID
    \    ${val}=  get text  (//div[@class='datails-tooltip']/div)[${x}]
    \    @{item}=  split string  ${val}  \n
    \    run keyword if  '@{item}[0]'=='----'  append to list  ${list2}  ""
    \    ...  ELSE  append to list  ${list2}  @{item}[0]
    

    log  ${list2}
    
    lists should be equal   ${list}   ${list2}
    ${loco}=  get text  (//tbody/tr/td)[1]
    ${cust}=  get text  (//tbody/tr/td)[2]
    wait until page contains element  //span[text()='${loco}_${cust}']
    
    close browser
    