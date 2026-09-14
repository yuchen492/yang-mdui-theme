
{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg" url="/clientarea"}
{/if}

<script src="/themes/clientarea/default/assets/js/public.js?v={$Ver}"></script>
<style>
	.input-group-prepend { 
		width: 100px;  
	}
	.auth-full-bg .bg-overlay {
		background: url(/themes/clientarea/default/assets_custom/img/new-background.jpg)no-repeat left top / 100% 1400px;
		background-size: cover;
		opacity:1;
	}
  .form-control,.input-group-append{
    height: 46px;
  }
</style>
<script>
    var mk = '{$Setting.msfntk}';

</script>


<div class="mdui-card">
    <div class="mdui-card-content">
    
    
        <div class="mdui-tab mdui-tab-centered" mdui-tab>
            {if $Pwreset.allow_login_phone}
            <a href="#phone" class="mdui-ripple{if $Get.action=="phone" || !$Get.action} mdui-tab-active{/if}">手机找回</a>
            {/if}
            {if $Pwreset.allow_login_email}
            <a href="#email" class="mdui-ripple{if $Pwreset.allow_login_email && !$Pwreset.allow_login_phone} mdui-tab-active{/if}">邮箱找回</a>
            {/if}
        </div>
        
        {if $Pwreset.allow_login_email}
		<div id="email" class="tab-pane {if $Pwreset.allow_login_email && !$Pwreset.allow_login_phone}active{/if}" role="tabpanel">
			<form method="post"  action="/pwreset?action=email">
			    <div class="mdui-textfield">
                    <label class="mdui-textfield-label">电子邮箱地址</label>
                    <input class="mdui-textfield-input" type="text" id="emailInp" name="email"
    					placeholder="请输入电子邮箱地址" value="{$Post.email}" required/>
                </div>
                
				
				{if $Verify.allow_email_forgetpwd_captcha==1}
				{include file="includes/verify"  type="allow_email_forgetpwd_captcha" positon="top"}
				{/if}
				
				<div class="mdui-row allow_login_code_captcha">
    		        <div class="mdui-col-xs-8">
    					<div class="mdui-textfield">
                            <label class="mdui-textfield-label">邮箱验证码</label>
                            <input class="mdui-textfield-input" type="text" id="code" name="code"
    						placeholder="一封包含验证码的验证邮件将发送到您的电子邮箱地址" value="{$Post.code}" required/>
                        </div>
                    </div>
                    <div class="mdui-col-xs-4 mdui-valign" style="height:92px;">
    					<button class="mdui-btn mdui-btn-raised mdui-color-theme mdui-btn-block" type="button"  onclick="getCode(this,'reset_email_send','allow_email_forgetpwd_captcha')">获取验证码</button>
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
                
                <a href="/login">返回登录</a><a class="mdui-float-right" href="/register">注册账户</a>
			    <button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme" type="submit">重置密码</button>
				
			</form>
		</div>
		{/if}
        
        
        {if $Pwreset.allow_login_phone}
		<div id="phone" class="tab-pane active" role="tabpanel">
			<form method="post"  action="/pwreset?action=phone">
			
			
    			{if $Register.allow_login_register_sms_global==1}
        		    <div class="mdui-row">
        		        <div class="mdui-col-xs-4">
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
				
				
				
				{if $Verify.allow_phone_forgetpwd_captcha==1}
				{include file="includes/verify"  type="allow_phone_forgetpwd_captcha" positon="top"}
				{/if}
				
				
				<div class="mdui-row allow_login_code_captcha">
    		        <div class="mdui-col-xs-8">
    					<div class="mdui-textfield">
                            <label class="mdui-textfield-label">手机验证码</label>
                            <input class="mdui-textfield-input" type="text" id="code" name="code"
    						placeholder="一封包含验证码的短信将发送到您的手机" value="{$Post.code}" required/>
                        </div>
                    </div>
                    <div class="mdui-col-xs-4">
    					<button class="mdui-btn mdui-btn-raised mdui-color-theme mdui-btn-block" type="button"  onclick="getCode(this,'reset_phone_send','allow_phone_forgetpwd_captcha')">获取验证码</button>
                    </div>
                </div>
				
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
				
                <a href="/login">返回登录</a><a class="mdui-float-right" href="/register">注册账户</a>
				<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme" type="submit">重置密码</button>

			</form>
		</div>
		{/if}
        
        
    </div>
</div>


