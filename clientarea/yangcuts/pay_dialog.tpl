<!-- 氧MDUI支付对话框 -->
<!-- 为了适配智简魔方脚本而写 -->

<div class="mdui-dialog" id="yangPayDialog">
    <div class="mdui-dialog-title">在线支付</div>
    <div class="mdui-dialog-content" id="yangPayDialogContent">操作说明</div>
    <div class="mdui-dialog-actions">
        <button id="yangPayDialogConfirmbtn" class="mdui-btn mdui-ripple" mdui-dialog-close>关闭窗口</button>
    </div>
</div>

<script>
var payDialog = new mdui.Dialog('#yangPayDialog');
$('#yangPayDialog').on('close.mdui.dialog',
        function(){location.reload();}
    );
function yangPayamount(invoiceid, use_credit_limit) {
    mdui.snackbar({message: '正在加载订单信息，请稍后……'})
    var url = _url + '/pay?action=billing';
    $.ajax({
        type: "POST",
        data: {
            invoiceid: invoiceid,
            use_credit_limit: use_credit_limit
        },
        url: url,
        success: function(data) {
            $('#yangPayDialogContent').html(data);
            payDialog.open();
        }
    })
}
</script>