
var timer = undefined;
var apiPwd = document.getElementById('copy-apiss')
let msg = ''
let res = []
let oldEl = $('#accountbind-form').html()
let isClick = false
init();
function init () {
    var keyValue = localStorage.getItem('security_opera_layer')
    if (keyValue === 'phone') {
        getModal('bind_phone_change', '绑定新手机')
        localStorage.setItem('security_opera_layer', '')
    } else if (keyValue === 'email') {
        getModal('change_email_handle', '绑定新邮箱')
        localStorage.setItem('security_opera_layer', '')
    }

}
$.fn.togglePassword = function (options) {

    var s = $.extend($.fn.togglePassword.defaults, options)
        , input = $(this);
    $(s.el).bind(s.ev, function () {
        "password" == $(input).attr("type") ? $(input).attr("type", "text") : $(input).attr("type", "password")
    })
};
$.fn.togglePassword.defaults = {
    ev: "click"
}
$('.api_passwordss').togglePassword({
    el: '.btn-password'
});

function checkListFormVerify (arr) {
    var result = false
    arr.forEach(function (item) {
        var InpCheck = document.getElementById(item)
        if (InpCheck && InpCheck.value == '') {
            InpCheck.classList.add("is-invalid"); //添加非法状态
            result = true
        } else if (InpCheck) {
            InpCheck.classList.remove("is-invalid");
        }
    })
    return result
}

// 验证表单-通过直接调用接口
function modifyPwdCheckForm () {
    var oldPwd = document.getElementById('oldPwd')
    var pwd = document.getElementById('pwd')
    var rePwd = document.getElementById('rePwd')
    if (oldPwd && oldPwd.value == '') {
        oldPwd.classList.remove("is-valid"); //清除合法状态
        oldPwd.classList.add("is-invalid"); //添加非法状态
        return
    } else if (oldPwd) {
        oldPwd.classList.remove("is-invalid");
        oldPwd.classList.add("is-valid");
    }
    if (pwd.value == '') {
        pwd.classList.remove("is-valid"); //清除合法状态
        pwd.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        pwd.classList.remove("is-invalid");
        pwd.classList.add("is-valid");
    }
    if (rePwd.value == '') {
        rePwd.classList.remove("is-valid"); //清除合法状态
        rePwd.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        rePwd.classList.remove("is-invalid");
        rePwd.classList.add("is-valid");
    }

    /* if(checkListFormVerify(['captcha_allow_setpwd_captcha'])){
      return
    } */


    // 0208 二次验证
    if (isNeedSecond('modify_password')) {
        $('#modifyPasswordModal').modal('hide')
        getSecondModal('modify_password', function (type, code) {
            modifyPwdApi(type, code)
        })
    } else {
        modifyPwdApi()
    }

}

function modifyPwdApi (type, code) {
    var captcha = is_password == 1 ? $('#captcha_allow_resetpwd_captcha').val() : $('#captcha_allow_setpwd_captcha').val();
    $.ajax({
        url: _url + '/modify_password',
        type: 'POST',
        data: { flag: is_password == 1 ? 1 : 2, old_password: is_password == 1 ? oldPwd.value : '', password: pwd.value, re_password: rePwd.value, code: code, captcha: captcha },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                setTimeout(function () {
                    location.href = _url + '/login';
                }, 2000);
            } else {
                if (is_password == 1)
                    $('#allow_setpwd_captcha').click()
                else
                    $('#allow_resetpwd_captcha').click()
                toastr.error(data.msg);
            }
        }
    });
}

