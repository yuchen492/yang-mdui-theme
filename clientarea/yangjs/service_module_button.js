/**氧MDUI模块通用功能脚本
为了适配智简魔方脚本而写**/

function yang_service_module_button(_this, id, host_data_type) {
    var func = _this.data('func');
    var type = _this.data('type');
    var desc = _this.data('desc');
    var postData = {
        id: id,
        func: func,
    };
    if (type == 'default') {
        var url = setting_web_url + '/provision/default';
        if (func == 'reinstall') {
            if (host_data_type == 'dcimcloud' || host_data_type == 'dcim') {
                if (!_this.data('submit')) {
                    _this.data('submit', 1);
                    $.ajax({
                        type: "POST",
                        url: setting_web_url + '/dcim/check_reinstall',
                        data: {
                            id: id
                        },
                        success: function(res) {
                            if (res.status == 200) {
                                if (typeof res.max_times != 'undefined' && res.max_times > 0) {
                                    $("#moduleReinstallMsg").html('您本周免费重装次数<span style="color: rgb(47, 84, 234);"> ' + res.max_times + ' </span>次，已重装次数<span style="color: rgb(47, 84, 234);"> ' + res.num + ' </span>次，剩余<span style="color: rgb(47, 84, 234);"> ' + (res.max_times - res.num) + ' </span>次');
                                } else {
                                    $("#moduleReinstallMsg").html('');
                                }
                                $('#moduleReinstall').modal('show');
                            } else if (res.status == 400 && typeof res.price !== 'undefined') {
                                getModalConfirm('您已达到本周最大免费重装次数，￥ ' + res.price + ' 元 / 次，是否需要？', function() {
                                    buyReinstallTimes(id);
                                });
                            } else {
                                toastr.error(res.msg);
                            }
                            _this.removeData('submit')
                        },
                        error: function() {
                            _this.removeData('submit')
                        }
                    })
                }
            } else {
                $('#moduleReinstall').modal('show');
            }
            return;
        } else if (func == 'crack_pass') {
            $('#moduleResetPass input[name="password"]').val(createRandPassword(Number(passwordRules.len_num), Number(passwordRules.num), Number(passwordRules.upper), Number(passwordRules.lower), Number(passwordRules.special)));
            $('#moduleResetPass').modal('show');
            return;
        } else if (host_data_type == 'dcimcloud' && func == 'rescue_system') {
            $('#moduleDcimCloudRescue input[name="temp_pass"]').val(createRandPassword(Number(passwordRules.len_num), Number(passwordRules.num), Number(passwordRules.upper), Number(passwordRules.lower), Number(passwordRules.special)));
            $('#moduleDcimCloudRescue').modal('show');
            return;
        } else {}
        let postFunc = function(type, code) {
            if (code) {
                postData.code = code;
            }
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                success: function(res) {
                    if (res.status == 200) {
                        if (typeof res.data != 'undefined' && typeof res.data.url != 'undefined') {
                            window.open(res.data.url);
                        } else {
                            mdui.snackbar({message: res.msg});
                            refreashPowerStatusCycle(id)
                        }
                    } else {
                        mdui.snackbar({message: '发生错误，请稍后再试：' + res.msg});
                    }
                    $('#secondVerifyModal').modal('hide')
                    $('#confirmModal').modal('hide')
                }
            })
        }
        if (desc) {
            if (isNeedSecond(func)) {
                getSecondModal(func, function(type, code) {
                    postFunc(type, code)
                })
            } else {
                getModalConfirm(desc, postFunc);
            }
        } else {
            if (isNeedSecond(func)) {
                getSecondModal(func, function(type, code) {
                    postFunc(type, code)
                })
            } else {
                postFunc();
            }
        }
    } else {
        var url = setting_web_url + '/provision/custom/' + id;
        $.ajax({
            type: "POST",
            url: url,
            data: postData,
            success: function(res) {
                if (res.status == 200) {
                    if (typeof res.data != 'undefined' && typeof res.data.url != 'undefined') {
                        window.open(res.data.url);
                    } else {
                        mdui.snackbar({message: res.msg});
                        refreashPowerStatusCycle(id)
                    }
                } else {
                    mdui.snackbar({message: '发生错误，请稍后再试：' + res.msg});
                }
            }
        })
    }
}