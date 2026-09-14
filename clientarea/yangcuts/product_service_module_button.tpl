<!-- 氧MDUI模块通用功能脚本 -->
<!-- 为了适配智简魔方脚本而写 -->

<div class="mdui-dialog" id="yangServiceModuleDialog">
    <div class="mdui-dialog-title">确认进行操作</div>
    <div class="mdui-dialog-content" id="yangServiceModuleDialogContent">操作说明</div>
    <div class="mdui-dialog-actions">
        <button class="mdui-btn mdui-ripple" mdui-dialog-close>取消</button>
        <button id="yangServiceModuleDialogConfirmbtn" class="mdui-btn mdui-ripple" mdui-dialog-confirm>确定</button>
    </div>
</div>

<div class="mdui-dialog" id="yangServiceModuleDialogCrackpass">
        <div class="mdui-dialog-title">重置实例密码</div>
        <div class="mdui-dialog-content">
            <p>您即将重置实例密码。</p>
            <p>该功能可帮助您在修改密码后忘记导致的无法登录场景下，重置您的实例密码。</p>
            <p>重置密码由虚拟机节点发起，重置过程中，您的实例可能重启多次。</p>
            <p>如果可能，请尽量使用其他途径保存您的工作，然后再进行重置。</p>
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">新密码</label>
                <input id="yangCrackpassInput" class="mdui-textfield-input" type="text" placeholder="新密码" value="{$Detail.host_data.password}"/>
            </div>
            <button class="mdui-btn" onclick="$('#yangCrackpassInput').val(createRandPassword(Number(passwordRules.len_num), Number(passwordRules.num), Number(passwordRules.upper), Number(passwordRules.lower), Number(passwordRules.special)));"><i class="mdui-icon material-icons">refresh</i> 随机生成密码</button>
            <p>当您点击确认后，您的重置密码请求将交给智简魔方财务系统完成。可能需要数分钟的时间，请稍后刷新查看。</p>
        </div>
        <div class="mdui-dialog-actions">
            <button class="mdui-btn mdui-ripple" mdui-dialog-close>取消</button>
            <button class="mdui-btn mdui-ripple" onclick="yangModuleResetPass()">确定</button>
        </div>
</div>

<script>
var confirmDialog = new mdui.Dialog('#yangServiceModuleDialog');
var crackpassDialog = new mdui.Dialog('#yangServiceModuleDialogCrackpass');
var dialogConfirmFunc = function(){}
$('#yangServiceModuleDialog').on('confirm.mdui.dialog', function () {mdui.snackbar({message: '请求已提交，请稍后……'});dialogConfirmFunc()});

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
            $('#yangCrackpassInput').val(createRandPassword(Number(passwordRules.len_num), Number(passwordRules.num), Number(passwordRules.upper), Number(passwordRules.lower), Number(passwordRules.special)));
            crackpassDialog.open();
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
                yangGetModalConfirm(desc, postFunc);
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

function yangGetModalConfirm(text, callback) {
    $('#yangServiceModuleDialogContent').html('<p>您即将进行操作：' + text + '</p><p>确认继续吗？</p>')
    dialogConfirmFunc = callback;
    confirmDialog.open();
}

function yangModuleResetPass() {
    $("#force")[0].checked = true;
    $(".getPassword").val($("#yangCrackpassInput").val())
    $("#moduleResetPass > div > div > div.modal-footer > button.submit").click()
    crackpassDialog.close()
}
</script>