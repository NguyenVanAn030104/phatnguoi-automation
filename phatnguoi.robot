*** Settings ***
Library           SeleniumLibrary
Library           OCR.py
Library           OperatingSystem
Library           RequestsLibrary

Suite Setup       Open Browser To Website
Suite Teardown    Close Browser

*** Variables ***
${URL}            https://www.csgt.vn/tra-cuu-phuong-tien-vi-pham.htm
${BROWSER}        Chrome
${BIEN_SO_XE}     29A84222
${LOAI_XE}        Ô tô
${CAPTCHA_PATH}   ${CURDIR}${/}captcha.png
${KET_QUA_FILE}   ${CURDIR}${/}ket_qua.txt

*** Test Cases ***
Tra Cuu Phat Nguoi
    Nhap Thong Tin Xe
    Xu Ly Ma Bao Mat Va Tim Kiem
    Kiem Tra Ket Qua

*** Keywords ***
Open Browser To Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    1s

Nhap Thong Tin Xe
    Input Text    name=BienKiemSoat    ${BIEN_SO_XE}
    Select From List By Label    name=LoaiXe    ${LOAI_XE}
    Sleep    1s

Xu Ly Ma Bao Mat Va Tim Kiem
   FOR    ${i}    IN RANGE    10
        # Nhập lại biển số xe và loại xe mỗi lần reload
        Input Text    name=BienKiemSoat    ${BIEN_SO_XE}
        Select From List By Label    name=LoaiXe    ${LOAI_XE}
        Wait Until Element Is Visible    id=imgCaptcha    timeout=10s
        Capture Element Screenshot    id=imgCaptcha    ${CAPTCHA_PATH}
        ${captcha_text}=    Process Captcha    ${CAPTCHA_PATH}
        Log To Console    >>> CAPTCHA: ${captcha_text}
        Input Text    name=txt_captcha    ${captcha_text}
        Click Element    xpath=//input[@type='button' and @value='Tra cứu']
        Sleep    5s
        # Kiểm tra nếu có thông báo CAPTCHA sai
        ${captcha_error}=    Run Keyword And Return Status    Element Should Contain    xpath=//div[@class='xe_texterror']    Mã xác nhận sai!
        Run Keyword If    ${captcha_error}    Reload Page
        Run Keyword If    '${captcha_error}' == 'False'    Exit For Loop
        Log    CAPTCHA sai, thử lại...
    END
    Log    Không thể xác thực CAPTCHA sau 10 lần thử

Kiem Tra Ket Qua
    Wait Until Element Is Visible    xpath=//div[@id='bodyPrint123']    timeout=10s
    ${noidung}=    Get Text    xpath=//div[@id='bodyPrint123']
    Log To Console    >>> KET QUA:\n${noidung}
    Create File    ${KET_QUA_FILE}    ${noidung}
