
{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}
{if $SuccessMsg} 
{include file="error/notifications" value="$SuccessMsg"}
{/if}
<script src="/themes/clientarea/default/assets/js/crypto-js.min.js" type="text/javascript"></script>
<script src="/themes/clientarea/default/assets/js/public.js?v={$Ver}"></script>

<style>
		.logo.text-center img{height:50px;}
    .input-group-prepend {
        width: 100px;
    }
	.auth-full-bg .bg-overlay {
		background: url(/themes/clientarea/default/assets_custom/img/new-background.jpg)no-repeat left top / 100% 1400px;
		background-size: cover;
		opacity:1;
	}
  .form-control,.btn-primary,.input-group-append{
    height: 46px;
  }
  .btn-primary{
    line-height: 28px;
  }
</style>
<script>
    var mk = '{$Setting.msfntk}';
</script>

<div class="mdui-card">
    <div class="mdui-card-content">
    
    
    <div class="mdui-tab mdui-tab-centered" mdui-tab>
        {if $Register.allow_register_phone}
        <a href="#phone" class="mdui-ripple{if $Get.action=="phone" || !$Get.action} mdui-tab-active{/if}">手机注册</a>
        {/if}
        {if $Register.allow_register_email}
        <a href="#email" class="mdui-ripple{if ($Register.allow_register_email && !$Register.allow_register_phone) || $Get.action=="email"} mdui-tab-active{/if}">邮箱注册</a>
        {/if}
    </div>
    
    
    {if $Register.allow_register_email}
	<div id="email" class="tab-pane {if ($Register.allow_register_email && !$Register.allow_register_phone) || $Get.action=="email"}active{/if}" role="tabpanel">
		<form class="needs-validation" novalidate method="post" action="/register?action=email" onsubmit="encryptPass('phonePwd');encryptPass('phonePwdCheck');" >
		
		    <div class="mdui-textfield">
                <label class="mdui-textfield-label">电子邮箱地址</label>
                <input class="mdui-textfield-input" type="text" id="emailInp" name="email"
					placeholder="请输入电子邮箱地址" value="{$Post.email}" required/>
            </div>

			
			
			{if $Verify.allow_register_email_captcha==1}
			{include file="includes/verify"  type="allow_register_email_captcha" positon="top"}
			{/if}
			
			{if $Register.allow_email_register_code==1}
			
			<div class="mdui-row allow_login_code_captcha">
		        <div class="mdui-col-xs-8">
					<div class="mdui-textfield">
                        <label class="mdui-textfield-label">邮箱验证码</label>
                        <input class="mdui-textfield-input" type="text" id="code" name="code"
						placeholder="一封包含验证码的验证邮件将发送到您的电子邮箱地址" value="{$Post.code}" required/>
                    </div>
                </div>
                <div class="mdui-col-xs-4 mdui-valign" style="height:92px;">
					<button class="mdui-btn mdui-btn-raised mdui-color-theme mdui-btn-block" type="button"  onclick="getCode(this,'register_email_send','allow_register_email_captcha')">获取验证码</button>
                </div>
            </div>
                        
			{/if}
			
			<div class="mdui-textfield">
                <label class="mdui-textfield-label">账户密码</label>
                <input class="mdui-textfield-input" type="password" name="password"
					id="phonePwd" placeholder="请设置账户密码" required/>
            </div>
            
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">确认账户密码</label>
                <input class="mdui-textfield-input" type="password" name="checkPassword"
					id="phonePwdCheck" placeholder="请再次输入账户密码" required/>
            </div>
			


			{foreach $Register.login_register_custom_require as $custom}
			<div class="form-group">
				<label for="{$custom.name}">{$Register[login_register_custom_require_list][$custom.name]}</label>
				<input type="{if $custom.name=='password'}password{else}text{/if}" class="form-control" name="{$custom.name}" id="{$custom.name}" value="{$Post[$custom.name]}" >
			</div>
			{/foreach}

			{foreach $Register.fields as $k => $list}
				<div class="form-group">
					<label for="{$list.id}">{$list.fieldname}</label>
					{if $list.fieldtype == 'dropdown'}
						<!-- 下拉 -->
						<select name="fields[{$list.id}]" class="form-control ">
							{foreach $list.dropdown_option as $key => $val}
								<option value="{$key}" {if(isset($_fields[$key]))} selected {/if}>{$val}</option>
							{/foreach}
						</select>
					{elseif $list.fieldtype == 'password'}
						<!-- 密码 -->
						<input name="fields[{$list.id}]" type="password" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if}class="form-control" placeholder="{$Lang.custom_password_box}" />
					{elseif $list.fieldtype == 'text' || $list.fieldtype == 'link'}
						<!-- 文本框、链接 -->
						<input name="fields[{$list.id}]" type="text" class="form-control" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if} placeholder="{$list.fieldname}" />
					{elseif $list.fieldtype == 'tickbox'}
						<!-- 选项框 -->
						<input type="checkbox" name="fields[{$list.id}]" {if(isset($_fields[$list['id']]))} checked {/if}>{$list.fieldname}
					{elseif $list.fieldtype == 'textarea'}
						<!-- 文本域 -->
						<textarea name="fields[{$list.id}]" cols="30" rows="10" class="form-control">{if(isset($_fields[$list['id']]))} {$_fields[$list['id']]} {/if}</textarea>
					{/if}
				</div>
			{/foreach}
			<!--销售-->
			{if $setsaler == '2'}
			<div class="form-group">
				<label for="checkPassword">{$Lang.sales_representative}</label>
				<select name="sale_id" class="form-control">
					<option value="0">{$Lang.nothing}</option>
					{foreach $saler as $list}
					<option {if $list.id==$Post.id}selected{/if} value="{$list.id}">{$list.user_nickname}</option>
					{/foreach}
				</select>
			</div>
			{/if}
			<a href="/login">返回登录</a><a class="mdui-float-right" href="/pwreset">重置密码</a>
			<div>                                       
				<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme" type="submit" onclick="if(!beforeSubmit(this)){ return false;}">立即注册</button>
			</div>

		</form>
	</div>
	{/if}
	{if $Register.allow_register_phone}
	<div id="phone" class="tab-pane {if $Get.action=="phone" || !$Get.action}active{/if}" role="tabpanel">
		<form class="needs-validation" novalidate method="post" action="/register?action=phone" onsubmit="encryptPass('emailPwd');encryptPass('emailPwdCheck');">
		
		{if $Register.allow_login_register_sms_global==1}
		    <div class="mdui-row">
		        <div class="mdui-col-xs-4 mdui-valign" style="height:92px;">
		            <select class="mdui-select select2"	name="phone_code" value="{$Post.phone_code}" id="phoneCodeSel" mdui-select>
						{foreach $SmsCountry as $list}
						<option value="{$list.phone_code}" {if $list.phone_code=="+86"}selected {/if}>
							{$list.link}
						</option>
						{/foreach}
					</select>
		        </div>
		        <div class="mdui-col-xs-8">
		            <div class="mdui-textfield">
                        <label class="mdui-textfield-label">手机号码</label>
                        <input class="mdui-textfield-input" type="text" id="phoneInp" name="phone"  value="{$Post.phone}"  placeholder="请输入手机号码并选择区号"/>
                    </div>
		        </div>
		    </div>
	   {else}
				    
		    <div class="mdui-textfield">
                <label class="mdui-textfield-label">手机号码</label>
                <input class="mdui-textfield-input" type="text" id="phoneInp" name="phone"  value="{$Post.phone}"  placeholder="请输入手机号码"/>
            </div>
		{/if}
		    
		    
			{if $Verify.allow_register_phone_captcha==1}
			{include file="includes/verify"  type="allow_register_phone_captcha" positon="top"}
			{/if}
			
			
			<div class="mdui-row allow_login_code_captcha">
		        <div class="mdui-col-xs-8">
					<div class="mdui-textfield">
                        <label class="mdui-textfield-label">手机验证码</label>
                        <input class="mdui-textfield-input" type="text" id="code" name="code"
						placeholder="一封包含验证码的短信将发送到您的手机" value="{$Post.code}" required/>
                    </div>
                </div>
                <div class="mdui-col-xs-4 mdui-valign" style="height:92px;">
					<button class="mdui-btn mdui-btn-raised mdui-color-theme mdui-btn-block" type="button"  onclick="getCode(this,'register_phone_send','allow_register_phone_captcha')">获取验证码</button>
                </div>
            </div>

			<div class="mdui-textfield">
                <label class="mdui-textfield-label">账户密码</label>
                <input class="mdui-textfield-input" type="password" name="password"
					id="emailPwd" placeholder="请设置账户密码" required/>
            </div>
            
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">确认账户密码</label>
                <input class="mdui-textfield-input" type="password" name="checkPassword"
					id="emailPwdCheck" placeholder="请再次输入账户密码" required/>
            </div>

			{foreach $Register.login_register_custom_require as $custom}
			<div class="form-group">
				<label for="{$custom.name}">{$Register[login_register_custom_require_list][$custom.name]}</label>
				<input type="{if $custom.name=='password'}password{else}text{/if}" class="form-control" name="{$custom.name}" id="{$custom.name}"  value="{$Post[$custom.name]}" >
			</div>
			{/foreach}

			{foreach $Register.fields as $k => $list}
			<div class="form-group">
				<label for="{$list.id}">{$list.fieldname}</label>															
				{if $list.fieldtype == 'dropdown'}
					<!-- 下拉 -->
					<select name="fields[{$list.id}]" class="form-control ">
						{foreach $list.dropdown_option as $key => $val}
							<option value="{$key}" {if(isset($_fields[$key]))} selected {/if}>{$val}</option>
						{/foreach}
					</select>
				{elseif $list.fieldtype == 'password'}
				<!-- 密码 -->
					<input name="fields[{$list.id}]" type="password" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if}class="form-control" placeholder="{$Lang.custom_password_box}" />
				{elseif $list.fieldtype == 'text' || $list.fieldtype == 'link'}
					<!-- 文本框、链接 -->
					<input name="fields[{$list.id}]" type="text" class="form-control" {if(isset($_fields[$list['id']]))} value="{$_fields[$list['id']]}" {/if} placeholder="{$list.fieldname}" />
				{elseif $list.fieldtype == 'tickbox'}
					<!-- 选项框 -->
					<input type="checkbox" name="fields[{$list.id}]" {if(isset($_fields[$list['id']]))} checked {/if}>{$list.fieldname}
				{elseif $list.fieldtype == 'textarea'}
					<!-- 文本域 -->
					<textarea name="fields[{$list.id}]" cols="30" rows="10" class="form-control">{if(isset($_fields[$list['id']]))} {$_fields[$list['id']]} {/if}</textarea>
				{/if}												
			</div>														
			{/foreach}
			<!--销售-->
			{if $setsaler == '2'}
			<div class="form-group">
				<label for="checkPassword">{$Lang.sales_representative}</label>
				<select name="sale_id" class="form-control">
					<option value="0">{$Lang.nothing}</option>
					{foreach $saler as $list}
					<option value="{$list.id}" {if($Post.sale_id==$list.id)}selected{/if}>{$list.user_nickname}</option>
					{/foreach}
				</select>
			</div>
			{/if}
			
			<a href="/login">返回登录</a><a class="mdui-float-right" href="/pwreset">重置密码</a>
            <div>
				<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme" type="submit" onclick="if(!beforeSubmit(this)) {return false;}">立即注册</button>
			</div>


		</form>

	</div>
	{/if}
	
	<div class="mdui-center">
	<label class="mdui-checkbox">
        <input type="checkbox" id="agreePrivacy"/>
        <i class="mdui-checkbox-icon"></i>
        我已详细阅读并同意<a href="{$Setting.web_tos_url}" target="_blank">服务条款</a>和<a href="{$Setting.web_privacy_url}" target="_blank">隐私政策</a>。
    </label>
    </div>
    
    
    </div>
</div>

<!-- end container-fluid -->
<script src="/themes/clientarea/default/assets/js/public.js"></script>
<script>
	function beforeSubmit(_this)
	{
		var is_checked = $('#agreePrivacy:checked')
		if(is_checked.length == 0)
		{
			toastr.error('{$Lang.check_privacy}');
			return false;
		}
		$(_this).parents('form').submit();
	}
</script>
