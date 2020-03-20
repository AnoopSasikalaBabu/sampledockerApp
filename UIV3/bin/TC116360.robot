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
${loco_id}  14
${cust_id}  WC
*** test cases ***

TC116360:Login as IANR user and verify that the IANR specific columns in the dashboard are visible to user and the tool tip shows all the configured columns
    Login to UI 
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
    ${columns}=  get matching xpath count  //tbody/tr/td
    ${columns}=  evaluate  ${columns}+1
    @{list}=  create list
    :for  ${x}  in range  3  ${columns}
    \    ${value}=  get text  (//tbody/tr/td)[${x}]
    \    run keyword if  '${value}'==''  append to list  ${list}  ""
    \    ...  ELSE  append to list  ${list}  ${value}
    log  ${list}
    wait until page contains element  (//img[contains(@src,'assets')])[2]  20s
    click element  (//img[contains(@src,'assets')])[2]
    wait until page contains element  //*[@class='si-close-button']  20s
    ${count}=  get matching xpath count  //div[@class='datails-tooltip']/div
    ${count}=  evaluate  ${count}+1
    @{list2}=  create list
    :for  ${x}  in range  2  ${count}
    \    ${val}=  get text  (//div[@class='datails-tooltip']/div)[${x}]
    \    @{item}=  split string  ${val}  \n
    \    run keyword if  '@{item}[1]'=='----'  append to list  ${list2}  ""
    \    ...  ELSE  append to list  ${list2}  @{item}[1]

    log  ${list2}
    
    lists should be equal   ${list}   ${list2}
    ${loco}=  get text  (//tbody/tr/td)[1]
    ${cust}=  get text  (//tbody/tr/td)[2]
    wait until page contains element  //span[text()='${loco}_${cust}']
    
    close browser
    