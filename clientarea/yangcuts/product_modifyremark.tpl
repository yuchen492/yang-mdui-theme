<!-- 氧MDUI产品内页修改备注对话框 -->
<!-- 智简魔方一直在更新js，为了使用mdui对话框，只能自己写一个ajax -->

<div class="mdui-dialog" id="yangModifyRemarkDialog">
    <div class="mdui-dialog-title">修改实例备注</div>
    <div class="mdui-dialog-content">
        <form>
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">实例备注</label>
                <input id="yangRemarkInput" class="mdui-textfield-input" type="text" placeholder="实例备注" value="{$Detail.host_data.remark}"/>
                <div class="mdui-textfield-helper">留空则不显示</div>
            </div>
        </form>
        <p>通过修改实例备注，能帮助您更好地从多个不同实例间辨别它们。备注信息会替换产品卡片的默认标题，这样您就可以在列表中清晰地查阅。</p>
    </div>
    <div class="mdui-dialog-actions">
        <button class="mdui-btn mdui-ripple" mdui-dialog-close>取消</button>
        <button class="mdui-btn mdui-ripple" onclick="yangModifyRemarkSubmit({$Think.get.id})">确定</button>
    </div>
</div>

<script>
function yangModifyRemarkSubmit(serverid) {
    $.ajax({
        type: "POST",
        url: '/host/remark',
        data: {
            id: serverid,
            remark: $('#yangRemarkInput').val()
        },
        dataType: "json",
        success: function(data) {
            mdui.snackbar({message: '备注修改成功！现在会刷新页面更新信息。'});
            location.reload()
        }
    });
}
</script>