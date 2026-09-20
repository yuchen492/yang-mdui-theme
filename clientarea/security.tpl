{include file="includes/modal"}
<link href="/themes/clientarea/yang-mdui-re/assets/css/security-page.css?v={$Ver}&style=20260921" rel="stylesheet" type="text/css" />
<script src="/themes/clientarea/yang-mdui-re/assets/js/public.js?v={$Ver}"></script>

<!-- 顶端用户信息与安全强度卡片 -->
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">安全中心</div>
            </div>
            <div class="mdui-card-content">
                <div class="security-header-content">
                    <div class="security-avatar-box phonehide">
                        <div class="security-user-avatar">
                            {if preg_match("/^[0-9]*[A-Za-z]+$/is", substr($Userinfo.user.username,0,1))}
                            {$Userinfo.user.username|substr=0,1|upper}
                            {elseif preg_match("/^[\x7f-\xff]*$/", substr($Userinfo.user.username,0,3))}
                            {$Userinfo.user.username|substr=0,3}
                            {else}
                            {$Userinfo.user.username|substr=0,1|upper}
                            {/if}
                        </div>
                    </div>
                    <div class="security-main-info">
                        <div class="security-username-row">
                            <span>{$Userinfo.user.username}</span>
                            {if $Setting.certifi_open==1}
                            {if $Userinfo.user.certifi.status == '1'}
                            <span class="badge badge-success">{$Lang.real_name_authentication}</span>
                            {else}
                            <span class="badge badge-light novalid">{$Lang.no_real_name_authentication}</span>
                            {/if}
                            {/if}
                        </div>
                        <div class="security-strength-bar">
                            <div class="security-strength-label">
                                {$Lang.account_security_strength}:
                                <span class="security-text">
                                    {$percentage[0]}
                                </span>
                            </div>
                            <div class="security-strength-progress">
                                <div class="progress-bar" role="progressbar" style="width: {$percentage[1]}%"
                                    aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    <div class="security-meta-list">
                        <ul>
                            <li>
                                <label>{$Lang.mailbox}：</label>
                                {if $Userinfo.user.email}
                                {$Userinfo.user.email}
                                {else}
                                {$Lang.unbound}
                                {/if}
                            </li>
                            <li>
                                <label>{$Lang.mobile_phone}：</label>
                                {if $Userinfo.user.phonenumber}
                                {$Userinfo.user.phonenumber}
                                {else}
                                {$Lang.unbound}
                                {/if}
                            </li>
                            <li>
                                <label>{$Lang.opening_time}：</label>
                                {$Userinfo.user.create_time|date="Y-m-d H:i:s"}
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>

<!-- 登录密码卡片 -->
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    {$Lang.login_password}
                    {if $Userinfo.user.is_password}
                    <small class="security-status-badge">
                        <i class="far fa-check-circle"></i>
                        {$Lang.set}
                    </small>
                    {/if}
                </div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.regularly_details}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if $Userinfo.user.is_password}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#modifyPasswordModal" onclick="showPassword()">{$Lang.modify}</a>
                        {else}
                        <a data-target="#modifyPasswordModal" onclick="showPassword()" data-toggle="modal"
                            class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.set_password}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>

