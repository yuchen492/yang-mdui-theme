<!-- 氧MDUI产品内页功能一览 -->

<div class="mdui-card mdui-m-y-1 mdui-hoverable">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">
            实例操作功能
        </div>
    </div>
    <div class="mdui-card-content">
        当前实例的特殊操作会列出在下方。
    </div>
    <div class="mdui-card-actions">
        {php}$hooks=hook('template_after_servicedetail_suspended',['hostid'=>$Detail['host_data']['id']]);{/php}
        {if $hooks}
          {foreach $hooks as $item}
            <div class="btn-group ml-0 mr-2">
              <span>
              {$item}
              </span>
            </div>
          {/foreach}
        {/if}
        {foreach $Detail.module_button.control as $item}

            <a class="mdui-btn mdui-btn-raised mdui-btn-dense" href="javascript:void(0);"
              onclick="yang_service_module_button($(this), '{$Think.get.id}', '{$Detail.host_data.type}')"
              data-func="{$item.func}" data-type="{$item.type}"
              data-desc="{$item.desc ?: $item.name}">{$item.name} <i class="mdui-icon material-icons">keyboard_arrow_right</i></a>
        {/foreach}
        {if ($Detail.module_button.console|count) == 1}
          {foreach $Detail.module_button.console as $item}
          <a class="mdui-btn mdui-btn-raised mdui-btn-dense" href="javascript:void(0);"
            onclick="yang_service_module_button($(this), '{$Think.get.id}', '{$Detail.host_data.type}')"
            data-func="{$item.func}" data-type="{$item.type}" data-desc="">{$item.name} <i class="mdui-icon material-icons">keyboard_arrow_right</i></a>
          {/foreach}
          {else}
            {foreach $Detail.module_button.console as $item}
            <a class="mdui-btn mdui-btn-raised mdui-btn-dense" href="javascript:void(0);"
              onclick="yang_service_module_button($(this), '{$Think.get.id}', '{$Detail.host_data.type}')"
              data-func="{$item.func}" data-type="{$item.type}" data-desc="">{$item.name} <i class="mdui-icon material-icons">keyboard_arrow_right</i></a>
            {/foreach}
        {/if}
    </div>
</div>