*** settings ***
documentation  This suite will run the test cases of New UI-V2
Library    Selenium2Library
Library    String
Library    Collections
Library    DateTime
Library    OperatingSystem
Library    SSHLibrary
Library    ../Library/HttpRobot.py
Resource   ../StepDefinition/Keywords.robot  
Resource   ../Library/variables.robot  
Resource   ../Library/Locators.robot  
*** test cases ***
TC96738:Verify the Validation of Events Details with Multiple Parameters & maximum of Pre & Post data
    ${event_name}=  set variable  Snapshot_auto
    Collect publishing parameters name from onboard
    login to ui and create rule bundle
    apply the rule bundle
    close browser
    ${json}=  collect snapshot event data from onboard
    
    open browser  ${ui_url}  chrome
    maximize browser window
    wait until page contains element  ${login_button}  300s
    input text  ${user_name_filed}  ${username}
    input text  ${password_filed}  ${password}
    click element  ${login_button}
    wait until page contains element  ${EdgeLINC_Logo}  100s
    capture page screenshot
    wait until page contains element  ${EdgeLINC_Logo}  20s
    Capture page screenshot
    
    
    wait until page contains element  ${Select_events}  20s
    sleep  2s
    click element  ${Select_events} 
    wait until page contains element  ${select_event_snapshot_auto}   20s
    click element  ${select_event_snapshot_auto}  
    sleep  1s
    click element  ${event_drop_down_close}
    
    input text  ${search_box}  ${loco_id}
    
    sleep  2s
    ${row}=  get matching xpath count  ${rows}
    :for  ${x}  in range  1  20
    \    ${row}=  get matching xpath count  ${rows}
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
    
    click element  ${first_event}
    
    wait until page contains element  ${event_name_rule_output}  20s
    ${event_name_rule_output1}  get text  ${event_name_rule_output}
    
    run keyword unless  '${event_name_rule_output1}'=='${event_name}'  Fail  Event name not matched
    sleep  3s
    ${count}=  get matching xpath count  ${property_count}
    ${count}=  evaluate  ${count} + 1
    :for  ${x}  in range  1  ${count}
    \    ${property_name}=  get text  (${property_count})[${x}]/div[1]
    \    ${property_value_json}=  validate property names and values end to end  ${property_name}  ${json}
    \    ${property_value}=  get text  (${property_count})[${x}]/div[2]
    \    run keyword unless  '${property_value.strip()}'=='${property_value_json.strip()}'  fail  Property name and values are not matched.
    
    #Verify_Multiple_Parameters_Listed_and_Graphs_is_Visible
    
    Validate all parameters and values end to end   ${json}
    #Validate pre and post values
    close browser
***
    login to ui and create rule bundle  
    #Login to ui
    #${event_name}=  set variable  InjectedEventFUn9
    wait until page contains element  ${Select_events}  20s
    sleep  2s
    #click element  ${Select_events} 
    input text  ${search_box}  ${event_name}
    sleep  2s
    ${row}=  get matching xpath count  ${rows}
    :for  ${x}  in range  1  20
    \    ${row}=  get matching xpath count  ${rows}
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
    
    click element  ${first_event}
    
    wait until page contains element  ${event_name_rule_output}  20s
    ${event_name_rule_output1}  get text  ${event_name_rule_output}
    
    run keyword unless  '${event_name_rule_output1}'=='${event_name}'  Fail  Event name not matched
    sleep  3s
    ${count}=  get matching xpath count  ${property_count}
    ${count}=  evaluate  ${count} + 1
    :for  ${x}  in range  1  ${count}
    \    ${property_name}=  get text  (${property_count})[${x}]/div[1]
    \    ${property_value_json}=  validate property names and values max  ${property_name}  ${file_name}
    \    ${property_value}=  get text  (${property_count})[${x}]/div[2]
    \    run keyword unless  '${property_value.strip()}'=='${property_value_json.strip()}'  fail  Property name and values are not matched.
    
    #Verify_Multiple_Parameters_Listed_and_Graphs_is_Visible
    
    Validate all parameters and values  ${file_name}
    #Validate pre and post values
    close browser