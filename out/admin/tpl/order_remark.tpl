[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{ if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{ if $smarty.post.smx_action }]
    [{ assign var="smxAction" value=$smarty.post.smx_action }]
[{else}]
    [{ assign var="smxAction" value="smx_notice" }]
[{/if}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="user_remark">
</form>

<table cellspacing="0" cellpadding="0" border="0" width="">
<tr>
    <td valign="top" class="edittext" style="width: 250px;">
        <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
            [{ $oViewConf->getHiddenSid() }]
            <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
            <input type="hidden" name="fnc" value="">
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="editval[oxuser__oxid]" value="[{ $oxid }]">
            <input type="hidden" name="rem_oxid" value="[{ $rem_oxid }]">
            <input type="hidden" name="smx_action" value="">
            &nbsp;&nbsp;
            <input type="submit" value=" &nbsp;&nbsp;[{ oxmultilang ident="SMX_ORDER_REMARK_NEWNOTICE" }]&nbsp;&nbsp; " onClick="document.myedit.smx_action.value='smx_notice'">
            &nbsp;&nbsp;
            <input type="submit" value=" &nbsp;&nbsp;[{ oxmultilang ident="SMX_ORDER_REMARK_NEWEMAIL" }]&nbsp;&nbsp; " onClick="document.myedit.smx_action.value='smx_mail'">
        </form>
        <br />

        <form name="myedit1" id="myedit1" action="[{ $oViewConf->getSelfLink() }]" method="post">
            [{ $oViewConf->getHiddenSid() }]
            <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
            <input type="hidden" name="fnc" value="">
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="editval[oxuser__oxid]" value="[{ $oxid }]">
            <input type="hidden" name="rem_oxid" value="[{ $rem_oxid }]">
            <input type="hidden" name="smx_action" value="false">
            <select name="rem_oxid" size="22" class="editinput" style="width: 220px;" onChange="document.myedit1.submit();" [{ $readonly }]>
                [{foreach from=$allremark item=allitem}]
                    <option value="[{ $allitem->oxremark__oxid->value }]" [{ if $allitem->selected}]SELECTED[{/if}]>
                        [{ $allitem->oxremark__oxheader|date_format:"%d.%m.%Y %H:%M:%S" }]
                         - [{ if $allitem->oxremark__oxtype->value == "r" }][{ oxmultilang ident="ORDER_REMARK_REMARK" }][{elseif $allitem->oxremark__oxtype->value == "o" }][{ oxmultilang ident="ORDER_REMARK_ORDER" }][{elseif $allitem->oxremark__oxtype->value == "c" }][{ oxmultilang ident="ORDER_REMARK_USER" }][{elseif $allitem->oxremark__oxtype->value == "smx_notice" }][{ oxmultilang ident="SMX_ORDER_REMARK_NOTICE" }]                    [{elseif $allitem->oxremark__oxtype->value == "smx_mail" }][{ oxmultilang ident="SMX_ORDER_REMARK_EMAIL" }][{else}][{ oxmultilang ident="ORDER_REMARK_NEWS" }][{/if}]
                    </option>
                [{/foreach}]
            </select>
        </form>
    </td>
    <td valign="top" class="edittext" align="left">
        <form name="myedit2" id="myedit2" action="[{ $oViewConf->getSelfLink() }]" method="post">
            [{ $oViewConf->getHiddenSid() }]
            <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
            <input type="hidden" name="fnc" value="">
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="editval[oxuser__oxid]" value="[{ $oxid }]">
            <input type="hidden" name="rem_oxid" value="[{ $smarty.post.rem_oxid }]">
            <input type="hidden" name="smx_action" value="[{ if $smxAction == "" }]smx_notice[{ else }][{ $smxAction }][{ /if }]">
            <input type="hidden" name="remarkheader" value="[{$remarkheader}]">
            
            
            [{ if $smxAction == "smx_notice" }]
                [{ oxmultilang ident="SMX_ORDER_REMARK_NOTICE2" }]<br />
            [{ /if }]

            [{ if $smxAction == "smx_mail" }]
                [{ oxmultilang ident="SMX_ORDER_REMARK_MAILTO" }]<br />
                <input type="text" name="smx_mail_to" value="[{ if $smxMailTo }][{ $smxMailTo }][{ else }][{ $order->oxorder__oxbillemail->value }][{ /if }]" size="50" class="editinput">
                <br /><br />
                
                [{ oxmultilang ident="SMX_ORDER_REMARK_MAILSUBJECT" }]<br />
                <input type="text" name="smx_mail_subject" value="[{ if $smxMailSubject }][{ $smxMailSubject }][{ else }][[{ $order->oxorder__oxordernr->value }]] [{ /if }]" size="50" class="editinput">
                <br /><br />
                
                [{ oxmultilang ident="SMX_ORDER_REMARK_MAILMSG" }]<br />
            [{ /if }]
            
            
            [{ if $remarktext }]
                <br /><br /><br />
                <div style="width: 500px; border: 1px solid #999; padding: 10px; background: #f0f0f0">
                    [{ $remarktext|html_entity_decode|nl2br }]
                </div>
            [{ else }]
                <textarea class="editinput" cols="100" rows="13" wrap="VIRTUAL" name="remarktext" [{ $readonly }]>[{ if $smxMailMsg }][{ $smxMailMsg }][{ else }][{ $mailSignature }][{ $remarktext }][{ /if }]</textarea>
            [{ /if }]
            <br />
            
            [{ if $smxAction != "false" }]
                <br /><input type="submit" class="edittext" name="save" value="[{ if $smxAction == "smx_mail" }][{ oxmultilang ident="SMX_ORDER_REMARK_EMAIL_SEND" }][{ else }][{ oxmultilang ident="SMX_ORDER_REMARK_SAVE" }][{ /if }]" onClick="document.myedit2.fnc.value='save';" [{ $readonly }]>
            [{ else }]    
                <input type="submit" class="edittext" name="save" value="[{ oxmultilang ident="SMX_ORDER_REMARK_DELETE" }]" onClick="document.myedit2.smx_action.value='smx_notice'; document.myedit2.fnc.value='delete';" [{ $readonly }]> &nbsp;&nbsp;
            [{ /if }]
        </form>
    </td>
</tr>
</table>


[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]
