<!-- 氧MDUI产品内页登录信息对话框 -->
<!-- 智简魔方一直在更新js，为了使用mdui对话框，只能自己写一个ajax -->

<div class="mdui-dialog" id="yangLogininfoDialog">
    <div class="mdui-dialog-title">实例登录信息（默认账户密码）</div>
    <div class="mdui-dialog-content">
        {if $Detail.host_data.os}<p><strong>系统镜像：</strong>{$Detail.host_data.os}</p>{/if}
        {if $Detail.host_data.dedicatedip}<p><strong>默认登录地址：</strong>{$Detail.host_data.dedicatedip}{if $Detail.host_data.port}:{$Detail.host_data.port}{/if}</p>{/if}
        {if $Detail.host_data.dedicatedip}<p>默认登录地址是实例创建时指定的，它可能由您或其他因素更改。首次登录后可视情况更改默认登录地址（端口），以增强实例安全性。</p>{/if}
        <p><strong>默认用户名：</strong>{$Detail.host_data.username}</p>
        <p>
            <strong>默认密码：</strong>
            <span id="yangLogininfoDialogPasswd">{$Detail.host_data.password}</span>
            <button id="yangLogininfoDialogCopypwd" class="mdui-btn mdui-btn-icon" mdui-tooltip="{content: '复制密码'}"><i class="mdui-icon material-icons">content_copy</i></button>
        </p>
        <p>虚拟主机请直接使用账户密码在 Web 视图中登录。服务器请使用工具，若未列出指定登录端口，Linux 默认使用 22 端口的 SSH 协议，Windows 默认使用 3389 端口的 RDP 远程桌面协议。</p>
        <p>如果您修改了密码而忘记，您可以使用重置密码功能。</p>
    </div>
    <div class="mdui-dialog-actions">
        <button class="mdui-btn mdui-ripple" mdui-dialog-confirm>确定</button>
    </div>
</div>

<script>
yangClipboardpoppwd = new ClipboardJS('#yangLogininfoDialogCopypwd', {
  text: function (trigger) {
    return $('#yangLogininfoDialogPasswd').text()
  },
  container: document.getElementById('yangLogininfoDialog')
});
yangClipboardpoppwd.on('success', function (e) {
  mdui.snackbar({
      message: '您已成功复制密码，请妥善保管，不要外泄！'
    });
})
</script>