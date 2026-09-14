{include file="includes/tablestyle"}

<div class="mdui-card">
    <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">工单列表</div>
        <a class="mdui-btn mdui-color-theme mdui-btn-raised" href="submitticket"><i class="mdui-icon material-icons">add</i> 提交工单</a>
    </div>
    {if $SupportTickets}
	<div class="mdui-card-content">
        <div class="mdui-table-fluid">
            <table class="mdui-table mdui-table-hoverable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>工单标题</th>
                        <th>创建时间</th>
                        <th>回复时间</th>
                        <th>处理状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $SupportTickets as $ticket}
                    <tr>
                        <td>{$ticket.tid}</td>
                        <td>
                            <div class="mdui-chip">
                               <span class="mdui-chip-title">{$ticket.department_name}</span>
                            </div>
                            {if $ticket.priority == "high"}
                                <div class="mdui-chip mdui-color-orange" mdui-tooltip="{content: '您认为事态紧急，团队成员会优先考虑处理此工单'}">
                                    <span class="mdui-chip-title">紧急</span>
                                </div>
                            {elseif $ticket.priority == "low"}
                                <div class="mdui-chip mdui-color-grey" mdui-tooltip="{content: '您主动设置事态不紧急，我们可能会优先处理其他工单，感谢您帮助我们提升服务效率！'}">
                                    <span class="mdui-chip-title">宽松</span>
                                </div>
                            {/if}
                            {$ticket.title}
                        </td>
                        <td>{$ticket.create_time|date="Y-m-d H:i"}</td>
                        <td>{$ticket.last_reply_time|date="Y-m-d H:i"}
                            {if $ticket.status.id == "4"}
                            <span class="mdui-text-color-grey">(+{$ticket['last_reply_time']/60 - $ticket['create_time']/60|round=###,0}分钟结毕)</span>
                            {else}
                            <span class="mdui-text-color-green">(+{$ticket['last_reply_time']/60 - $ticket['create_time']/60|round=###,0}分钟处理中)</span>
                            {/if}
                        </td>
                        <td>
                            <div class="mdui-chip" style="background-color:{$ticket.status.color};">
                                <span class="mdui-chip-title">{$ticket.status.title}</span>
                            </div>
                        </td>
                        <td>
                            {if $ticket.status.id == "4"}
                                <a href="viewticket?tid={$ticket.tid}&c={$ticket.c}" class="mdui-btn"><i class="mdui-icon material-icons">reply</i> 回顾</a>
                            {elseif $ticket.status.id == "2"}
                                <a href="viewticket?tid={$ticket.tid}&c={$ticket.c}" class="mdui-btn mdui-btn-raised mdui-color-theme"><i class="mdui-icon material-icons">alarm_add</i> 处理</a>
                            {else}
                                <a href="viewticket?tid={$ticket.tid}&c={$ticket.c}" class="mdui-btn"><i class="mdui-icon material-icons">pageview</i> 查看</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
	</div>
	<div class="mdui-card-actions">
	    <ul class="pagination">
	        {$Pages}
	    </ul>
	</div>
	{else}
	<div class="mdui-card-content">
	    <div class="mdui-typo-display-1"><i class="mdui-icon material-icons">tag_faces</i> 您看起来还没有发起过工单。</div><br>
	    <p>工单应该是您优先考虑的解决问题的渠道。如果您在使用产品时遇到任何问题，欢迎点击上方按钮发起工单，运维成员会尽快为您解决。</p>
	    <p>当您的账户下有工单记录后，这里将会列举出您的工单。您可稍后在此查看交流细节。</p>
	</div>
	{/if}
</div>