*** Settings ***
Documentation     Testing About Tab, Clue Crew page - one youtube video play and pause functionality
...               1
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library

*** Test Cases ***
TC2_ProdHomePage
    #Open Browser    https://www.jeopardy.com/    chrome    options=add_argument("--disable-backgrounding-occluded-windows");add_argument("--headless");add_argument("--disable-gpu");add_argument("--no-sandbox")
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-backgrounding-occluded-windows
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    #Call Method    ${options}    add_argument    --window-size=1968,856
    Set Selenium Implicit Wait    50s
    Set Selenium Timeout    30s
    Create Webdriver    Chrome    options=${options}
    Go To    https://www.jeopardy.com/
    Maximize Browser Window
    ${width}    ${height}=    Get Window Size
    Set Browser Implicit Wait    40s
    Set Window Size    1968    856
    ${width}    ${height}=    Get Window Size
    sleep    10s
    Comment    Capture Page Screenshot
    ${IsElementVisible}=    Get Element Count    //*[@aria-label='Privacy']
    Comment    Run Keyword If    ${IsElementVisible}>0    Selenium2Library.Click Element    //button[contains(text(),'Accept all cookies')]
    ${src}    Selenium2Library.Get Element Attribute    (//img[@class='img-fluid'])[1]    src
    Log to console    ${src}
    ${menu_Items}    Selenium2Library.Get Element Count    //*[@id='superfish-main']/child::li[contains(@class,'menuparent')]
    FOR    ${x}    IN RANGE    1    ${menu_Items}+1
        Mouse over    (//*[@id='superfish-main']/child::li[contains(@class,'menuparent')])[${x}]
    END
