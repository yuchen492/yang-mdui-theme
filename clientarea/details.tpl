{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg" url=""}
{/if}

<form method="post" class="needs-validation" novalidate>
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">此{if $CustomDepot.yangmdui_clientname}{$CustomDepot.yangmdui_clientname}{else}{$Setting.company_name}{/if}账户（ID:{$Userinfo.user.id}）</div>
            </div>
            <div class="mdui-card-content">
                <div class="mdui-row">
                    <div class="mdui-col-sm-6 mdui-col-xs-12">
                        <div class="mdui-textfield">
                            <label class="mdui-textfield-label">用户邮箱</label>
                            <input class="mdui-textfield-input" value="{$Userinfo.user.email}" type="text" disabled/>
                        </div>
                    </div>
                    <div class="mdui-col-sm-6 mdui-col-xs-12">
                        <div class="mdui-textfield">
                            <label class="mdui-textfield-label">绑定手机号</label>
                            <input class="mdui-textfield-input" value="{$Userinfo.user.phonenumber}" type="text" disabled/>
                        </div>
                    </div>
                    <div class="mdui-col-sm-6 mdui-col-xs-12">
                        <div class="mdui-textfield">
                            <label class="mdui-textfield-label">绑定QQ</label>
                            <input class="mdui-textfield-input" type="number" name="qq" value="{$Userinfo.user.qq}" oninput="value=value.replace(/[^\d]/g,'')" type="text"/>
                        </div>
                    </div>
                    <div class="mdui-col-sm-6 mdui-col-xs-12">
                        您可以前往<a href="/security">安全设置页面</a>更改绑定邮箱与QQ。同时，如果设置了QQ，您可以在本平台使用您的QQ头像。
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>

{if $Userinfo.client_group.group_name}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">此账户正在享受{$Userinfo.client_group.group_name}权限</div>
            </div>
            <div class="mdui-card-content">
                此账户作为{$Userinfo.client_group.group_name}，您可以享受到相关优惠。<br>
                请关注最新促销消息，帮助您更大程度节约上云成本，或分销提升利润率。
            </div>
        </div>
    </div>
</div>
<br>
{else}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">此账户尚未开通优惠或签约权限</div>
            </div>
            <div class="mdui-card-content">
                通过开通优惠权限或签约服务，您可以使用更低成本开通实例，这样您可以节约上云成本，或分销赚取利润。
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">用户昵称</div>
            </div>
            <div class="mdui-card-content">
                <p>当您填写了此用户昵称设置，系统会以您填写的名称称呼您。</p>
                <p>如果您正在为团队贡献，我们建议您填写团队名称，便于我们更好地为您的团队提供服务。</p>
                <div class="mdui-textfield">
                    <label class="mdui-textfield-label">用户昵称</label>
                    <input class="mdui-textfield-input" name="username" value="{$Userinfo.user.username}" type="text" required/>
                </div>
                <div class="mdui-textfield">
                    <label class="mdui-textfield-label">团队名</label>
                    <input class="mdui-textfield-input" name="companyname" value="{$Userinfo.user.companyname}" type="text"/>
                </div>
            </div>
        </div>
    </div>
</div>
<br>

{if $Userinfo.gateways}
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">默认支付方式</div>
            </div>
            <div class="mdui-card-content">
                <p>当您的账户余额不足时，默认将唤起的支付方式。</p>
                <p>您仍然可以在结算页面切换支付渠道，此设置不会限制您使用其他方式结算。</p>
                <select class="mdui-select" name="defaultgateway">
                  {foreach $Userinfo.gateways as $gateway}
                  <option value="{$gateway.name}" {if $Userinfo.user.defaultgateway==$gateway.name}selected{/if}>
                    {$gateway.title}</option>
                  {/foreach}
                </select>
            </div>
        </div>
    </div>
</div>
<br>
{/if}

<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">其他设置</div>
            </div>
            <div class="mdui-card-content">
                <div class="row">
                    <div class="col-sm-6 col-12">
                      <div class="form-group">
                        <label for="formrow-firstname-input">{$Lang.country}</label>
                        <select class="form-control" name="country">
                          {foreach $Details.areas.country as $country}
                          <option {if $country.name==$Userinfo.user.country}selected{/if} value="{$country.name}">{$country.name}</option>
                          {/foreach}
                        </select>
                      </div>
                    </div>
                    <div class="col-sm-6 col-12">
                      <div class="form-group">
                        <label for="formrow-firstname-input">{$Lang.province}</label>
                        <input type="text" class="form-control" name="province" value="{$Userinfo.user.province}">
                      </div>
                    </div>
                    <div class="col-sm-6 col-12">
                      <div class="form-group">
                        <label for="formrow-firstname-input">{$Lang.city}</label>
                        <input type="text" class="form-control" name="city" value="{$Userinfo.user.city}">
                      </div>
                    </div>
                    <div class="col-sm-6 col-12">
                      <div class="form-group">
                        <label for="formrow-firstname-input">{$Lang.region}</label>
                        <input type="text" class="form-control" name="region" value="{$Userinfo.user.region}">
                      </div>
                    </div>
                    <div class="col-sm-6 col-12">
                      <div class="form-group">
                        <label for="formrow-firstname-input">{$Lang.address}</label>
                        <input type="text" class="form-control" name="address1" value="{$Userinfo.user.address1}">
                      </div>
                    </div>
                    
                    <div class="col-sm-6 col-12">
                      <div class="form-group">
                        <label for="formrow-firstname-input">{$Lang.marketing_information}</label>
                        <div class="custom-control custom-checkbox">
                          <input type="checkbox" class="custom-control-input" id="marketing_emails_opt_in"
                            name="marketing_emails_opt_in" value="1" {if $Userinfo.user.marketing_emails_opt_in==1}
                            checked="checked" {/if}>
                          <label class="custom-control-label" for="marketing_emails_opt_in">{$Lang.accept_marketing_information}</label>
                        </div>
                      </div>
                    </div>
                    {foreach $Userinfo.customs as $custom}
                    <div class="col-sm-6 col-12">
                      <div class="form-group" data-order="{$custom.sortorder}">
                        <label for="formrow-firstname-input">{$custom.fieldname}</label>
                        {if $custom.fieldtype == 'dropdown'}
                        <select class="form-control" name="custom[{$custom.id}]">
                          {foreach :explode(",",$custom.fieldoptions) as $field}
                          <option {if $field==$custom.value}selected{/if}>{$field}</option>
                          {/foreach}
                        </select>
                        {elseif $custom.fieldtype == 'text'}
                        <input type="text" class="form-control" name="custom[{$custom.id}]" value="{$custom.value}"
                          placeholder="{$custom.description}" {if $custom.required}required{/if} />
                        {elseif $custom.fieldtype == 'password'}
                        <input type="password" class="form-control" name="custom[{$custom.id}]" value="{$custom.value}"
                          placeholder="{$custom.description}" {if $custom.required}required{/if} />
                        {elseif $custom.fieldtype == 'link'}
                        <input type="text" class="form-control" name="custom[{$custom.id}]" value="{$custom.value}"
                          placeholder="{$custom.description}" {if $custom.required}required{/if} />
                        {elseif $custom.fieldtype == 'tickbox'}
                        <div class="custom-control custom-checkbox">
                          <input type="checkbox" class="custom-control-input" id="custom[{$custom.id}]" name="custom[{$custom.id}]">
                          <label class="custom-control-label" for="custom[{$custom.id}]">{$custom.description}</label>
                        </div>
                        {elseif $custom.fieldtype == 'textarea'}
                        <textarea class="form-control" name="custom[{$custom.id}]" rows="5"
                          placeholder="{$custom.description}">{$custom.value}</textarea>
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

  
<div class="mdui-row">
    <div class="mdui-col-xs-12">
        <div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">保存设置</div>
            </div>
            <div class="mdui-card-content">
                <p>当您修改完成后，请您手动点击按钮进行保存。</p>
            </div>
            <div class="mdui-card-actions">
                <button type="submit" class="mdui-btn mdui-color-theme mdui-btn-raised submitBtn">{$Lang.submit}</button>
            </div>
        </div>
    </div>
</div>

</form>