<!-- 手机绑定卡片 -->
{if $Userinfo.shd_allow_sms_send}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    {$Lang.mobile_phone_binding}
                    {if $Userinfo.user.phonenumber}
                    <small class="security-status-badge">
                        <span class="phonehide">{$Userinfo.user.phonenumber|substr=0,3}****{$Userinfo.user.phonenumber|substr=7,11}</span>
                        <i class="far fa-check-circle"></i>
                        {$Lang.set}
                    </small>
                    {/if}
                </div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.regularly_details}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if $Userinfo.user.phonenumber&&$BindPhoneChange==0}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#bindPhoneChangeModal1" id="bindPhoneChangeBtn1">{$Lang.modify}</a>
                        {elseif $Userinfo.user.phonenumber&&$BindPhoneChange==1}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#bindPhoneChangeModal2" id="bindPhoneChangeBtn2">{$Lang.modify}</a>
                        {else}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#bindPhoneModal">{$Lang.bind_now}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- 邮箱绑定卡片 -->
{if $Userinfo.shd_allow_email_send}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    {$Lang.mailbox_binding}
                    {if $Userinfo.user.email}
                    <small class="security-status-badge">
                        <span class="phonehide">{$Userinfo.user.email}</span>
                        <i class="far fa-check-circle"></i>
                        {$Lang.set}
                    </small>
                    {/if}
                </div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.reset_password_notice}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if $Userinfo.user.email&&$BindEmailChange==0}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#changeEmailHandleModal1">{$Lang.modify}</a>
                        {elseif $Userinfo.user.email&&$BindEmailChange==1 /}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#changeEmailHandleModal2">{$Lang.modify}</a>
                        {else}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#bindEmailHandleModal">{$Lang.mailbox_binding}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- 实名认证卡片 -->
{if $Setting.certifi_open==1}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    {$Lang.real_name_authentications}
                    {if $Userinfo.user.certifi.status==1}
                    <small class="security-status-badge">
                        <i class="far fa-check-circle"></i>
                        {$Lang.set}
                    </small>
                    {/if}
                </div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.personal_security}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if $Userinfo.user.certifi.status == 1}
                        {if $Userinfo.user.certifi.type == 'certifi_person'}
                        <a href="verified?action=enterprises&step=info"
                            class="btn btn-outline-primary w-md waves-effect waves-light">去企业认证</a>
                        {else}
                        <a href="verified" class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.certified}</a>
                        {/if}
                        {else}
                        <a href="verified" class="btn btn-primary w-md waves-effect waves-light">{$Lang.not_certified}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- 二次验证卡片 -->
{if $Userinfo.allow_second_verify}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    {$Lang.secondary_verification}
                    {if $Userinfo.user.second_verify}
                    <small class="security-status-badge">
                        <i class="far fa-check-circle"></i>
                        {$Lang.set}
                    </small>
                    {/if}
                </div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.secondary_verification_details}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if $Userinfo.user.second_verify}
                        <a class="btn btn-primary w-md waves-effect waves-light"
                            onclick="closeSecondHandleClick()">{$Lang.close}</a>
                        {else}
                        <a class="btn btn-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#toggleSecondVerifyModalOpen">{$Lang.opens_two}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- API卡片（原工程注释状态完整保留，不擅自启用） -->
{if $Userinfo.allow_resource_api}
<!-- <div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">API</div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.administration_details}</p>
                    </div>
                    <div class="security-card-action-box">
                        <a class="btn btn-primary w-md waves-effect waves-light" onclick="showApiPwdHandleClick()">{$Lang.view_secret_key}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br> -->
{/if}

<!-- 交流授权卡片 -->
{if $Bot==1}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">{$Lang.interflow_license}</div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.interflow_license_details}</p>
                    </div>
                    <div class="security-card-action-box">
                        <a class="btn btn-primary w-md waves-effect waves-light"
                            onclick="showInterflowlicenseHandleClick()">{$Lang.license}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- 短信提醒卡片 -->
{if $Userinfo.shd_allow_sms_send}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">{$Lang.sms_reminder}</div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.sms_settings}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if !$Userinfo.user.phonenumber}
                        <button data-v-2d646d70="" disabled="disabled" type="button"
                            class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.need_bind_mobile_phone}</button>
                        {elseif $Userinfo.user.is_login_sms_reminder==1}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#loginSmsReminderModal">{$Lang.cancel}</a>
                        {else}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#loginSmsReminderModalOpen">{$Lang.opens_two}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- 邮箱提醒卡片 -->
{if $Userinfo.shd_allow_email_send}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">{$Lang.email_reminder}</div>
            </div>
            <div class="mdui-card-content">
                <div class="security-card-flex">
                    <div class="security-card-desc-box">
                        <p class="security-card-desc">{$Lang.mailbox_settings}</p>
                    </div>
                    <div class="security-card-action-box">
                        {if !$Userinfo.user.email}
                        <button data-v-2d646d70="" disabled="disabled" type="button"
                            class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.need_bind_mailbox}</button>
                        {elseif $Userinfo.user.email_remind==1}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#loginEmailReminderModal">{$Lang.cancel}</a>
                        {else}
                        <a class="btn btn-outline-primary w-md waves-effect waves-light" data-toggle="modal"
                            data-target="#loginEmailReminderModalOpen">{$Lang.set_up_now}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<!-- 第三方登录卡片 -->
{if $Security.oauthBind}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card security-page-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">{$Lang.third_party_login}</div>
            </div>
            <div class="mdui-card-content">
                <div class="security-oauth-list">
                    {foreach $Security.oauthBind as $oauth}
                    <div class="security-oauth-item">
                        <div class="security-oauth-left">
                            <div class="security-oauth-icon">
                                {$oauth.img}
                            </div>
                            <div>
                                <div class="security-oauth-name">{$oauth.name}</div>
                                <div class="security-oauth-desc">
                                    {if $oauth.oauth=="bind"}
                                    {$Lang.nickname}：{$oauth.username}
                                    {elseif $oauth.oauth == 'unbind'}
                                    {$Lang.unbound}
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="security-card-action-box">
                            {if $oauth.oauth == 'unbind'}
                            <a href="{$oauth.url}" class="btn btn-primary w-md waves-effect waves-light">{$Lang.binding}</a>
                            {elseif $oauth.oauth == 'bind'}
                            <a href="javascript: getModal('oauthBind/untie/{$oauth.dirName}', '{$Lang.prompt}', '{$Lang.make_sure_unbind}{$oauth.name}?', {status: 1});"
                                class="btn btn-outline-primary w-md waves-effect waves-light">{$Lang.solution}</a>
                            {/if}
                        </div>
                    </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>
