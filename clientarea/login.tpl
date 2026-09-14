{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg"}
{/if}
  
 
<script src="/themes/clientarea/default/assets/js/crypto-js.min.js" type="text/javascript"></script>
<script src="/themes/clientarea/default/assets/js/public.js" type="text/javascript"></script>

<style>
		.logo.text-center img{height:50px;}
    .list-inline-item .icon {
        width: 2rem;
        height: 2rem;
    }
    .social-list-item {
        border: none;
    }
    .input-group-prepend {
        width: 100px;
    }
	.allow_login_code_captcha{display:none;}
	.auth-full-bg .bg-overlay {
		background: url(/themes/clientarea/default/assets_custom/img/new-background.jpg)no-repeat left top / 100% 1400px;
		background-size: cover;
		opacity:1;
	}
  .form-control,.input-group-append{
    height: 46px;
  }
</style>
<script type="text/javascript">
    var mk = '{$Setting.msfntk}';
</script>

<div class="mdui-card">
    <div class="mdui-card-content">
        <div class="mdui-row">
            <div class="mdui-col-md-6 mdui-hidden-sm-down mdui-m-y-4">
                <img src="{$Setting.web_logo}" alt="" style="width:80%;text-align:center;"/>
                <p class="mdui-typo-display-2 mdui-center" style="text-align:center;">我们与您携手</p>
                <p class="mdui-typo-headline mdui-center" style="text-align:center;">展望云上美景</p>
                <hr>
                <p style="text-align:center;">欢迎访问{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}！</p>
            </div>
            <div class="mdui-col-sm-12 mdui-col-md-6">
            
                <div class="mdui-tab mdui-tab-centered" mdui-tab>
                    {if $Login.allow_login_phone==1}
                    <a href="#phone" class="mdui-ripple{if $Get.action=="phone" || $Get.action=="phone_code" || !$Get.action} mdui-tab-active{/if}">手机登录</a>
                    {/if}
                    {if $Login.allow_login_email==0 && $Login.allow_id==1}
                    <a href="#email" class="mdui-ripple{if ($Login.allow_login_phone==0 && $Login.allow_id == 1)} mdui-tab-active{/if}">ID登录</a>
                    {/if}
                    {if $Login.allow_login_email}
                    <a href="#email" class="mdui-ripple{if ($Login.allow_login_phone==0 && $Login.allow_login_email == 1  && $Login.allow_id == 0) || $Get.action=="email"} mdui-tab-active{/if}">邮箱登录</a>
                    {/if}
                </div>
                
                
                {if $Login.allow_login_email || $Login.allow_id}
				<div id="email">
					<form method="post" action="/login?action=email" onsubmit="return encryptPass('emailPwdInp');" >			
					    <div class="mdui-textfield">
                            <label class="mdui-textfield-label">{if $Login.allow_login_email}电子邮箱地址{if $Login.allow_id==1}或{/if}{/if}{if $Login.allow_id==1}账户 ID{/if}</label>
                            <input class="mdui-textfield-input" type="text" id="emailInp" name="email" value="{$Post.email}" placeholder="请输入您的{if $Login.allow_login_email}电子邮箱地址{if $Login.allow_id==1}或{/if}{/if}{if $Login.allow_id==1}账户 ID{/if}"/>
                        </div>
                        <div class="mdui-textfield">
                            <label class="mdui-textfield-label">账户密码</label>
                            <input class="mdui-textfield-input" type="password" id="emailPwdInp" name="password" placeholder="请输入账户密码"/>
                        </div>

						
						{if $Login.allow_login_email_captcha==1 && $Login.is_captcha==1}
						{include file="yangcuts/mdui_verify"  type="allow_login_email_captcha" positon="top"}
						{/if}
						
						<a href="/pwreset">忘记密码</a><a class="mdui-float-right" href="/register">注册账户</a>
						
						<div>
							{if $Login.second_verify_action_home_login==1}
							<!--二次登录验证-->
							<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme"
								type="button"  onclick="loginBefore('email');">登录</button>
							{else/}
							<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme"
								type="submit">登录</button>
							{/if}
							
						</div>
					</form>
				</div>
				{/if}
				{if $Login.allow_login_phone}
				<div id="phone">
					<form method="post" action="/login?action=phone" onsubmit="return encryptPass('phonePwdInp');" >
					    {if $Login.allow_login_register_sms_global==1}
					    
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
					    
					    <div class="mdui-textfield allow_login_phone_captcha">
                            <label class="mdui-textfield-label">账户密码</label>
                            <input class="mdui-textfield-input" type="password" id="phonePwdInp" name="password" placeholder="请输入账户密码"/>
                        </div>
						
						{if $Login.allow_login_phone_captcha==1 && $Login.is_captcha==1}
						{include file="yangcuts/mdui_verify"  type="allow_login_phone_captcha" positon="top"}
						{/if}
						{if $Login.allow_login_code_captcha==1 && $Login.is_captcha==1}
						{include file="yangcuts/mdui_verify"  type="allow_login_code_captcha" positon="top"}
						{/if}
                        
                        <div class="mdui-row allow_login_code_captcha">
					        <div class="mdui-col-xs-8">
        						<div class="mdui-textfield">
                                    <label class="mdui-textfield-label">验证码</label>
                                    <input class="mdui-textfield-input" type="text" id="phoneCodeInp" name="code"  value="{$Post.code}" placeholder="请输入验证码"/>
                                </div>
                            </div>
                            <div class="mdui-col-xs-4 mdui-valign">
        						<button class="mdui-btn mdui-btn-raised mdui-color-theme mdui-btn-block" type="button"  onclick="getCode(this,'login_send','allow_login_code_captcha')">获取验证码</button>
                            </div>
                        </div>
                        
                        <div>
                        <!-- 兼容原版脚本的分组 div -->
                        <!-- 没有用但不要删除!!!!!!! -->
					    <a href="javascript:;" onclick="phoneCheck(this,'allow_login_phone_captcha')" class="text-primary mr-0 pointer" {if $Get.action=="phone_code"} style="display:none;" {/if}>
							{$Lang.verification_code_login}
						</a>
    					<a href="javascript:;" onclick="phoneCheck(this,'allow_login_code_captcha')" class="text-primary mr-0 pointer" {if $Get.action!="phone_code"} style="display:none;" {/if}>
    							{$Lang.password_login}
						</a>
						</div>

                        <a href="/pwreset">忘记密码</a><a class="mdui-float-right" href="/register">注册账户</a>
                        <div>
							{if $Login.second_verify_action_home_login==1}
							<!--二次登录验证-->
							<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme allow_login_phone_captcha" type="button"  onclick="loginBefore('phone');">登录</button>
							<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme allow_login_code_captcha" type="submit">登录</button>
							{else/}
  
							<button class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme"
								type="submit">登录</button>
							{/if}
						</div>
							

					</form>
				</div>
				{/if}
            
            
            </div>
        </div>
    </div>
</div>
    
<div class="container-fluid p-0">
    {if $Setting.login_header}
    <div class="text-center">{$Setting.login_header}</div>
    {/if}
    

    {if $Setting.login_footer}
    <div class="text-center">{$Setting.login_footer}</div>
    {/if}
    <!-- end row -->
</div>
<!-- end container-fluid -->

{if $Login.second_verify_action_home_login==1}

<!--氧MDUI二次验证-->
<script>
function yangLoginBefore (loginType) {
  $.get("login/second_verify_page", { "username": $("input[name='" + loginType + "']").val(), "password": $("#" + loginType + " input[name='password']").val(), "captcha": $("#" + loginType + " input[name='captcha']").val() }, function (res) {
    if (res.status == 200) {
      $('#secondVerifyModal').modal('show')
      var option = ''
      $.each(res.data.allow_type, function (i, v) {
        //if(loginType==v.name)
        option += '<option value="' + v.name + '">' + v.name_zh + ':' + v.account + '</option>'
      })
      $("#secondVerifyModal select").html(option)
    } else {
      toastr.error(res.msg)
    }
  }, 'json')
}
</script>


<!--财务原版二次验证 兼容第三方插件-->
<div class="modal fade" id="secondVerifyModal" tabindex="-1" role="dialog" aria-labelledby="secondVerifyModal"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.secondary_verification}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" value="closed" name="action" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_method}</label>
						<div class="col-sm-8">
							<select class="form-control" class="second_type" name="type" id="secondVerifyType">
								
							</select>
						</div>
					</div>
            	<!--忘记密码-->
                       
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="secondVerifyCode" class="form-control" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append" style="height:46px;" id="getCodeBox">
									<button class="btn btn-secondary"  type="button"  onclick="getCode(this,'login/second_verify_send')"  style="line-height:33px;" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
				<button type="button" class="btn btn-primary mr-2" id="secondVerifySubmit">{$Lang.determine}</button>
			</div>
		</div>
	</div>
</div>
{/if}

<script type="text/javascript">
{if $Get.action=="phone_code"} 
phoneCheck("","allow_login_phone_captcha")
{else/} 
phoneCheck("","allow_login_code_captcha")
{/if}
</script>