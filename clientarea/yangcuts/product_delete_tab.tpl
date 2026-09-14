<!-- 氧MDUI产品内页释放实例 -->

<div class="mdui-row" id="delete-tab">
    <div class="mdui-col-xs-12">
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    释放实例
                </div>
            </div>
            <div class="mdui-card-content">
                <p>立即释放实例并解除关联相关资源。此操作不可逆且不会自动退款，请谨慎操作。</p>
                {if $Cancel.host_cancel}<p>此实例已安排释放任务，时间节点为：{$Lang.stop_when_due}。您可在释放任务执行前取消释放。</p>{/if}
            </div>
            <div class="mdui-card-actions">
                  {if $Cancel.host_cancel}
                  <button class="mdui-btn mdui-btn-raised mdui-color-red" id="cancelStopBtn"
                    onclick="cancelStop('{$Cancel.host_cancel.type}', '{$Think.get.id}')">取消释放实例</button>
                  {else}
                  <button class="mdui-btn mdui-btn-raised mdui-color-red" data-toggle="modal"
                    data-target=".cancelrequire">释放实例</button>
                  {/if}
            </div>
        </div>
    </div>
    
</div>