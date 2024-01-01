*** Settings ***
Documentation     Testing About Tab, Clue Crew page - one youtube video play and pause functionality
...               1
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library

*** Test Cases ***
TC2_ProdHomePage
    #Open Browser    https://www.jeopardy.com/    chrome    options=add_argument("--disable-backgrounding-occluded-windows");add_argument("--headless");add_argument("--disable-gpu");add_argument("--no-sandbox")
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-backgrounding-occluded-windows
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    options=${options}
    Go To    https://www.jeopardy.com/
    Set Browser Implicit Wait    30s
    Set Selenium Implicit Wait    30s
    Maximize Browser Window
    ${width}    ${height}=    Get Window Size
    Comment    Set Window Size    1968    856
    Maximize Browser Window
    #sleep    10s
    Comment    Capture Page Screenshot
    ${IsElementVisible}=    Get Element Count    //*[@aria-label='Privacy']
    Comment    Run Keyword If    ${IsElementVisible}>0    Selenium2Library.Click Element    //button[contains(text(),'Accept all cookies')]
    ${src}    Selenium2Library.Get Element Attribute    (//img[@class='img-fluid'])[1]    src
    Log to console    ${src}
    ${menu_Items}    Selenium2Library.Get Element Count    //*[@id='superfish-main']/child::li[contains(@class,'menuparent')]
    FOR    ${x}    IN RANGE    1    ${menu_Items}+1
        Mouse over    (//*[@id='superfish-main']/child::li[contains(@class,'menuparent')])[${x}]
    END
