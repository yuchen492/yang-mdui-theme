<!-- 氧MDUI产品内页自动续费 -->
<!-- 我判断都是抄的魔方官方！ -->

{if $Detail.host_data.billingcycle != 'onetime' && $Detail.host_data.status == 'Paid' && $Detail.host_data.billingcycle != 'free'}
<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">
            自动续费
            <label class="mdui-switch" for="automaticRenewal">
                <input type="checkbox" id="automaticRenewal"
                      onchange="yangAutomaticRenewal('{$Think.get.id}')"{if $Detail.host_data.billingcycle_desc == '一次性' || $Detail.host_data.billingcycle_desc == '免费'} disabled{/if}{if $Detail.host_data.initiative_renew
                      !=0} checked{/if}/>
                <i class="mdui-switch-icon"></i>
            </label>
        </div>
    </div>
    <div class="mdui-card-content">
        <p>不要因为忘记续费而丢失您的宝贵实例数据（尽管我们会帮您备份）！启用自动续费，会在此实例命中下一个付款周期末期时，自动使用账户余额续费。</p>
        <p>要使自动续费有效，需要在续费时账户余额多于{$Detail.host_data.amount_desc}，否则可能导致续费失败。</p>
        <p>建议您提前充值避免续费失败。</p>
    </div>
</div>

<script>
function yangAutomaticRenewal(id) {
    var weburl = setting_web_url + '/host/autorenew'
    var hostid = id;
    var initiative_renew = $('#automaticRenewal').prop("checked") ? 1 : 0
    var obj = {
        hostid,
        initiative_renew
    }
    $.ajax({
        type: "POST",
        url: weburl,
        data: obj,
        success: function(data) {
            if (data.status !== 200) {
                mdui.snackbar({message: '设置自动续费时失败。请稍后重试。'});
                return
            }
                mdui.snackbar({message: '设置自动续费成功：' + data.msg});
        }
    });
}
</script>
{/if}