// 验证表单-通过直接调用接口
function bindPhoneCheckForm () {
    var phoneNum = document.getElementById('phoneNum')
    var code = document.getElementById('code')
    if (phoneNum.value == '') {
        phoneNum.classList.remove("is-valid"); //清除合法状态
        phoneNum.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        phoneNum.classList.remove("is-invalid");
        phoneNum.classList.add("is-valid");
    }
    if (code.value == '') {
        code.classList.remove("is-valid"); //清除合法状态
        code.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code.classList.remove("is-invalid");
        code.classList.add("is-valid");
    }

    /*if(checkListFormVerify(['captcha_allow_phone_bind_captcha'])){
      return
    }*/

    $.ajax({
        url: _url + '/bind_phone_handle',
        type: 'POST',
        data: { phone_code: '+86', phone: phoneNum.value, code: code.value },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#bindPhoneModal').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}
function phoneChangeBtn () {
    var oldTel = document.getElementById('oldTel')
    var code1 = document.getElementById('bindPhoneChangeCode1')
    if (code1.value == '') {
        code1.classList.remove("is-valid"); //清除合法状态
        code1.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code1.classList.remove("is-invalid");
        code1.classList.add("is-valid");
    }
    bindPhoneChangeApi(oldTel, code1, 1)
}

function phoneChangeBtn2 () {
    var newTel = document.getElementById('newTel')
    var code2 = document.getElementById('bindPhoneChangeCode2')

    if (newTel.value == '') {
        newTel.classList.remove("is-valid"); //清除合法状态
        newTel.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        newTel.classList.remove("is-invalid");
        newTel.classList.add("is-valid");
    }
    if (code2.value == '') {
        code2.classList.remove("is-valid"); //清除合法状态
        code2.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code2.classList.remove("is-invalid");
        code2.classList.add("is-valid");
    }
    /*if(checkListFormVerify(['captcha_allow_setpwd_captcha'])){
      return
    }*/
    bindPhoneChangeApi(newTel, code2, 2)
}

$('#bindPhoneChangeModal2').on('hide.bs.modal', function () {
    location.reload()
    clearInterval(timer)
})

// 验证表单-通过直接调用接口
function bindPhoneChangeApi (tel, code, modalType) {
    $.ajax({
        url: _url + '/bind_phone_change',
        type: 'POST',
        data: { phone_code: '+86', tel: tel.value, code: code.value, type: modalType },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#bindPhoneChangeModal1').modal('hide')
                // phoneType
                if (modalType == 1) {
                    setTimeout(function () {
                        $('#bindPhoneChangeModal2').modal('show')
                    }, 1000);
                }
                if (modalType == 2) {
                    $('#bindPhoneChangeModal2').modal('hide')
                    location.reload()
                }

            } else {
                toastr.error(data.msg);
            }
        }
    });
}

// 验证表单-通过直接调用接口
function loginSmsReminderCheckForm () {
    var code = document.getElementById('loginSmsReminderCode')

    if (code.value == '') {
        code.classList.remove("is-valid"); //清除合法状态
        code.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code.classList.remove("is-invalid");
        code.classList.add("is-valid");
    }

    $.ajax({
        url: _url + '/login_sms_reminder',
        type: 'POST',
        data: { status: 0, code: code.value },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#loginSmsReminderModal').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}
function smsSubmitOpenBtn () {
    $.ajax({
        url: _url + '/login_sms_reminder',
        type: 'POST',
        data: { status: 1 },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#loginSmsReminderModalOpen').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}

// 验证表单-通过直接调用接口
function bindEmailHandleCheckForm () {
    var email = document.getElementById('bindEmailHandleEmail')
    var code = document.getElementById('bindEmailHandleCode')
    if (email.value == '') {
        email.classList.remove("is-valid"); //清除合法状态
        email.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        email.classList.remove("is-invalid");
        email.classList.add("is-valid");
    }
    if (code.value == '') {
        code.classList.remove("is-valid"); //清除合法状态
        code.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code.classList.remove("is-invalid");
        code.classList.add("is-valid");
    }

    $.ajax({
        url: _url + '/bind_email_handle',
        type: 'POST',
        data: { email: email.value, code: code.value },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#bindEmailHandleModal').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}

function changeEmailBtn () {
    var email1 = document.getElementById('changeEmailHandleEmail1')
    var code1 = document.getElementById('changeEmailHandleCode1')
    if (code1.value == '') {
        code1.classList.remove("is-valid"); //清除合法状态
        code1.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code1.classList.remove("is-invalid");
        code1.classList.add("is-valid");
    }
    changeEmailHandleApi(email1, code1, 1)
}

function changeEmailBtn2 () {
    var email2 = document.getElementById('changeEmailHandleEmail2')
    var code2 = document.getElementById('changeEmailHandleCode2')

    if (email2.value == '') {
        email2.classList.remove("is-valid"); //清除合法状态
        email2.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        email2.classList.remove("is-invalid");
        email2.classList.add("is-valid");
    }
    if (code2.value == '') {
        code2.classList.remove("is-valid"); //清除合法状态
        code2.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code2.classList.remove("is-invalid");
        code2.classList.add("is-valid");
    }
    changeEmailHandleApi(email2, code2, 2)
}

$('#changeEmailHandleModal2').on('hide.bs.modal', function () {
    location.reload()
    clearInterval(timer)
})

// 验证表单-通过直接调用接口
function changeEmailHandleApi (email, code, modalType) {
    $.ajax({
        url: _url + '/change_email_handle',
        type: 'POST',
        data: { phone_code: '+86', email: email.value, code: code.value, type: modalType },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#changeEmailHandleModal1').modal('hide')

                if (modalType == 1) {
                    setTimeout(function () {
                        $('#changeEmailHandleModal2').modal('show')
                    }, 1000);
                }
                if (modalType == 2) {
                    $('#changeEmailHandleModal2').modal('hide')
                    location.reload()
                }

            } else {
                toastr.error(data.msg);
            }
        }
    });
}

// 验证表单-通过直接调用接口
function loginEmailReminderCheckForm () {
    var code = document.getElementById('loginEmailReminderCode')

    if (code.value == '') {
        code.classList.remove("is-valid"); //清除合法状态
        code.classList.add("is-invalid"); //添加非法状态
        return
    } else {
        code.classList.remove("is-invalid");
        code.classList.add("is-valid");
    }

    $.ajax({
        url: _url + '/login_email_reminder',
        type: 'POST',
        data: { status: 0, code: code.value },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#loginEmailReminderModal').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}

function loginEmailReminderSubmitOpen () {
    $.ajax({
        url: _url + '/login_email_reminder',
        type: 'POST',
        data: { status: 1 },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#loginEmailReminderModalOpen').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}

//二次验证关闭 -----------------------------start
// 验证表单-通过直接调用接口
function closeSecondHandleClick () {
    // 0208
    if (isNeedSecond('closed')) {
        getSecondModal('closed', function (type, code) {
            closeSecond(type, code)
        })
    } else {
        getModalConfirm('确定关闭二次验证?', function () {
            closeSecond()
        })
    }
}

function closeSecond (type, code) {
    $.ajax({
        url: _url + '/toggle_second_verify',
        type: 'POST',
        data: { second_verify: 0, type: type, code: code },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#toggleSecondVerifyModal').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}
// ------------------------------------end
function toggleSecondVerifySubmitOpen () {
    $.ajax({
        url: _url + '/toggle_second_verify',
        type: 'POST',
        data: { second_verify: 1 },
        dataType: 'json',
        beforeSend: function () { },
        success: function (data) {
            if (data.status == '200') {
                toastr.success(data.msg);
                $('#toggleSecondVerifyModalOpen').modal('hide')
                location.reload()
            } else {
                toastr.error(data.msg);
            }
        }
    });
}

function getapiModalCheckForm () {
    const postObj = {}
    let isChecked = 0
  
    if (isClick) {
        $('#interflowModal').modal('hide')
        isClick = false
        return
    }
    isClick = true

    $.ajax({
        url: 'interflow/accountbind',
        type: 'POST',
        data: {
            qq: $("#interflowModal input[name='qq']").val()
        },
        success: function (data) {
            if (data.status == '200') {
                $.ajax({
                    type: 'GET',
                    url: '/interflow/accountbind',
                    contentType: 'application/json;charset=UTF-8',
                    dataType: 'json',
                    success: function (data) {
                        if (data.status == '200') {
                            
                            toastr.success(data.msg)
                            $('#interflowModal').modal('hide')
                        } else {
                            toastr.error(data.msg);
                        }
                        
                    }
                     
                });

               

            } else {
                toastr.error(data.msg);
            }
        }
    });
}

// 0208
// 查看api 为后台同步输出, 此处无法二次验证
function showApiPwdHandleClick () {
    // if (isNeedSecond('get_api_pwd')) {
    // 	getSecondModal('get_api_pwd', function (type, code) {
    // 		$('#getapiModal').modal('show')
    // 	})
    // } else {
    // 	$('#getapiModal').modal('show')
    // }
    $('#getapiModal').modal('show')
}



// Scope verification requests to their own modal: MDUI may replace button classes.
function securityNotice (message, success) {
    if (window.toastr) {
        toastr[success ? 'success' : 'error'](message);
    } else if (window.mdui && mdui.snackbar) {
        mdui.snackbar({ message: message });
    } else {
        window.alert(message);
    }
}

function getCheckCode (action, name, button, method, type, modal, captcha) {
    var $modal = $('#' + modal);
    if (!$modal.length) return false;
    var $btn = $modal.find('.' + button);
    if (!$btn.length) $btn = $modal.find('button[onclick*="' + action + '"]');
    $btn = $btn.first();
    if (!$btn.length || $btn.data('disabled') || $btn.prop('disabled')) return false;

    var $input = $modal.find('input[name="' + name + '"]');
    if (!$input.length && name === 'tel') $input = $modal.find('input[name="phone"]');
    if (action === 'second_verify_send') $input = $modal.find('select[name="' + name + '"]');
    var inputValue = $input.val();
    if (!inputValue || !String(inputValue).trim()) {
        securityNotice(name === 'email' ? '请填写邮箱地址' : '请填写验证信息');
        return false;
    }
    var formData = { phone_code: '+86' };
    if (type !== undefined && type !== null) formData.type = type;
    formData[name] = String(inputValue).trim();
    if (action === 'second_verify_send') formData.action = 'closed';

    var captchaEl = captcha ? document.getElementById(captcha) : null;
    var $captcha = captchaEl && $.contains($modal[0], captchaEl)
        ? $(captchaEl) : $modal.find('input[name="captcha"]').first();
    if ($captcha.length && $captcha.val()) formData.captcha = $captcha.val();
    // Only explicitly named tokens belong in the request, never arbitrary hidden inputs.
    $modal.find('input[name="token"], input[name="__token__"]').each(function () {
        if (this.value) formData[this.name] = this.value;
    });

    var originalText = $btn.text();
    function release () {
        $btn.text(originalText).prop('disabled', false).removeAttr('disabled').removeData('disabled');
    }
    function refreshCaptcha () {
        $modal.find('img[onclick*="getVerify"]').first().trigger('click');
    }
    function parseResponse (data) {
        if (typeof data === 'string') {
            try { return JSON.parse(data); } catch (e) { return null; }
        }
        return data;
    }
    $btn.data('disabled', true).prop('disabled', true);
    var baseUrl = typeof WebUrl !== 'undefined' && WebUrl ? WebUrl : '/';
    $.ajax({
        url: baseUrl.replace(/\/$/, '') + '/' + action.replace(/^\//, ''),
        type: method || 'get',
        data: formData,
        timeout: 30000,
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        success: function (response) {
            var data = parseResponse(response);
            if (data && data.status == 200) {
                securityNotice(data.msg || '验证码发送成功', true);
                var remaining = 60;
                $btn.text(remaining + 's后重试');
                var countdown = setInterval(function () {
                    remaining--;
                    if (remaining <= 0) {
                        clearInterval(countdown);
                        release();
                    } else {
                        $btn.text(remaining + 's后重试');
                    }
                }, 1000);
            } else {
                release();
                refreshCaptcha();
                securityNotice(data && data.msg ? data.msg : '发送失败，请刷新页面后重试');
            }
        },
        error: function (xhr, status) {
            release();
            refreshCaptcha();
            var data = xhr.responseJSON || parseResponse(xhr.responseText);
            var message = status === 'timeout' ? '请求超时，请稍后重试' :
                (xhr.status >= 500 ? '验证码服务异常，请联系管理员查看服务器日志' : '网络请求失败，请稍后重试');
            if (data && typeof data.msg === 'string') message = data.msg;
            if (xhr.status) message += ' (' + xhr.status + ')';
            securityNotice(message);
        }
    });
    return false;
}

function getApiPwd () {
    $('#copy-apiss').val(creatCode(12))
}

// 1126 生成随机密钥
function creatCode (length) {
    let crackRePwd = '' // 存放验证码
    const codeLength = parseInt(length) // 设置验证码长度为6
    const codeChars = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '`', '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '-', '+', '=']
    for (let i = 0; i < codeLength; i++) {
        const charIndex = Math.floor(Math.random() * 74)
        crackRePwd += codeChars[charIndex]
    }

    const codeReg = /^[A-Za-z0-9_-~`!@#$%^&*()=+]+$/
    var re = new RegExp(codeReg)

    if (re.test(crackRePwd)) {
        return crackRePwd
    } else {
        creatCode(12)
    }
}

function updateEmail () {

    localStorage.setItem('security_opera_layer', 'email')
    location.reload();
}

function updatePhone (type) {

    localStorage.setItem('security_opera_layer', 'phone')
    location.reload();
}

function showPassword (className) {
    if (is_password == 1) {
        $('.old_password').togglePassword({
            el: '.old_password_btn'
        });
    }

    $('.re_password').togglePassword({
        el: '.re_password_btn'
    });
    $('.password').togglePassword({
        el: '.password_btn'
    });
}

function cpBtn () {
    var strType = $('#copy-apiss').attr("type")
    $('#copy-apiss').attr('type', 'text')
    $('#copy-apiss').select()
    document.execCommand("Copy")
    toastr.success('复制成功')
    $('#copy-apiss').attr('type', strType);
}



// 交互授权
function showInterflowlicenseHandleClick () {
    isClick = false
    $.ajax({
        type: 'GET',
        url: '/interflow/accountbind',
        contentType: 'application/json;charset=UTF-8',
        dataType: 'json',
        success: function (data) {
            let el
            $('#accountbind-form').html(oldEl)
            if (data.status == '200') {
                $("#interflowModal input[name='qq']").val(data.data.qq);
                $('#interflowModal').modal('show');
            } else {
                toastr.error(data.msg);
            }
            isCheckOpen()
            checkData()
        }
    });

}
function isCheckOpen () {
    
    $('.down-group').hide()
    if ($("input[name$='advanced']").is(':checked')) {
        $('.down-group').show()
    }
   
    $(".form-advanced").on('click', function () {
        if ($("input[name$='advanced']").is(':checked')) {

            $('.down-group').show()
        } else {

            $('.down-group').hide()
        }
    })
}
function checkData (e) {

    var checkEl = $("#accountbind-form input[name$='i_account']")
    checkEl.on('blur', function (e) {
        if (e.target.value === '') {
            e.target.classList.remove("is-valid");//清除合法状态
            e.target.classList.add("is-invalid");//添加非法状态
        } else {
            e.target.classList.remove("is-invalid");
            e.target.classList.add("is-valid");
        }
    })


}




