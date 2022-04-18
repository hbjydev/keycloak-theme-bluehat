<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayHeader=messageHeader??; section>
    <#if messageHeader??>
        <#if section = "header">
            ${messageHeader}
        </#if>
    </#if>

    <#if section = "form">
        <p class="text-gray-800">
            ${message.summary}<#if requiredActions??><#list requiredActions>: <b><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#items></b></#list><#else></#if>
        </p>
    <#elseif section = "footer">
        <#if skipLink??>
        <#else>
            <#if pageRedirectUri?has_content>
                <#assign label=kcSanitize(msg("backToApplication"))?no_esc>
                <#assign link=pageRedirectUri>
            <#elseif actionUri?has_content>
                <#assign label=kcSanitize(msg("proceedWithAction"))?no_esc>
                <#assign link=actionUri>
            <#elseif (client.baseUrl)?has_content>
                <#assign label=kcSanitize(msg("backToApplication"))?no_esc>
                <#assign link=client.baseUrl>
            </#if>

            <div class="p-10">
                <a class="flex items-center gap-2 text-xl font-bold text-blue-500" href="${link}">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M7 16l-4-4m0 0l4-4m-4 4h18" />
                    </svg>
                    <span>${label}</span>
                </a>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>