<br>
{else}
<div class="security-item-image"></div>
{/if}

<!-- start: 修改密码模态框 -->
<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{if
					$Userinfo.user.is_password}{$Lang.change_password}{else}{$Lang.set_password}{/if}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="modifyPwdForm" class="needs-validation" novalidate>
					{if $Userinfo.user.is_password}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.original_password}</label>
						<div class="col-sm-8">
							<div class="input-group">
		
								<input type="password" name="old_password" class="form-control old_password" id="oldPwd"
									onblur="oldPwdBlur()" placeholder="{$Lang.security_please_enter_password}" required />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary  old_password_btn">
										<i class="far fa-eye"></i>
									</button>
								</div>
							</div>
							<input type="hidden" name="flag" vaule="1" />
						</div>
					</div>
					{else/}
					<input type="hidden" name="flag" vaule="2" />
					{/if}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{if
							$Userinfo.user.is_password}{$Lang.new_password}{else}{$Lang.password}{/if}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="password" name="password" class="form-control password" id="pwd" onblur="pwdBlur()"
									placeholder="{if $Userinfo.user.is_password}{$Lang.security_please_new_password}{else}{$Lang.security_please_password}{/if}"
									required />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary  password_btn">
										<i class="far fa-eye"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{if
							$Userinfo.user.is_password}{$Lang.repeat_new_password}{else}{$Lang.repeat_then_password}{/if}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="password" name="re_password" class="form-control re_password" id="rePwd"
									onblur="rePwdBlur()"
									placeholder="{if $Userinfo.user.is_password}{$Lang.repeat_new_password}{else}{$Lang.repeat_password}{/if}"
									required />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary  re_password_btn">
										<i class="far fa-eye"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					{if $Verify.allow_resetpwd_captcha==1&&$Userinfo.user.is_password}
					{include file="includes/verify" type="allow_resetpwd_captcha"}
					{elseif $Verify.allow_setpwd_captcha==1&&!$Userinfo.user.is_password}
					{include file="includes/verify" type="allow_setpwd_captcha"}
					{/if}
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="modifyPwdSubmit"
					onclick="modifyPwdCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<script>
	var _url = '';
	var phoneType = '{$BindPhoneChange}'
	var is_password = '{$Userinfo.user.is_password}';
	var emailType = '{$BindEmailChange}'
	var WebUrl = '/';
	//修改密码input事件
	function oldPwdBlur() {
		var oldPwd = document.getElementById('oldPwd')
		if (oldPwd && oldPwd.value == '') {
			oldPwd.classList.remove("is-valid"); //清除合法状态
			oldPwd.classList.add("is-invalid"); //添加非法状态
			return
		} else if (oldPwd) {
			oldPwd.classList.remove("is-invalid");
			oldPwd.classList.add("is-valid");
		}
	}

	function validateCode() {
		var valCode = document.getElementById('loginSmsReminderCode')
		if (valCode.value == '') {
			valCode.classList.remove("is-valid"); //清除合法状态
			valCode.classList.add("is-invalid"); //添加非法状态
			return
		} else if (valCode) {
			valCode.classList.remove("is-invalid");
			valCode.classList.add("is-valid");
		}
	}

	function emailReminderCode() {
		var emailReminderCode = document.getElementById('loginEmailReminderCode')
		if (emailReminderCode.value == '') {
			emailReminderCode.classList.remove("is-valid"); //清除合法状态
			emailReminderCode.classList.add("is-invalid"); //添加非法状态
			return
		} else if (emailReminderCode) {
			emailReminderCode.classList.remove("is-invalid");
			emailReminderCode.classList.add("is-valid");
		}
	}

	function pwdBlur() {
		var pwd = document.getElementById('pwd')
		if (pwd.value == '') {
			pwd.classList.remove("is-valid"); //清除合法状态
			pwd.classList.add("is-invalid"); //添加非法状态
			return
		} else {
			pwd.classList.remove("is-invalid");
			pwd.classList.add("is-valid");
		}
	}

	function rePwdBlur() {
		var rePwd = document.getElementById('rePwd')
		if (rePwd.value == '') {
			rePwd.classList.remove("is-valid"); //清除合法状态
			rePwd.classList.add("is-invalid"); //添加非法状态
			return
		} else {
			rePwd.classList.remove("is-invalid");
			rePwd.classList.add("is-valid");
		}
	}
	//修改手机绑定模态框 input事件
	function bindPhoneChangeCode1Blur() {
		var code1 = document.getElementById('bindPhoneChangeCode1')
		if (code1.value == '') {
			code1.classList.remove("is-valid"); //清除合法状态
			code1.classList.add("is-invalid"); //添加非法状态
			return
		} else {
			code1.classList.remove("is-invalid");
			code1.classList.add("is-valid");
		}
	}
	//修改手机绑定模态框 input事件
	function changeEmailHandleCodeBlur() {
		var code1 = document.getElementById('changeEmailHandleCode1')
		if (code1.value == '') {
			code1.classList.remove("is-valid"); //清除合法状态
			code1.classList.add("is-invalid"); //添加非法状态
			return
		} else {
			code1.classList.remove("is-invalid");
			code1.classList.add("is-valid");
		}
	}
