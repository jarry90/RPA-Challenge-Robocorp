*** Settings ***
Documentation     A robot that completes RPAchallenge.com. Download
...               the excel file and repetitively fill the form.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           RPA.HTTP
Library           RPA.Excel.Files

*** Tasks ***
RPAchallenge.com
    Open website
    Download the excel file
    Read the excel file
    ${challenge_table}=    Read the excel file
    Start the challenge
    FOR    ${row}    IN    @{challenge_table}
        Fill form    ${row}
        Submit form
    END

*** Keywords ***
Open website
    Open Available Browser    https://www.rpachallenge.com/

Download the excel file
    ${excel_download_link}=    Get Element Attribute    xpath:/html/body/app-root/div[2]/app-rpa1/div/div[1]/div[6]/a    href
    Download    ${excel_download_link}    ${OUTPUT_DIR}${/}challenge.xlsx    overwrite=True

Read the excel file
    Open Workbook    challenge.xlsx
    ${challenge_table}=    Read Worksheet As Table    header=true
    Return From Keyword    ${challenge_table}

Start the challenge
    Click Button    Start

Fill form
    [Arguments]    ${row}
    Input Text    css:input[ng-reflect-name="labelFirstName"]    ${row}[First Name]
    Input Text    css:input[ng-reflect-name="labelLastName"]    ${row}[Last Name]
    Input Text    css:input[ng-reflect-name="labelCompanyName"]    ${row}[Company Name]
    Input Text    css:input[ng-reflect-name="labelRole"]    ${row}[Role in Company]
    Input Text    css:input[ng-reflect-name="labelAddress"]    ${row}[Address]
    Input Text    css:input[ng-reflect-name="labelEmail"]    ${row}[Email]
    Input Text    css:input[ng-reflect-name="labelPhone"]    ${row}[Phone Number]

Submit form
    Click Button    Submit
