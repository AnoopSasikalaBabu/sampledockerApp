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
TC96744:Verify the parameters and properties displayed in rule output page
    ${file_name}=  set variable  lat_long_data.txt
    ${event_name}  ${request_body}  Login to UI and Generated Event  event
    #Login to ui
    #${event_name}=  set variable  InjectedEventi1Vd
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
    click element  //tbody/tr[1]/td[1]
    
    wait until page contains element  ${event_name_rule_output}  20s
    ${event_name_rule_output1}  get text  ${event_name_rule_output}
    capture page screenshot
    run keyword unless  '${event_name_rule_output1}'=='${event_name}'  Fail  Event name not matched
    sleep  3s
    ${count}=  get matching xpath count  ${property_count}
    ${count}=  evaluate  ${count} + 1
    :for  ${x}  in range  1  ${count}
    \    ${property_name}=  get text  (${property_count})[${x}]/div[1]
    \    ${property_value_json}=  validate property names and values  ${property_name}  ${request_body}
    \    ${property_value}=  get text  (${property_count})[${x}]/div[2]
    \    run keyword unless  '${property_value.strip()}'=='${property_value_json.strip()}'  fail  Property name and values are not matched.
    
    #Verify_Multiple_Parameters_Listed_and_Graphs_is_Visible
    
    Validate all parameters and values  ${file_name}
    Validate pre and post values
    validate event line
    close browser