</script>
<!-- end: 修改密码模态框 -->

<!-- start: 手机绑定模态框 -->
<div class="modal fade" id="bindPhoneModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.mobile_phone_binding}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							<input type="text" name="phone" class="form-control" id="phoneNum" placeholder="{$Lang.input_mobile}" />
						</div>
					</div>
					{if $Verify.allow_phone_bind_captcha==1}
					{include file="includes/verify" type="allow_phone_bind_captcha" id="captchaPhone1"}
					{/if}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" class="form-control " id="code"
									placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button
										onclick="getCheckCode('bind_phone','phone','bind-phone-button','post', undefined, 'bindPhoneModal','captcha_allow_phone_bind_captchacaptchaPhone1')"
										class="btn btn-primary bind-phone-button" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindPhoneSubmit"
					onclick="bindPhoneCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 修改手机绑定 -->
<div class="modal fade" id="bindPhoneChangeModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.verify_original_phone}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindPhoneChange==0}1{else}2{/if}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							{if $Userinfo.user.phonenumber}
							<input type="text" name="tel" readonly id="oldTel"
								value="{$Userinfo.user.phonenumber|substr=0,3}****{$Userinfo.user.phonenumber|substr=7,11}"
								class="form-control" placeholder="{$Lang.input_mobile}" />
							{/if}
						</div>
					</div>
					{if $Verify.allow_phone_bind_captcha==1}
					{include file="includes/verify" type="allow_phone_bind_captcha" id="captchaPhone2"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="bindPhoneChangeCode1" class="form-control "
									onblur="bindPhoneChangeCode1Blur()" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button
										onclick="getCheckCode('bind_phone_code','tel','bind-phone-button1','get',1, 'bindPhoneChangeModal1','captcha_allow_phone_bind_captchacaptchaPhone2')"
										class="btn btn-primary bind-phone-button1" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindPhoneChangeSubmit1"
					onclick="phoneChangeBtn()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="bindPhoneChangeModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.bind_mobile_phone}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindPhoneChange==0}1{else}2{/if}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							<input type="text" name="tel" id="newTel" class="form-control" placeholder="{$Lang.input_mobile}" />
						</div>
					</div>
					{if $Verify.allow_phone_bind_captcha==1}
					{include file="includes/verify" type="allow_phone_bind_captcha" id="captchaPhone3"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="bindPhoneChangeCode2" class="form-control "
									placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button id="bindPhoneChangeCodeBtn2"
										onclick="getCheckCode('bind_phone_code','tel','bind-phone-button2','get',2, 'bindPhoneChangeModal2','captcha_allow_phone_bind_captchacaptchaPhone3')"
										class="btn btn-primary bind-phone-button2" type="button">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindPhoneChangeSubmit2"
					onclick="phoneChangeBtn2()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start 短信提醒 关闭 -->
<div class="modal fade" id="loginSmsReminderModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">{$Lang.turn_off_sms_alert}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="phone_code" value="+86" />
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.phone_number}</label>
						<div class="col-sm-8">
							<input type="text" name="name" readonly
								value="{$Userinfo.user.phonenumber|substr=0,3}****{$Userinfo.user.phonenumber|substr=7,11}"
								class="form-control" placeholder="{$Lang.input_mobile}" />
						</div>
					</div>
					{if $Verify.allow_cancel_sms_captcha==1}
					{include file="includes/verify" type="allow_cancel_sms_captcha" id="captchaSms1"}
					{/if}
					<div class="form-group row">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" class="form-control " id="loginSmsReminderCode"
									placeholder="{$Lang.please_enter_code}" onblur="validateCode()" />
								<div class="input-group-append">
									<button
										onclick="getCheckCode('remind_send','phone','bind-phone-button','get', undefined, 'loginSmsReminderModal','captcha_allow_cancel_sms_captchacaptchaSms1')"
										class="btn btn-primary bind-phone-button" type="button">{$Lang.get_code}</button>
								</div>

							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginSmsReminderSubmit"
					onclick="loginSmsReminderCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 短信提醒 开启 -->
