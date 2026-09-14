function addfundsBtn (_this) {
    $(_this).find('.addfunds-payment').addClass('active');
    $(_this).find('input[name="payment"]').prop('checked', true);
    $(_this).siblings('div').find('.addfunds-payment').removeClass('active').find('input[name="payment"]').prop('checked', false);
}

function restorePayBtn(originalText) {
    var btnText = originalText || '充值';
    $('.pay-now-btn').html(btnText).prop('disabled', false);
}

function formSubmitBtn () {
    var originalText = $('.pay-now-btn').text().trim() || '充值';
    $('.pay-now-btn').html('<i class="mdui-icon material-icons" style="font-size:16px;vertical-align:middle;animation:spin 1s linear infinite;">refresh</i> 处理中...').prop('disabled', true);

    var amount = $('input[name=amount]').val();
    var payment = $('input[name=payment]:checked').val();

    if (!amount || isNaN(amount) || Number(amount) <= 0) {
        if (typeof mdui !== 'undefined' && mdui.snackbar) {
            mdui.snackbar({ message: '请输入有效的充值金额' });
        } else {
            alert('请输入有效的充值金额');
        }
        restorePayBtn(originalText);
        return false;
    }

    if (!payment) {
        if (typeof mdui !== 'undefined' && mdui.snackbar) {
            mdui.snackbar({ message: '请选择支付方式' });
        } else {
            alert('请选择支付方式');
        }
        restorePayBtn(originalText);
        return false;
    }

    var requestUrl = (typeof _url !== 'undefined' ? _url : '') + '/pay?action=recharge';

    $.ajax({
        url: requestUrl,
        data: { beforeCheck: 1, amount: amount, payment: payment },
        type: 'post',
        timeout: 15000,
        success: function (e) {
            restorePayBtn(originalText);

            if (e && (e.status == 400 || e.status == 406)) {
                var errMsg = e.msg || '充值请求失败，请稍后重试';
                if (typeof mdui !== 'undefined' && mdui.snackbar) {
                    mdui.snackbar({ message: errMsg });
                }
                var _html = '<div class="alert alert-danger alert-dismissible fade show beforecheck" role="alert">\n' +
                    '\t<i class="mdi mdi-block-helper mr-2"></i>\n' +
                    '\t<span class="msg-box">' + errMsg + '</span>\n' +
                    '</div>';
                $('.beforecheck-box').html(_html);
                if (typeof $ !== 'undefined' && $('#myModal').modal) {
                    $('#myModal').modal('hide');
                }
                return false;
            }

            if (typeof e === 'object' && e.status && e.status !== 200) {
                var msg = e.msg || '充值请求异常';
                if (typeof mdui !== 'undefined' && mdui.snackbar) {
                    mdui.snackbar({ message: msg });
                }
                return false;
            }

            // 优先使用 MDUI 自带对话框弹窗
            if (typeof mdui !== 'undefined' && $('#yangPayDialog').length) {
                var payContent = (typeof e === 'object') ? JSON.stringify(e) : e;
                $('#yangPayDialogContent').html(payContent);
                var payDialog = new mdui.Dialog('#yangPayDialog');
                payDialog.open();
                return;
            }

            // 兼容 Bootstrap Modal
            if ($('#myModal').length && typeof $('#myModal').modal === 'function') {
                $("#pay .modal-body").html(e);
                $('#myModal').modal('show');
            } else if ($('#pay .modal-body').length) {
                $("#pay .modal-body").html(e);
                $('#pay').show();
            } else {
                $('body').append('<div id="payBackupDialog" style="position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);z-index:9999;background:#fff;padding:20px;box-shadow:0 0 10px rgba(0,0,0,0.5);border-radius:8px;max-width:90%;max-height:90%;overflow:auto;"><div style="text-align:right;"><button onclick="$(\'#payBackupDialog\').remove()">关闭</button></div><div>' + e + '</div></div>');
            }
        },
        error: function (xhr, status, error) {
            restorePayBtn(originalText);
            var tip = '网络连接或支付网关异常，请稍后重试';
            if (status === 'timeout') {
                tip = '充值请求超时，请检查网络或刷新重试';
            }
            if (typeof mdui !== 'undefined' && mdui.snackbar) {
                mdui.snackbar({ message: tip });
            } else {
                alert(tip);
            }
        }
    });
}

function checkOrder (invoiceid) {
    $.ajax({
        url: 'check_order',
        type: 'POST',
        data: { id: invoiceid },
        dataType: 'json',
        success: function (result) {
            if (result.status == '200') {
                if (typeof layer !== 'undefined' && layer.closeAll) {
                    layer.closeAll();
                }
                location.reload();
            }
        }
    });
}

function addfundsMaxMin () {
    if (typeof min !== 'undefined' && min !== '' && Number($('#addfundsInp').val()) < Number(min)) {
        $('#addfundsInp').val(min);
    }
    if (typeof max !== 'undefined' && max !== '' && Number($('#addfundsInp').val()) > Number(max)) {
        $('#addfundsInp').val(max);
    }
}
