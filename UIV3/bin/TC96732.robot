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
*** test cases ***

TC96732:Verify the Event generated for Onboard rule bundle
    ${event_name}  ${request_body}  Login to UI and Generated Event  event
    #Login to ui
    #${event_name}=  set variable  InjectedEventi1Vd
 *** 
    log  ${event_name}
    wait until page contains element  ${Select_events}  20s
    sleep  2s
    #click element  ${Select_events} 
    input text  ${search_box}  ${event_name}
    sleep  2s
    ${row}=  get matching xpath count  ${rows}
    :for  ${x}  in range  1  20
    \    run keyword if  ${row}==1  exit for loop
    \    sleep  1s
    ${event_name_ui}=  get text  ${first_event_name}
    run keyword unless  '${event_name_ui}'=='${event_name}'  Fail  Event name not matched
    
    ${cust_id_ui}  get text  ${first_event_cust_id}
    run keyword unless  '${cust_id_ui}'=='${cust_id}'  Fail  Customer Id not matched
    
    ${loco_id_ui}  get text  ${first_event_loco_id}
    run keyword unless  '${loco_id_ui}'=='${loco_id}'  Fail  Loco Id not matched
    
    ${device_name}=  get text  ${first_event_device_name}
    run keyword unless  '${device_name}'=='SMM'  Fail  Device name not matched
    capture page screenshot
    close browser