<div class="modal fade" id="loginSmsReminderModalOpen" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="d-flex align-items-center">
					<i class="far fa-exclamation-circle fs-20 text-warning mr-2"></i>
					{$Lang.on_reminder}
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginSmsReminderSubmitOpen"
					onclick="smsSubmitOpenBtn()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>

<!-- end -->


<!-- start: 邮箱绑定 -->
<div class="modal fade" id="bindEmailHandleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.mailbox_binding}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" class="form-control" placeholder="{$Lang.please_input_email}"
								id="bindEmailHandleEmail" />
						</div>
					</div>
					{if $Verify.allow_email_bind_captcha==1}
					{include file="includes/verify" type="allow_email_bind_captcha" id="captchaEmail1"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" class="form-control" placeholder="{$Lang.please_enter_code}"
									id="bindEmailHandleCode" />
								<div class="input-group-append">
									<button class="btn btn-primary bind-email-button"
										onclick="getCheckCode('bind_email','email','bind-email-button','post', undefined, 'bindEmailHandleModal','captcha_allow_email_bind_captchacaptchaEmail1')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="bindEmailHandleSubmit"
					onclick="bindEmailHandleCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 邮箱修改 -->
<div class="modal fade" id="changeEmailHandleModal1" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.verify_original_email}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindEmailChange==0}1{else}2{/if}" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" id="changeEmailHandleEmail1" readonly value="{$Userinfo.user.email}"
								class="form-control" placeholder="{$Lang.please_input_email}" />
						</div>
					</div>
					{if $Verify.allow_email_bind_captcha==1}
					{include file="includes/verify" type="allow_email_bind_captcha" id="captchaEmail2"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="changeEmailHandleCode1" onblur="changeEmailHandleCodeBlur()"
									class="form-control" placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button class="btn btn-primary bind-email-button1"
										onclick="getCheckCode('change_email','email','bind-email-button1','post',1, 'changeEmailHandleModal1','captcha_allow_email_bind_captchacaptchaEmail2')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="changeEmailHandleSubmit1"
					onclick="changeEmailBtn()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="changeEmailHandleModal2" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.bind_new_mailbox}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<input type="hidden" name="type" value="{if $BindEmailChange==0}1{else}2{/if}" id="captcha3" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" id="changeEmailHandleEmail2" class="form-control"
								placeholder="{$Lang.please_input_email}" />
						</div>
					</div>
					{if $Verify.allow_email_bind_captcha==1}
					{include file="includes/verify" type="allow_email_bind_captcha" id="captchaEmail3"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="changeEmailHandleCode2" class="form-control"
									placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button class="btn btn-primary bind-email-button2"
										onclick="getCheckCode('change_email','email','bind-email-button2','post',2, 'changeEmailHandleModal2','captcha_allow_email_bind_captchacaptchaEmail3')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="changeEmailHandleSubmit2"
					onclick="changeEmailBtn2()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 邮箱提醒 关闭 -->
<div class="modal fade" id="loginEmailReminderModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.off_reminder}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="hidden" value="{$Token}" />
					<div class="form-group row mb-4">
						<label class="col-sm-3 col-form-label text-right">{$Lang.mailbox}</label>
						<div class="col-sm-8">
							<input type="text" name="email" readonly value="{$Userinfo.user.email}" class="form-control"
								placeholder="{$Lang.please_input_email}" />
						</div>
					</div>
					{if $Verify.allow_cancel_email_captcha==1}
					{include file="includes/verify" type="allow_cancel_email_captcha"}
					{/if}
					<div class="form-group row mb-0">
						<label class="col-sm-3 col-form-label text-right">{$Lang.verification_code}</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="code" id="loginEmailReminderCode" class="form-control"
									placeholder="{$Lang.please_enter_code}" onblur="emailReminderCode()" />
								<div class="input-group-append">
									<button class="btn btn-primary bind-email-button"
										onclick="getCheckCode('remind_email_send','email','bind-email-button','get', undefined, 'loginEmailReminderModal','captcha_allow_cancel_email_captcha')"
										type="button" id="button-addon2">{$Lang.get_code}</button>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginEmailReminderSubmit"
					onclick="loginEmailReminderCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 邮箱提醒 开启 -->
<div class="modal fade" id="loginEmailReminderModalOpen" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="d-flex align-items-center">
					<i class="far fa-exclamation-circle fs-20 text-warning mr-2"></i>
					{$Lang.open_mailbox_reminder}
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="loginEmailReminderSubmitOpen"
					onclick="loginEmailReminderSubmitOpen()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>
<!-- start: 二次验证 开启 -->
<div class="modal fade" id="toggleSecondVerifyModalOpen" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.prompt}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="d-flex align-items-center">
					<i class="far fa-exclamation-circle fs-20 text-warning mr-2"></i>
					{$Lang.determine_verification}
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
				<button type="button" class="btn btn-primary mr-2" id="toggleSecondVerifySubmitOpen"
					onclick="toggleSecondVerifySubmitOpen()">{$Lang.determine}</button>
			</div>
		</div>
	</div>
</div>

<!-- start: api -->
<div class="modal fade" id="getapiModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.modify_key}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group row">
						<label class="col-sm-2 col-form-label text-right">{$Lang.api_key}</label>
						<div class="col-sm-9">
							<div class="input-group">
								<input id="copy-apiss" type="password" name="api" value="{$Userinfo.user.api_password}"
									data-clipboard-text="{$Userinfo.user.api_password}" class="form-control api_passwordss"
									placeholder="{$Lang.please_enter_code}" />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary btn-password">
										<i class="far fa-eye"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row mb-0">
						<label class="col-sm-2"></label>
						<div class="col-sm-8">
							<button type="button" class="btn btn-default btn-sm btn-copies w-xs mr-1"
								data-clipboard-target="#copy-apiss" id="btn-copies" onclick="cpBtn()">
								{$Lang.copy}
							</button>
							<button type="button" onClick="getApiPwd()" class="btn btn-default btn-sm btn-random w-xs">
								{$Lang.reset}
							</button>
						</div>
					</div>
				</form>
				<script src="/themes/clientarea/yang-mdui-re/assets/libs/clipboard/clipboard.min.js"></script>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="getapiModalSubmit"
					onclick="getapiModalCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>

<!-- start: interflow -->
<div class="modal fade" id="interflowModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{$Lang.seting_license}</h5>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="accountbind-form">
					
					<div class="form-group row">
						<label class="col-sm-2 col-form-label text-right" name="i_type">
						</label>
						<div class="col-sm-9">
							<div class="input-group">
								<input id="copy-apiss" name="qq" class="form-control"/>
							</div>
						</div>
					</div>

				</form>
				<script src="/themes/clientarea/yang-mdui-re/assets/libs/clipboard/clipboard.min.js"></script>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="getapiModalSubmit"
					onclick="getapiModalCheckForm()">{$Lang.determine}</button>
				<button type="button" class="btn btn-outline-light" data-dismiss="modal">{$Lang.cancel}</button>
			</div>
		</div>
	</div>
</div>

<script src="/themes/clientarea/yang-mdui-re/assets/js/security.js?v={$Ver}&fix=email-20260921"></script>
