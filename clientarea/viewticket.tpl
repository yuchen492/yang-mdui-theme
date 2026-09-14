
{if $ErrorMsg}
{include file="error/alert" value="$ErrorMsg"}
{/if}

{if $SuccessMsg}
{include file="error/notifications" value="$SuccessMsg" url=""}
{/if}

{include file="includes/modal"}
<link href="/themes/clientarea/default/assets/libs/bootstrap-rating/bootstrap-rating.css?v={$Ver}"
	rel="stylesheet" />
	<script>
		
	function adminScore(rid, type) {
		const star = $(`#starRating${rid}`).val();
		const obj = {
			rid,
			type,
			star,
			tid: '{$Think.get.tid}'
		}
		$.ajax({
			type: "post",
			url: '/ticket/evaluate',
			data: obj,
			success: function (data) {
				if (data.status !== 200) {
					toastr.error(data.msg)
					return
				}
				toastr.success(data.msg)
				$(`#starRating${rid}`).attr("disabled", true);
			}
		});
	}
	</script>
	
<div class="mdui-dialog" id="yangCloseDialog">
    <div class="mdui-dialog-title">关闭工单确认</div>
    <div class="mdui-dialog-content">
        <p>您确认要关闭当前工单吗？</p>
        <p>关闭工单将视为您同意此工单结单，即本次服务完成。</p>
        <p>关闭工单后，运维成员和您都将无法继续回复此工单。</p>
        <p>请确认您描述的问题“{$ViewTicket.ticket.title}”已被正确解决。</p>
    </div>
    <div class="mdui-dialog-actions">
        <button class="mdui-btn mdui-ripple" mdui-dialog-close>取消</button>
        <button id="yangCloseDialogConfirmBtn" class="mdui-btn mdui-ripple" onclick="yangCloseTicket()">确定</button>
    </div>
</div>

<script>
function yangCloseTicket() {
    $("#yangCloseDialogConfirmBtn").attr("disabled",true);
    $("#yangCloseDialogConfirmBtn").html("请稍后");
    $.ajax({
        type: "POST",
        url: '/ticket/close',
        data: {
            tid: '{$ViewTicket.ticket.tid}',
            token: '{$Token}'
        },
        dataType: "json",
        success: function(data) {
            mdui.snackbar({message: '工单结单成功。'});
            window.location.hred = "/supporttickets"
        }
    });
}
</script>

<div class="mdui-row">
	<div class="mdui-col-xs-12">
		<div class="mdui-card mdui-p-a-1 mdui-hoverable">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
					{$ViewTicket.ticket.title}
                </div>
                <div class="mdui-card-primary-subtitle">
					<div class="mdui-chip" style="background-color:{$ViewTicket.ticket.status.color};">
                        <span class="mdui-chip-title">{$ViewTicket.ticket.status.title}</span>
                    </div>
                    <span>工单ID：{$ViewTicket.ticket.tid}</span>
                </div>
            </div>
            <div class="mdui-card-content">
                <p>工单创建时间：{$ViewTicket.ticket.create_time|date="Y-m-d H:i"}</p>
                <p>最后动态：{$ViewTicket.ticket.last_reply_time|date="Y-m-d H:i"} (授权运维将于 24 小时内处理您的问题)</p>
                <p>对接小组：{$ViewTicket.ticket.department.name}</p>
                {if $ViewTicket.ticket.host}<p>相关产品：{$ViewTicket.ticket.host}</p>{/if}
            </div>
            <div class="mdui-card-actions">
                {if $ViewTicket.ticket.status.id != "4"}
					<a class="mdui-btn mdui-color-red" mdui-dialog="{target: '#yangCloseDialog'}">
						<i class="mdui-icon material-icons">close</i>
						{$Lang.close_work_order}
					</a>
				{/if}
				<a class="mdui-btn" href="#buttonlast">跳转到最后一条</a>
            </div>
		</div>
	</div>
</div>
		
		
{foreach $ViewTicket.list as $reply}
		
