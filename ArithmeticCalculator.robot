*** Settings ***
Library             SeleniumLibrary
Suite Setup         Suite Setup
Suite Teardown      Suite Teardown
Test Teardown       Test Teardown

*** Variables ***
${WEBSITE_URL}    http://output.jsbin.com/hudape/1/

${EXPECTED_ADDITION_RESULT}               2
${EXPECTED_SUBTRACTION_RESULT}            1     
${EXPECTED_MULTIPLCATION_RESULT}          2
${EXPECTED_DIVISION_RESULT}               2          
${EXPECTED_NUMBER_RESULT}                 123
${EXPECTED_BODMAS_RESULT}                 9
${EXPECTED_EXPRESSION_RESULT}             123
${EXPECTED_ERR_RESULT}                    ERR
${EXPECTED_INFINITY_RESULT}               INFINITY
${EXPECTED_LONG_RESULT}                   112233445566778899

*** Test Cases ***
Addition Of 2 Numbers
    [Tags] Testcase 1
    Click Button     xpath=//button[@value="1" and @class="numeric"]
    Click Button     xpath=//button[@value="+" and @class="operation"]
    Click Button     xpath=//button[@value="1" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_ADDITION_RESULT}  

Subtraction Of 2 Numbers
    [Tags] Testcase 2
    Click Button     xpath=//button[@value="2" and @class="numeric"]
    Click Button     xpath=//button[@value="-" and @class="operation"]
    Click Button     xpath=//button[@value="1" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_SUBTRACTION_RESULT}  

Multiplication Of 2 Numbers
    [Tags] Testcase3
    Click Button     xpath=//button[@value="1" and @class="numeric"]
    Click Button     xpath=//button[@value="*" and @class="operation"]
    Click Button     xpath=//button[@value="2" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_MULTIPLCATION_RESULT}  

Division Of 2 Numbers
    [Tags] Testcase 4
    Click Button     xpath=//button[@value="4" and @class="numeric"]
    Click Button     xpath=//button[@value="/" and @class="operation"]
    Click Button     xpath=//button[@value="2" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_DIVISION_RESULT}  

The Calculator accepts until EQ button is pressed.
    [Tags] Testcase 5
    Click Button     xpath=//button[@value="1" and @class="numeric"]
    Click Button     xpath=//button[@value="2" and @class="numeric"]
    Click Button     xpath=//button[@value="3" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_NUMBER_RESULT}

Validate BODMAS.
    [Tags] Testcase 6
    Click Button     xpath=//button[@value="2" and @class="numeric"]
    Click Button     xpath=//button[@value="*" and @class="operation"]
    Click Button     xpath=//button[@value="3" and @class="numeric"]
    Click Button     xpath=//button[@value="+" and @class="operation"]
    Click Button     xpath=//button[@value="9" and @class="numeric"]
    Click Button     xpath=//button[@value="/" and @class="operation"]
    Click Button     xpath=//button[@value="3" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_BODMAS_RESULT}
    [Teardown]     Bodmas Teardown

Validate DEL button
    [Documentation] Validate DEL button functionality. DEL button backspaces input expression by only one character.
    [Tags] Testcase 7
    Click Button     xpath=//button[@value="1" and @class="numeric"]
    Click Button     xpath=//button[@value="2" and @class="numeric"]
    Click Button     xpath=//button[@value="3" and @class="numeric"]
    Click Button     xpath=//button[@value="4" and @class="numeric"]
    Click Button     xpath=//button[@value="DEL" and @class="operation"]
    Element Text Should Be    //*[@id="expression"]    ${EXPECTED_EXPRESSION_RESULT}

Validate invalid input
    [Documentation] Verify the invalid input or expression which cannot be evaluated, and output displays 'ERR'
    [Tags] Testcase 8
    Click Button     xpath=//button[@value="9" and @class="numeric"]
    Click Button     xpath=//button[@value="*" and @class="operation"]
    Click Button     xpath=//button[@value="/" and @class="operation"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_ERR_RESULT}

Validate the expresion
    [Documentation] Verify the expression which provides output as 'Infinity'
    [Tags] Testcase 9
    Click Button     xpath=//button[@value="9" and @class="numeric"]
    Click Button     xpath=//button[@value="/" and @class="operation"]
    Click Button     xpath=//button[@value="0" and @class="numeric"]
    Click Button     xpath=//button[@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output"]    ${EXPECTED_INFINITY_RESULT}

Validate output display 
    [Documentation] Verify the output displayed properly #Failed case
    [Tags] Testcase 10
    Insert Long Input
    Click Button     xpath=//button [@value="=" and @class="operation"]
    Element Text Should Be    //*[@id="output”]  ${EXPECTED_LONG_RESULT}  
    [Teardown]     Invalid Case Teardown


*** Keywords ***
Suite Setup
    Open Browser   ${WEBSITE_URL}
	
Suite Teardown
    Close All Browsers
	
Test Teardown
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]

Bodmas Teardown
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
    Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]

Invalid Case Teardown
     FOR    ${i}    IN RANGE    18
             Click Button      xpath=//div[@class="inputs"]/button[@value="DEL"]
	         Log    ${i}
    END
	
Insert Long Input
    FOR    ${i}    IN RANGE    9
             Click Button     xpath=//button[@value="${i}" and @class="numeric"]
             Click Button     xpath=//button[@value="${i}" and @class="numeric"]
	         Log    ${i}
    END

