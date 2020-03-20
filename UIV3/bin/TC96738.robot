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
TC96738:Verify the Validation of Events Details with Multiple Parameters & maximum of Pre & Post data
    ${file_name}=  set variable  max_data1.txt
    ${event_name}  Login to UI and Generated Event max  event
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
*** 
TC96738:Verify the Validation of Events Details with Multiple Parameters & maximum of Pre & Post data
    ${file_name}=  set variable  real_rule.txt
    #${event_name}  Login to UI and Generated Event max  event
    Login to ui
    ${event_name}=  set variable  Snapshot
    wait until page contains element  ${Select_events}  20s
    sleep  2s
    #click element  ${Select_events} 
    click element  //span[text()='Search and Select Event Type']
    sleep  1s
    click element  (//span[text()=' Snapshot ']//preceding::*[contains(@class,'mat-pseudo-checkbox')])[last()]  
    sleep  2s
    Click element  //*[@class='cdk-overlay-container']
    input text  ${search_box}  12
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
    
    click element  //tbody/tr[3]/td[1]
    
    wait until page contains element  ${event_name_rule_output}  20s
    ${event_name_rule_output1}  get text  ${event_name_rule_output}
    
    run keyword unless  '${event_name_rule_output1}'=='${event_name}'  Fail  Event name not matched
    sleep  3s
    ${count}=  get matching xpath count  ${property_count}
    ${count}=  evaluate  ${count} + 1
    :for  ${x}  in range  1  ${count}
    \    ${property_name}=  get text  ${property_count}[${x}]/div[1]
    \    ${property_value_json}=  validate property names and values max  ${property_name}  ${file_name}
    \    ${property_value}=  get text  ${property_count}[${x}]/div[2]
    \    run keyword unless  '${property_value.strip()}'=='${property_value_json.strip()}'  fail  Property name and values are not matched.
    
    #Verify_Multiple_Parameters_Listed_and_Graphs_is_Visible
    
    Validate all parameters and values  ${file_name}
    #Validate pre and post values
    close browser
  
create multiple events
    :for  ${x}  in range  1  30
    \     ${event_name}=  random event max  event

