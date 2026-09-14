<!-- 氧MDUI产品内页升降级 -->
<!-- 别问为什么是profile1，问就是这个模块保留了早期版本财务系统的传统 -->

{if $Detail.config_options}
<div class="mdui-row" id="profile1">
    <div class="mdui-col-xs-12">
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    配置参数
                </div>
            </div>
            <div class="mdui-card-content">
                <p>您可以在本页查看当前实例的配置细节。</p>
                <p>一些参数支持实例创建后变更，以满足您的弹性业务需求。</p>
            </div>
        </div>
        
        {if $Detail.host_data.allow_upgrade_product}
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    实例类型变更
                </div>
            </div>
            <div class="mdui-card-content">
                <p>通过操作实例类型变更（产品升降级），可以保留数据在不同实例之间变更配置选项，例如套餐服务器变更配置。</p>
            </div>
            <div class="mdui-card-actions">
                {if $Detail.host_data.allow_upgrade_product}
                <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme"
                    id="upgradeProductBtn"
                    onclick="upgradeProduct($(this), '{$Think.get.id}')">选择新实例</button>
                {else}
                <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme" disabled>当前实例不支持此操作</button>
                {/if}
            </div>
        </div>
        {/if}
        
        {if $Detail.host_data.allow_upgrade_config}
        <div class="mdui-card mdui-m-y-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    实例可配置项变更
                </div>
            </div>
            <div class="mdui-card-content">
                <p>通过操作实例可配置项变更，可以保留数据更改当前实例的可配置选项参数。您只需支付剩余付款周期的标准报价。</p>
            </div>
            <div class="mdui-card-actions">
                {if $Detail.host_data.allow_upgrade_config}
                <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme"
                    id="upgradeConfigBtn"
                    onclick="upgradeConfig($(this), '{$Think.get.id}')">展开可配置项</button>
                {else}
                <button type="button" class="mdui-btn mdui-btn-raised mdui-color-theme" disabled>当前实例不支持此操作</button>
                {/if}
            </div>
        </div>
        {/if}
        
        {if $Detail.config_options || $Detail.custom_field_data}
        <div class="mdui-table-fluid">
            <table class="mdui-table">
                <thead>
                  <tr>
                    <th>参数名称</th>
                    <th>参数类型</th>
                    <th>键值</th>
                  </tr>
                </thead>
                <tbody>
                {foreach $Detail.config_options as $item}
                    <tr>
                        <td>{$item.name}</td>
                        <td>实例配置参数</td>
                        <td>{$item.sub_name}</td>
                    </tr>
                {/foreach}
                {foreach $Detail.custom_field_data as $item}
                {if $item.showdetail == 1}
                    <tr>
                        <td>{$item.fieldname}</td>
                        <td>用户自定义参数</td>
                        <td>{$item.value}</td>
                    </tr>
                {/if}
                {/foreach}
                </tbody>
            </table>
        </div>
        {/if}
        
        
    </div>
</div>
{/if}