<div class="mdui-row mdui-p-a-1">
	<div class="mdui-col-xs-12">
		<div class="mdui-card mdui-hoverable">
            <div class="mdui-card-header">
                {if $reply.admin}
                    {if $reply.admin_id == "0"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=776014107&s=640"/>
                    {elseif $reply.admin_id == "1"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=776014107&s=640"/>
                    {elseif $reply.admin_id == "2"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=705043745&s=640"/>
                    {elseif $reply.admin_id == "3"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=3116716016&s=640"/>
                    {elseif $reply.admin_id == "4"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=769468853&s=640"/>
                    {elseif $reply.admin_id == "5"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=2087930050&s=640"/>
                    {elseif $reply.admin_id == "7"}
                        <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk=951628858&s=640"/>
                    {else}
                        <div class="mdui-card-header-avatar mdui-typo-display-1">
                            服
                        </div>
                    {/if}
                {else}
                    {if $Userinfo.user.qq}
                    <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk={$Userinfo.user.qq}&s=640"/>
                    {else}
                    <div class="mdui-card-header-avatar mdui-typo-display-1">
                        您
                    </div>
                    {/if}
                {/if}
                
                <div class="mdui-card-header-title">{if $reply.admin}{$reply.realname}<span class="mdui-text-color-orange">(授权运维)</span>{else}您{/if}</div>
                <div class="mdui-card-header-subtitle">{$reply.format_time}</div>
            </div>
            <div class="mdui-card-content">
                {$reply.content}
                {if $reply.attachment}
					<div>{$Lang.enclosure}：</div>
					{foreach $reply.attachment as $attachments}
					<div>
						<a href="http://{$attachments}" target="_blank">{:substr($attachments,strpos($attachments,"^")+1)}</a><br>
						<img src="https://{$attachments}" />
					</div>
					{/foreach}
				{/if}
            </div>
            <div class="mdui-card-actions mdui-card-actions-stacked">
                {if $reply.admin}
					<div class="justify-content-end align-items-center"
						style="display:{$ViewTicket.feedback_request == '0'?none:flex}">
						<span id="starRatingLable{$reply.id}">{if $reply.star !='0' }谢谢评价！{else}评价这条回复：{/if}</span>
						<input type="hidden" class="rating" id="starRating{$reply.id}" data-filled="mdi mdi-star text-warning"
							data-empty="mdi mdi-star-outline text-muted" onchange="yangAdminScore('{$reply.id}','{$reply.type}')" {if
							$reply.star !='0' } disabled {/if} value="{$reply.star}" />
					</div>
				{/if}
            </div>
		</div>
	</div>
</div>
		
{/foreach}

<a name="buttonlast"></a>

{if $ViewTicket.ticket.status.id != "4"}
<form method="post" enctype="multipart/form-data">
<div class="mdui-row mdui-p-a-1">
	<div class="mdui-col-xs-12">
		<div class="mdui-card mdui-hoverable" id="ticketReplyContainer">
            <div class="mdui-card-header">
                    {if $Userinfo.user.qq}
                    <img class="mdui-card-header-avatar" src="https://q1.qlogo.cn/g?b=qq&nk={$Userinfo.user.qq}&s=640"/>
                    {else}
                    <div class="mdui-card-header-avatar mdui-typo-display-1">
                        您
                    </div>
                    {/if}
                <div class="mdui-card-header-title">您</div>
                <div class="mdui-card-header-subtitle">即将</div>
            </div>
            <div class="mdui-card-content">
				<input type="hidden" name="tid" value="{$ViewTicket.ticket.tid}" />
				<input type="hidden" name="c" value="{$ViewTicket.ticket.c}" />
				<div class="mdui-textfield">
                    <label class="mdui-textfield-label">回复</label>
                    <textarea class="mdui-textfield-input" placeholder="请仔细描述问题，尽量提供详细的问题现象、引发方式和预期正确结果" id="content" name="content" rows="10"></textarea>
                </div>
                <div class="mdui-table-fluid">
                    <table class="mdui-table mdui-table-hoverable">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="filelist">
                            <tr>
                                <td>插入新附件</td>
                                <td><a class="mdui-btn" id="addFileBtn"><i class="mdui-icon material-icons">add_to_photos</i> 添加附件</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="mdui-card-actions">
                <button type="submit" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-blue-a400 submitBtn">
				<i class="mdui-icon material-icons">cloud_upload</i> 提交回复
				</button>
            </div>
		</div>
	</div>
</div>
</form>

{else}

<div class="mdui-row mdui-p-a-1">
	<div class="mdui-col-xs-12">
		<div class="mdui-card">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">
                    <i class="mdui-icon material-icons">block</i> 此工单已关闭
                </div>
            </div>
            <div class="mdui-card-content">
                此工单已关闭，您不能再在此工单发布回复。如有需要，请<a href="/submitticket">提交新工单</a>，或点击下方按钮重新开启工单。
            </div>
            
            <form method="post" enctype="multipart/form-data">
				<input type="hidden" name="tid" value="{$ViewTicket.ticket.tid}" />
				<input type="hidden" name="c" value="{$ViewTicket.ticket.c}" />
				<input type="hidden" id="content" name="content" value="用户重新开启了工单。"></input>
				<div class="mdui-card-actions">
				    <button type="submit" class="mdui-btn mdui-color-theme"><i class="mdui-icon material-icons">autorenew</i> 重新开启工单</button>
				    <a href="/submitticket" class="mdui-btn">提交新工单</a>
				</div>
			<form>
		</div>
	</div>
</div>

{/if}

<script src="/themes/clientarea/default/assets/libs/bootstrap-rating/bootstrap-rating.min.js?v={$Ver}"></script>
<script src="/themes/clientarea/default/assets/js/rating-init.js?v={$Ver}"></script>
<script>
    $('#addFileBtn').on('click', function () {

		// 添加更多附件
		var fileHtml = `
			<tr class="filebox">
                            <td><input type="file" class="form-control-file fileWacth" name="attachments[]"></td>
                            <td class="filetd"><a class="mdui-btn deletefileBtn"><i class="mdui-icon material-icons">delete</i> 删除此附件</a></td>
                        </tr>
	`
		$('#filelist').append(fileHtml)

	});

	// 删除附件
	$('#filelist').on('click', '.deletefileBtn', function () {
		$(this).parent('.filetd').parent('.filebox').remove()
	});
</script>
<script>
function yangAdminScore(rid, type) {
		const star = $(`#starRating${rid}`).val();
		const obj = {
			rid,
			type,
			star,
			tid: '{$ViewTicket.ticket.tid}'
		}
		$.ajax({
			type: "post",
			url: '/ticket/evaluate',
			data: obj,
			success: function (data) {
				if (data.status !== 200) {
					mdui.snackbar({message: '评价失败，请稍后重试。'});
					return
				}
				mdui.snackbar({message: '评价成功，感谢反馈！'});
				$(`#starRatingLable${rid}`).html("谢谢评价！");
				$(`#starRating${rid}`).attr("disabled", true);
			}
		});
	}
</script>