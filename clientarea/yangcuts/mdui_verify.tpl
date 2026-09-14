{if $Verify.is_captcha==1}
  {if [positon]=='top'}
    <!--  20241015 新增模板钩子 -->
    {php}$hooks=hook('template_custom_clientarea_captcha_html',['id'=>'[type]']);{/php}
    {if !empty($hooks[0])}
      {foreach $hooks as $item}
        {$item}
      {/foreach}
    {else\}
    <div class="mdui-row [type]">
        <div class="mdui-col-xs-8">
    		<div class="mdui-textfield">
                <label class="mdui-textfield-label">图形验证码</label>
                <input class="mdui-textfield-input" type="text" {if [id]=='[id]'}id="captcha_[type][id]"{else}id="captcha_[type]"{/if} name="captcha" placeholder="请输入图片中的字符"/>
            </div>
        </div>
        <div class="mdui-col-xs-4 mdui-valign" style="height:92px;">
            <div class="mdui-textfield">
    		<img  {if [id]=='[id]'}id="[type][id]"{else}id="[type]"{/if} class="border pointer" style="width:100%;" alt="验证码" onClick="getVerify('[type]')">
    		</div>
        </div>
    </div>

    {/if}

  {else}
  
  
<div class="mdui-row [type]">
    <div class="mdui-col-xs-8">
		<div class="mdui-textfield">
            <label class="mdui-textfield-label">图形验证码</label>
            <input class="mdui-textfield-input" type="text" {if [id]=='[id]'}id="captcha_[type][id]"{else}id="captcha_[type]"{/if} name="captcha" placeholder="请输入图片中的字符"/>
        </div>
    </div>
    <div class="mdui-col-xs-4 mdui-valign">
		<img  {if [id]=='[id]'}id="[type][id]"{else}id="[type]"{/if} class="border pointer" alt="验证码" onClick="getVerify('[type]')">
    </div>
</div>

    
  {/if}

<script type="text/javascript">getVerify('[type]','[id]')</script>

{/if}